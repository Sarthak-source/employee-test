import 'package:employee_test/modals/items.dart';
import 'package:employee_test/screen/employee_detail.dart';
import 'package:flutter/material.dart';

class EmployeeItemWidget extends StatelessWidget {
  final Item item;

  const EmployeeItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeDetailsScreen(item: item),
          ),
        );
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(item.imageUrl),
            radius: 30,
          ),
          const SizedBox(
            width: 20,
          ),
          Text("${item.firstName} ${item.lastName}")
        ],
      ),
    );
  }
}
