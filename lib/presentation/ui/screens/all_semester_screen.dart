import 'package:cgpa/presentation/state_holders/average_cgpa_controller.dart';
import 'package:cgpa/presentation/ui/screens/all_semester_result_screen.dart';
import 'package:cgpa/presentation/ui/utils/app_constant.dart';
import 'package:cgpa/presentation/ui/utils/assets_path.dart';
import 'package:cgpa/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:cgpa/presentation/ui/widgets/custom_theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AllSemesterScreen extends StatefulWidget {
  final void Function(ThemeMode) onThemeChanged;

  const AllSemesterScreen({super.key, required this.onThemeChanged});

  @override
  State<AllSemesterScreen> createState() => _AllSemesterScreenState();
}

class _AllSemesterScreenState extends State<AllSemesterScreen> {
  bool isDarkMode = false;
  final TextEditingController _idTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final AverageCgpaController averageCgpaController = Get.find<AverageCgpaController>();

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
                        hintText: "Enter your Student Id",
                        labelText: "Enter your Student Id"
                      ), validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your Student Id ex:221-15-XXXX';
                      } else if (AppConstant.idRegExp.hasMatch(value!) == false) {
                        return 'Enter your Student Id ex:221-15-XXXX';
                      }
                      return null;
                    },
                    ),
                    SizedBox(height: 40),
                    GetBuilder<AverageCgpaController>(
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

    bool isSuccess = await averageCgpaController.getCgpa(studentId);

    if (isSuccess) {
      Get.to(() => AllSemesterResultScreen(), arguments: {
        'cgpaData': averageCgpaController.cgpaData,  // Pass the model here
      });
    } else {
      Get.snackbar('Error', averageCgpaController.errorMassage ?? 'Something went wrong');
    }
  }

  @override
  void dispose() {
    _idTEController.dispose();
    super.dispose();
  }
}
