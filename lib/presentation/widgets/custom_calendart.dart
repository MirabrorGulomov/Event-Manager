import 'package:event_manager/presentation/bloc/event/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:event_manager/data/models/event_model.dart';
import 'package:event_manager/utils/colors.dart';
import 'package:event_manager/presentation/pages/add_event_page.dart';
import 'package:event_manager/presentation/widgets/event_card.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime selectedDate;
  const CustomCalendar({Key? key, required this.selectedDate})
      : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime displayedMonth;
  late DateTime selectedDate;
  List<Event> monthlyEvents = [];
  List<Event> selectedDayEvents = [];

  @override
  void initState() {
    super.initState();
    displayedMonth = widget.selectedDate;
    selectedDate = widget.selectedDate;
    _fetchMonthlyEvents();
  }

  void _fetchMonthlyEvents() {
    print(
        "Fetching events for month: ${displayedMonth.month} ${displayedMonth.year}");
    BlocProvider.of<EventBloc>(context)
        .add(FetchEventsForMonth(displayedMonth));
  }

  void _previousMonth() {
    setState(() {
      displayedMonth = DateTime(displayedMonth.year, displayedMonth.month - 1);
      print(
          "Previous month selected: ${displayedMonth.month} ${displayedMonth.year}");
      _fetchMonthlyEvents();
    });
  }

  void _nextMonth() {
    setState(() {
      displayedMonth = DateTime(displayedMonth.year, displayedMonth.month + 1);
      print(
          "Next month selected: ${displayedMonth.month} ${displayedMonth.year}");
      _fetchMonthlyEvents();
    });
  }

  String getMonth(int month) {
    return [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ][month - 1];
  }

  void onSelectDay(DateTime day) {
    setState(() {
      selectedDate = day;
      selectedDayEvents = monthlyEvents
          .where((event) => isSameDay(DateTime.parse(event.date), day))
          .toList();
      print("Selected day: $day with events: $selectedDayEvents");
    });
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventBloc, EventState>(
      listener: (context, state) {
        if (state is DisplayedMonthUpdated) {
          setState(() {
            displayedMonth = state.month;
            _fetchMonthlyEvents();
          });
        } else if (state is EventsLoaded) {
          setState(() {
            monthlyEvents = state.events;
            selectedDayEvents = monthlyEvents
                .where((event) =>
                    isSameDay(DateTime.parse(event.date), selectedDate))
                .toList();
          });
        }
      },
      child: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${getMonth(displayedMonth.month)} ${displayedMonth.year}",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _previousMonth,
                          child: Container(
                            height: 23,
                            width: 23,
                            decoration: BoxDecoration(
                              color: Color(0xffEFEFEF),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Image.asset("assets/images/vector.jpg"),
                          ),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: _nextMonth,
                          child: Container(
                            height: 23,
                            width: 23,
                            decoration: BoxDecoration(
                              color: Color(0xffEFEFEF),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Image.asset("assets/images/vector2.jpg"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                      .map(
                        (day) => Text(
                          day,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Color(0xff969696),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 10.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),
                  itemCount:
                      DateTime(displayedMonth.year, displayedMonth.month + 1, 0)
                          .day,
                  itemBuilder: (context, index) {
                    DateTime date = DateTime(
                        displayedMonth.year, displayedMonth.month, index + 1);
                    var dayEvents = monthlyEvents
                        .where((element) =>
                            isSameDay(DateTime.parse(element.date), date))
                        .toList();
                    bool isSelected = selectedDate == date;
                    return GestureDetector(
                      onTap: () {
                        onSelectDay(date);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? AppColors.mainBlue
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                "${date.day}",
                                style: GoogleFonts.poppins(
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  fontSize: 12,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xff292929),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Row(
                              children: dayEvents
                                  .take(3)
                                  .map((e) => Container(
                                        height: 5,
                                        width: 5,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 3),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: e.color,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Schedule",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff292929),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return AddEventPage(selectedDate: selectedDate);
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 102.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: AppColors.mainBlue,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            "+ Add Event",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: selectedDayEvents.length,
                  itemBuilder: (context, index) {
                    Event event = selectedDayEvents[index];
                    return EventCard(
                      event: event,
                      title: event.title,
                      description: event.description,
                      time: event.time,
                      location: event.location,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
