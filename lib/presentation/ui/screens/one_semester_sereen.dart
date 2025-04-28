import 'package:cgpa/presentation/state_holders/semester_result_controller.dart';
import 'package:cgpa/presentation/state_holders/student_details_info_controller.dart';
import 'package:cgpa/presentation/ui/screens/one_semester_result_screen.dart';
import 'package:cgpa/presentation/ui/utils/app_constant.dart';
import 'package:cgpa/presentation/ui/utils/assets_path.dart';
import 'package:cgpa/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:cgpa/presentation/ui/widgets/custom_theme_switch.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OneSemesterScreen extends StatefulWidget {
  final void Function(ThemeMode) onThemeChanged;

  const OneSemesterScreen({super.key, required this.onThemeChanged});

  @override
  State<OneSemesterScreen> createState() => _OneSemesterScreenState();
}

class _OneSemesterScreenState extends State<OneSemesterScreen> {
  bool isDarkMode = false;
  String? _selectedSemester;
 final TextEditingController _idTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final SemesterResultController semesterResultController = Get.find<SemesterResultController>();
  final StudentDetailsInfoController studentDetailsInfoController = Get.find<StudentDetailsInfoController>();
  final Map<String, String> _semesterOptions = {
    'Spring 2025': '251',
    'Fall 2024': '243',
    'Summer 2024': '242',
    'Spring 2024': '241',
    'Fall 2023': '233',
    'Summer 2023': '232',
    'Spring 2023': '231',
    'Fall 2022': '223',
    'Summer 2022': '222',
    'Spring 2022': '221',
    'Fall 2021': '213',
    'Summer 2021': '212',
    'Spring 2021': '211',
    'Fall 2020': '203',
    'Summer 2020': '202',
    'Spring 2020': '201',
    'Fall 2019': '193',
    'Summer 2019': '192',
    'Spring 2019': '191',
    'Fall 2018': '183',
    'Summer 2018': '182',
    'Spring 2018': '181',
    'Fall 2017': '173',
    'Summer 2017': '172',
    'Spring 2017': '171',
    'Fall 2016': '163',
    'Summer 2016': '162',
    'Spring 2016': '161',
    'Fall 2015': '153',
    'Summer 2015': '152',
    'Spring 2015': '151',
    'Fall 2014': '143',
    'Summer 2014': '142',
    'Spring 2014': '141',
    'Fall 2013': '133',
    'Summer 2013': '132',
    'Spring 2013': '131',
    'Fall 2012': '123',
    'Summer 2012': '122',
    'Spring 2012': '121',
    'Fall 2011': '113',
    'Summer 2011': '112',
    'Spring 2011': '111',
    'Fall 2010': '103',
    'Summer 2010': '102',
    'Spring 2010': '101',
    'Fall 2009': '093',
    'Summer 2009': '092',
    'Spring 2009': '091',
    'Fall 2008': '083',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Align(
                alignment: Alignment.topRight,
                child: CustomThemeSwitch(
                  isDarkMode: isDarkMode,
                  onToggle: (bool value) {
                    setState(() {
                      isDarkMode = value;
                    });
                    if (isDarkMode) {
                      widget.onThemeChanged(ThemeMode.dark);
                    } else {
                      widget.onThemeChanged(ThemeMode.light);
                    }
                  },
                ),
              ),
              SvgPicture.asset(AssetsPath.appLogo, width: 220),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _idTEController,
                      keyboardType:TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "Enter your Student ID",
                        labelText: "Enter your Student ID",
                      ),
                      style: TextStyle(color: isDarkMode?Colors.white:Colors.black),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your Student Id ex:221-15-XXXX';
                        } else if (AppConstant.idRegExp.hasMatch(value!) == false) {
                          return 'Enter your Student Id ex:221-15-XXXX';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    _buildDropDownMenu(),
                    SizedBox(height: 24),
                    GetBuilder<SemesterResultController>(
                      builder: (semesterResultController) {
                        return Visibility(
                          visible: !semesterResultController.inProgress,
                          replacement: CenteredCircularProgressIndicator(),
                          child: ElevatedButton(
                            onPressed: _onTapNextButton,
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(150, 50),
                            ),
                            child: Icon(
                              Icons.navigate_next,
                              color: Colors.black,
                              size: 32,
                            ),
                          ),
                        );
                      }
                    )
                  ],
                ),
              ),
              Expanded(
                child: SvgPicture.asset(AssetsPath.bottomLogo, width: 220),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapNextButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    String studentId = _idTEController.text.trim();
    String? semesterCode = _semesterOptions[_selectedSemester];
    if (semesterCode == null) {
      Get.snackbar('Error', 'Please select a semester.');
      return;
    }
    bool isSuccess = await semesterResultController.getSemesterResult(
        semesterCode, studentId);
    bool isSuccessStudentDetails = await studentDetailsInfoController
        .getStudentInfo(studentId);
    if (isSuccess && isSuccessStudentDetails ) {
      Get.to(() =>
          OneSemesterResultScreen(
            semesterDetailsList: semesterResultController.sgpa,
            studentInfoDetails: studentDetailsInfoController.studentInfo,));
    } else {
      Get.snackbar('Error',
          semesterResultController.errorMassage ?? 'Something went wrong');
    }
  }

  Widget _buildDropDownMenu() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          value: _selectedSemester,
          hint: Text(
            "Select a Semester",
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
          onChanged: (String? newValue) {
            setState(() {
              _selectedSemester = newValue;
            });
          },
          items:
          _semesterOptions.keys.map((String key) {
            return DropdownMenuItem<String>(
              value: key,
              child: Text(
                key,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            );
          }).toList(),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 150,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            offset: Offset(0, 4),
            elevation: 4,
          ),
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black87,
              size: 30,
            ),
          ),
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 60,
            width: double.maxFinite,
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _idTEController.dispose();
    super.dispose();
  }
}
