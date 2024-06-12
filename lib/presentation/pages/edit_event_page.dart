import 'package:event_manager/data/models/event_model.dart';
import 'package:event_manager/presentation/bloc/event/event_bloc.dart';
import 'package:event_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EditEventPage extends StatefulWidget {
  final Event event;
  const EditEventPage({Key? key, required this.event}) : super(key: key);

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  late TextEditingController _timeController;

  Color _selectedColor = AppColors.backgroundRed;

  final List<Color> priorityColors = [
    AppColors.backgroundRed,
    AppColors.backgroundYellow,
    AppColors.backgroundBlue,
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.event.title);
    _descriptionController =
        TextEditingController(text: widget.event.description);
    _locationController = TextEditingController(text: widget.event.location);
    _timeController = TextEditingController(text: widget.event.time);
    _selectedColor = widget.event.color;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _updateEvent() {
    if (_formKey.currentState!.validate()) {
      final updatedEvent = widget.event.copy(
        title: _nameController.text,
        description: _descriptionController.text,
        location: _locationController.text,
        time: _timeController.text,
        color: _selectedColor,
      );

      BlocProvider.of<EventBloc>(context).add(EditEvent(updatedEvent));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text(
              'Event Name',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xff111827),
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _nameController,
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.0.h, horizontal: 10.0.w),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter event name';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            Text(
              'Event Description',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xff111827),
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _descriptionController,
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: 50.h, horizontal: 10.w),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            Text(
              'Event Location',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xff111827),
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _locationController,
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.0.h, horizontal: 10.0.w),
                suffixIcon: const Icon(
                  Icons.location_on,
                  color: AppColors.mainBlue,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter event location';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            Text(
              'Event Color',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xff111827),
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              width: 75.w,
              child: DropdownButtonFormField<Color>(
                value: _selectedColor,
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
                items: priorityColors.map((Color color) {
                  return DropdownMenuItem<Color>(
                    value: color,
                    child: Container(
                      width: 23.w,
                      height: 20.h,
                      color: color,
                    ),
                  );
                }).toList(),
                onChanged: (Color? newValue) {
                  setState(() {
                    _selectedColor = newValue!;
                  });
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Event Time',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xff111827),
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _timeController,
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.0.h, horizontal: 10.0.w),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter event time';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: _updateEvent,
              child: Container(
                height: 46.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.mainBlue,
                ),
                child: Center(
                  child: Text(
                    "Update",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
