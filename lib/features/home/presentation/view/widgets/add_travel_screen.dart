import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/methods/toast.dart';
import 'package:fun_adventure/cores/utils/custom_textfield_rounded_border.dart';
import 'package:fun_adventure/cores/utils/custom_textformfield_underline.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/custom_textbutton.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../constants.dart';
import '../../../../../cores/methods/show_date_picker.dart';

class AddTravelScreen extends StatefulWidget {
  const AddTravelScreen({super.key});

  @override
  State<AddTravelScreen> createState() => _AddTravelScreenState();
}

class _AddTravelScreenState extends State<AddTravelScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double lastScrollOffset = 0.0;

  late DateTime date;
  final TextEditingController travelNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController placesController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    date = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context, {DateTime? dateX}) async {
    var x = await showDatePickerMethod(context, dateX: dateX);
    if (x != null) {
      date = x;
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
        body: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                width: context.width,
                height: context.height * .75,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fill This Fields :',
                              style: GoogleFonts.aBeeZee()
                                  .copyWith(fontSize: 20.sp),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            CustomTextFieldUnderline(
                              hint: 'Travel Name',
                              icon: const Icon(Icons.note_alt),
                              textColor: Colors.black,
                              borderColor: Colors.black,
                              controller: travelNameController,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextFieldUnderline(
                              hint: 'Location',
                              icon: const Icon(Icons.location_on),
                              textColor: Colors.black,
                              borderColor: Colors.black,
                              controller: locationController,
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
                                        keyboardType: TextInputType.none,
                                        controller: fromDateController,
                                        onTap: () async {
                                          if (fromDateController
                                              .text.isNotEmpty) {
                                            toDateController.text = '';
                                          }

                                          await _selectDate(context,
                                              dateX: date);
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
                                      keyboardType: TextInputType.none,
                                      onTap: () async {
                                        await _selectDate(context,
                                            dateX: DateTime.parse(
                                                fromDateController.text));
                                        toDateController.text =
                                            DateFormat('yyyy-MM-dd')
                                                .format(date);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: context.height * .1,
                                    width: context.width * .45,
                                    child: CustomTextFieldUnderline(
                                      hint: 'Duration',
                                      icon: const Icon(Icons.timelapse),
                                      textColor: Colors.black,
                                      borderColor: Colors.black,
                                      controller: durationController,
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    height: context.height * .1,
                                    width: context.width * .33,
                                    child: CustomTextFieldUnderline(
                                      hint: 'Price',
                                      icon: const Icon(Icons.timelapse),
                                      textColor: Colors.black,
                                      borderColor: Colors.black,
                                      controller: priceController,
                                      keyboardType: TextInputType.number,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            CustomTextFieldRoundedBorder(
                              hint: 'Description',
                              icon: const Icon(Icons.description_outlined),
                              textColor: Colors.black,
                              borderColor: Colors.black,
                              controller: descriptionController,
                              maxLines: 4,
                              minLines: 1,
                              textInputAction: TextInputAction.newline,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CustomTextButton(
                                  text: 'Add Travel',
                                  textSize: 20.sp,
                                  buttonColor: Colors.indigo,
                                  topLeft: const Radius.circular(15),
                                  bottomLeft: const Radius.circular(15),
                                  bottomRight: const Radius.circular(15),
                                  topRight: const Radius.circular(5),
                                  onPressed: () {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      addNewTravel();
                                    } else {}
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> addNewTravel() async {
    if (LocatorManager.locator<AppMainScreenCubit>()
            .internetConnection
            .connectionStatus
            .name !=
        'none') {
      showToast(
          msg: 'Waiting Please To Add Travel',
          toastMessageType: ToastMessageType.waitingMessage,
          textColor: Colors.black);
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('travels')
          .add({
        'title': travelNameController.text,
        'location': locationController.text,
        'fromDate': fromDateController.text,
        'toDate': toDateController.text,
        'time': durationController.text,
        'price': priceController.text,
        'description': descriptionController.text
      }).then((value) {
        showToast(
            msg: 'Successfully Add New Travel',
            toastMessageType: ToastMessageType.successMessage);
      }).catchError((error) {
        showToast(
            msg: 'Fail To Add New Travel',
            toastMessageType: ToastMessageType.failureMessage);
        if (kDebugMode) {
          print(error.toString());
        }
      });
    } else {
      showToast(
          msg: 'There is No An Internet Connection',
          toastMessageType: ToastMessageType.failureMessage);
    }
  }
}
