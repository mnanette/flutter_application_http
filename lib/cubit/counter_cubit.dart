import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
 

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());
}
