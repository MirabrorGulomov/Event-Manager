part of 'event_bloc.dart';

@immutable
abstract class EventState {}

class EventInitial extends EventState {}

class EventAdded extends EventState {}

class EventsLoaded extends EventState {
  final List<Event> events;

  EventsLoaded(this.events);
}

class EventOperationSuccess extends EventState {}

class EventEdited extends EventState {}

class EventDeleted extends EventState {}

class EventOperationFailure extends EventState {
  final String error;

  EventOperationFailure(this.error);
}

class DisplayedMonthUpdated extends EventState {
  final DateTime month;

  DisplayedMonthUpdated(this.month);
}
