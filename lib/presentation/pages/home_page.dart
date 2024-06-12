import 'package:event_manager/presentation/bloc/event/event_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_manager/presentation/widgets/custom_calendart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String dayOfWeek = getDayOfWeek(now.weekday);
    String formattedDate = formatDate(now);
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 130.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            dayOfWeek,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                formattedDate,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              GestureDetector(
                                onTap: () => _showFilterDialog(context),
                                child: Image.asset(
                                  "assets/images/arrow.png",
                                  fit: BoxFit.cover,
                                  height: 14,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: 80.w,
                      ),
                      Image.asset(
                        "assets/images/notification.png",
                        height: 30,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Expanded(child: CustomCalendar(selectedDate: now)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Filter'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffF3F4F6),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: Color(0xffF3F4F6),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: Color(0xffF3F4F6),
                      ),
                    ),
                  ),
                  items: List.generate(3001, (index) {
                    return DropdownMenuItem<int>(
                      value: 1950 + index,
                      child: Text((1950 + index).toString()),
                    );
                  }).toList(),
                  onChanged: (int? year) {
                    if (year != null) {
                      Navigator.of(context).pop();
                      _showMonthDialog(context, year);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMonthDialog(BuildContext context, int year) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Month'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(12, (index) {
                return ListTile(
                  title: Text(getMonthName(index + 1)),
                  onTap: () {
                    Navigator.of(context).pop();
                    BlocProvider.of<EventBloc>(context).add(
                      UpdateDisplayedMonth(DateTime(year, index + 1)),
                    );
                  },
                );
              }),
            ),
          ),
        );
      },
    );
  }

  String getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }

  String formatDate(DateTime dateTime) {
    String day = dateTime.day.toString().padLeft(2, "0");
    String month = getMonthName(dateTime.month);
    String year = dateTime.year.toString();
    return "$day $month $year";
  }
}
