import 'package:bloc/bloc.dart';
import 'package:event_manager/data/helper/database_helper.dart';
import 'package:event_manager/data/models/event_model.dart';
import 'package:meta/meta.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final DatabaseHelper databaseHelper;
  EventBloc({required this.databaseHelper}) : super(EventInitial()) {
    on<FetchEventsForMonth>((event, emit) async {
      try {
        print("Fetching events for month: ${event.month}");
        List<Event> events =
            await databaseHelper.fetchEventsByMonth(event.month);
        print("Fetched events: $events");
        emit(EventsLoaded(events));
      } catch (e) {
        emit(
          EventsLoaded([]),
        );
      }
    });

    on<AddEvent>((event, emit) async {
      try {
        DateTime eventDate = DateTime.parse(event.event.date);
        List<Event> eventsOnDate =
            await databaseHelper.fetchEventsByDate(eventDate.toString());

        if (eventsOnDate.length < 3) {
          await databaseHelper.createEvent(event.event);
          emit(EventOperationSuccess());
          add(FetchEventsForMonth(eventDate));
        } else {
          emit(EventOperationFailure("Maximum of 3 events per day exceeded"));
        }
      } catch (e) {
        print(e.toString());
        emit(EventOperationFailure("Failed to add event: ${e.toString()}"));
      }
    });
    on<EditEvent>((event, emit) async {
      try {
        await databaseHelper.updateEvent(event.event);
        emit(EventEdited());
        add(FetchEventsForMonth(DateTime.parse(event.event.date)));
      } catch (e) {
        emit(EventOperationFailure("Failed to edit event: ${e.toString()}"));
      }
    });

    on<DeleteEvent>((event, emit) async {
      try {
        await databaseHelper.deleteEvent(event.event.id!);
        emit(EventDeleted());
        add(FetchEventsForMonth(DateTime.parse(event.event.date)));
      } catch (e) {
        emit(EventOperationFailure("Failed to delete event: ${e.toString()}"));
      }
    });

    on<UpdateDisplayedMonth>((event, emit) async {
      emit(DisplayedMonthUpdated(event.month));
      add(FetchEventsForMonth(event.month));
    });
  }
}
