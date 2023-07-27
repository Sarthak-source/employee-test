import 'package:employee_test/modals/items.dart';
import 'package:flutter/material.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final Item item;

  const EmployeeDetailsScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details',style:  TextStyle(color: Colors.black),),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              CircleAvatar(
                backgroundImage: NetworkImage(item.imageUrl),
                radius: 60,
              ),
              const SizedBox(height: 20),
              Text(
                "${item.firstName} ${item.lastName}",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              DataTable(
                columnSpacing: 20.0,
                columns: const [
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                ],
                rows: [
                  DataRow(cells: [
                    const DataCell(Text('Email')),
                    DataCell(Text(item.email)),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Contact Number')),
                    DataCell(Text(item.contactNumber)),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Age')),
                    DataCell(Text(item.age.toString())),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Date of Birth')),
                    DataCell(Text(item.dob)),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Salary')),
                    DataCell(Text(item.salary.toString())),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Address')),
                    DataCell(Text(item.address)),
                  ]),
                  // Add more rows as needed.
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
