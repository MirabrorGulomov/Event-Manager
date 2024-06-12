part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class AddEvent extends EventEvent {
  final Event event;

  AddEvent(this.event);
}

class FetchEventsForMonth extends EventEvent {
  final DateTime month;
  FetchEventsForMonth(this.month);
}

class FetchEventsByDate extends EventEvent {
  final String date;

  FetchEventsByDate(this.date);
}

class EditEvent extends EventEvent {
  final Event event;
  EditEvent(this.event);
}

class UpdateDisplayedMonth extends EventEvent {
  final DateTime month;

  UpdateDisplayedMonth(this.month);
}

class DeleteEvent extends EventEvent {
  final Event event;
  DeleteEvent(this.event);
}
