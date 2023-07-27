import 'package:employee_test/modals/items.dart';
import 'package:employee_test/modals/pagiantion.dart';
import 'package:employee_test/service/fetch_data.dart';
import 'package:employee_test/widgets/alphabet_list.dart';
import 'package:employee_test/widgets/employee_item.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Debouncer {
  Debouncer({required this.milliseconds});
  final int milliseconds;
  Timer? _timer;
  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class EmployeesScreen extends StatefulWidget {
  final String title;

  const EmployeesScreen({super.key, required this.title});

  @override
  State<EmployeesScreen> createState() => EmployeesScreenState();
}

class EmployeesScreenState extends State<EmployeesScreen> {
  final itemHeight = 80.0;
  int pageSize = 50;
  int currentPage = 1;
  List<Item> fetchedData = [];
  final ScrollController scrollController = ScrollController();

  // Define a debounce function to call scrollToLastItem with a delay of 200ms
  final Debouncer _debouncer = Debouncer(milliseconds: 2000);

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;

      if (maxScroll == currentScroll) {
        _debouncer.run(() {
          setState(() {
            pageSize = pageSize + 50;
          });
          scrollToLastItem();
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: MockDataService.fetchData(1, pageSize),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final PaginatedData paginatedData = snapshot.data!;
            
            final List<Item> newData = paginatedData.items;
                  newData.sort((a, b) => a.firstName.compareTo(b.firstName));

            fetchedData.addAll(newData);
            return Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AlphabetListView(
                      itemHeight: itemHeight,
                      items: fetchedData,
                      itemBuilder: (context, index) =>
                          EmployeeItemWidget(item: fetchedData[index]),
                      scrollController: scrollController,
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  void scrollToLastItem() {
    if (scrollController.hasClients) {
      // Calculate the maximum scroll extent to reach the last item
      double maxScrollExtent = scrollController.position.maxScrollExtent;

      // Scroll to the last item
      scrollController.animateTo(
        maxScrollExtent,
        duration:
            const Duration(milliseconds: 500), // Adjust the duration as needed
        curve: Curves.easeOut, // Adjust the curve as needed
      );
    }
  }
}
