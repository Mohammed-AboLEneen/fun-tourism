import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/custom_textformfield_underline.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddTravelScreen extends StatefulWidget {
  const AddTravelScreen({super.key});

  @override
  State<AddTravelScreen> createState() => _AddTravelScreenState();
}

class _AddTravelScreenState extends State<AddTravelScreen> {
  late DateTime date;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    date = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context, {DateTime? dateX}) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dateX ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.red, // Change OK button color
                hintColor: Colors.green, // Change Cancel button color
              ),
              child: child!);
        });

    if (pickedDate != null && pickedDate != date) {
      setState(() {
        date = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Your Travel',
            style: GoogleFonts.akayaKanadaka(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: context.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fill This Fields :',
                            style:
                                GoogleFonts.aBeeZee().copyWith(fontSize: 20.sp),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          SizedBox(
                            height: context.height * .1,
                            child: const CustomTextFieldUnderline(
                              hint: 'Travel Name',
                              icon: Icon(Icons.note_alt),
                              textColor: Colors.black,
                              borderColor: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: context.height * .1,
                                  width: context.width * .4,
                                  child: CustomTextFieldUnderline(
                                      hint: 'From',
                                      icon: const Icon(Icons.timelapse),
                                      textColor: Colors.black,
                                      borderColor: Colors.black,
                                      controller: fromDateController,
                                      onTap: () async {
                                        await _selectDate(context, dateX: date);
                                        fromDateController.text =
                                            DateFormat('yyyy-MM-dd')
                                                .format(date);
                                      }),
                                ),
                                const Spacer(),
                                SizedBox(
                                  height: context.height * .1,
                                  width: context.width * .4,
                                  child: CustomTextFieldUnderline(
                                    hint: 'To',
                                    icon: const Icon(Icons.timelapse),
                                    textColor: Colors.black,
                                    borderColor: Colors.black,
                                    controller: toDateController,
                                    onTap: () async {
                                      await _selectDate(context,
                                          dateX: DateTime.parse(
                                              fromDateController.text));
                                      toDateController.text =
                                          DateFormat('yyyy-MM-dd').format(date);
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: context.height * .1,
              )
            ],
          ),
        ));
  }
}
