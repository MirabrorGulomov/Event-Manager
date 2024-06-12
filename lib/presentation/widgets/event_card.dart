import 'package:event_manager/data/models/event_model.dart';
import 'package:event_manager/presentation/pages/event_details_page.dart'; // Ensure this import is correct
import 'package:event_manager/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final String title;
  final String description;
  final String time;
  final String location;
  const EventCard({
    super.key,
    required this.event,
    required this.title,
    required this.description,
    required this.time,
    required this.location,
  });

  Color getBackgroundColor() {
    return event.color;
  }

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

  Color getDescriptionColor() {
    if (event.color == AppColors.backgroundRed) {
      return AppColors.secondaryRed;
    } else if (event.color == AppColors.backgroundYellow) {
      return AppColors.secondaryYellow;
    } else if (event.color == AppColors.backgroundBlue) {
      return AppColors.secondaryBlue;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return EventDetailsPage(
                event: event,
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
            color: event.color, borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          children: [
            Container(
              height: 10.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
                color: getTextColor(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: getDescriptionColor(),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 8,
                      color: getDescriptionColor(),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: getDescriptionColor(),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            time,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: getDescriptionColor(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 8.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: getDescriptionColor(),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            location,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: getDescriptionColor(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
