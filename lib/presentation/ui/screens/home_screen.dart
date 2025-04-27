import 'package:cgpa/presentation/ui/screens/all_semester_screen.dart';
import 'package:cgpa/presentation/ui/screens/one_semester_sereen.dart';
import 'package:cgpa/presentation/ui/utils/app_color.dart';
import 'package:cgpa/presentation/ui/utils/assets_path.dart';
import 'package:cgpa/presentation/ui/widgets/custom_theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final void Function(ThemeMode) onThemeChanged;

  const HomeScreen({super.key, required this.onThemeChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: CustomThemeSwitch(
                isDarkMode: isDarkMode,
                onToggle: (bool value) {
                  setState(() {isDarkMode = value;});
                  if (isDarkMode) {
                    widget.onThemeChanged(ThemeMode.dark);
                  } else {
                    widget.onThemeChanged(ThemeMode.light);
                  }
                },
              ),
            ),
          ),
          SvgPicture.asset(AssetsPath.appLogo, width: 220),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 8,),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => OneSemesterScreen(onThemeChanged: widget.onThemeChanged));
                  },
                  child: Text(
                    "One Semester SGPA",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.themeColor1
                    ),
                  ),
                ),
                SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => AllSemesterScreen(onThemeChanged: widget.onThemeChanged));
                  },
                  child: Text(
                    "Average CGPA",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.themeColor2
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: SvgPicture.asset(AssetsPath.bottomLogo, width: 220)),
        ],
      ),
    );
  }
}
