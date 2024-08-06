import 'dart:convert';

import 'package:flutter_application_1/models/employee.dart';
import 'package:flutter/services.dart' show rootBundle;

class EmployeeRepository {
    Future<List<Employee>?> getEmployees() async {
        // Replace this with your actual implementation to fetch employees from a data source
        try {
            var result = await rootBundle.loadString('assets/employees.json');
            var employees = json.decode(result);
            return List<Employee>.from(
                employees.map((employee) => Employee.fromJson(employee)).toList());
        } catch (e) {
            //print('Error fetching employees: $e');
            return null;
        }
    }
}