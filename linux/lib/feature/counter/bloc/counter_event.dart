part of 'counter_bloc.dart';

@immutable
sealed class CounterEvent {}

// navigate
class CounterNavigateSecondPage extends CounterEvent {}

// increment
class CounterIncrementEvent extends CounterEvent {}

// decrement
class CounterDecrementEvent extends CounterEvent {}
