import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/employee.dart';
import 'package:flutter_application_1/repository/employee_repository.dart';
 
// import 'package:meta/meta.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
 final EmployeeRepository _employeeRepository;
  EmployeeBloc(this._employeeRepository) : super(EmployeeLoadingState()) {
    on<LoadEmployeeEvent>((event, emit) async{

      emit(EmployeeLoadingState());
      if (event is LoadEmployeeEvent) {
       await _employeeRepository.getEmployees().then((employees) {
          emit(EmployeeLoadedState(employees!));
        }).catchError((error) {
          emit(EmployeeErrorSate(error.toString()));
        });
      }
 
   
    });
  }
}
