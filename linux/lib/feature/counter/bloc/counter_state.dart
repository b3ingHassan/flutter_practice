part of 'counter_bloc.dart';

@immutable
abstract class CounterState {}
abstract class CounterActionState extends CounterState {}


 class CounterInitial extends CounterState {}



// navigate state

class CounterNavigateSecondPageActionState extends CounterState {
  
}


// increment state
class CounterIncrementActionState extends CounterState {
  
}

// decrement state

class CounterDecremenActiontState extends CounterState {
  
}