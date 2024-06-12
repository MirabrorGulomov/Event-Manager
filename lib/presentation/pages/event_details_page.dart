import 'package:event_manager/data/models/event_model.dart';
import 'package:event_manager/presentation/bloc/event/event_bloc.dart';
import 'package:event_manager/presentation/pages/edit_event_page.dart';
import 'package:event_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;
  const EventDetailsPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    Color getTextColor() {
      if (event.color == AppColors.backgroundRed) {
        return AppColors.mainRed;
      } else if (event.color == AppColors.backgroundYellow) {
        return AppColors.mainYellow;
      } else if (event.color == AppColors.backgroundBlue) {
        return AppColors.mainBlue;
      } else {
        return Colors.black;
      }
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 248.h,
            decoration: BoxDecoration(
              color: event.color,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 40.h,
                            width: 40.w,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset("assets/images/left.jpg"),
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditEventPage(event: event),
                              ),
                            );

                            if (result == true) {
                              BlocProvider.of<EventBloc>(context).add(
                                  FetchEventsForMonth(
                                      DateTime.parse(event.date)));
                            }
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Edit",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      event.title,
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      event.description,
                      style: GoogleFonts.poppins(
                        fontSize: 8,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_filled,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          event.time,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          event.location,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Reminder",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "15 minutes before",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff7C7B7B),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Description",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus vel ex sit amet neque dignissim mattis non eu est. Etiam pulvinar est mi, et porta magna accumsan nec. Ut vitae urna nisl. Integer gravida sollicitudin massa, ut congue orci posuere sit amet. Aenean laoreet egestas est, ut auctor nulla suscipit non. ",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff999999),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 90.h,
            ),
            height: 54.h,
            decoration: BoxDecoration(
              color: event.color,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  BlocProvider.of<EventBloc>(context).add(DeleteEvent(event));
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.delete_rounded,
                  color: getTextColor(),
                ),
                label: Text(
                  "Delete Event",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff292929),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
