import 'package:cgpa/data/model/cgpa_model.dart';
import 'package:cgpa/data/model/semester.dart';
import 'package:cgpa/presentation/state_holders/theme_controller.dart';
import 'package:cgpa/presentation/ui/screens/semester_result_details_screen.dart';
import 'package:cgpa/presentation/ui/widgets/app_drawer.dart';
import 'package:cgpa/presentation/ui/widgets/cgpa_indicator.dart';
import 'package:cgpa/presentation/ui/widgets/dynamic_cgpa_curve_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AllSemesterResultScreen extends StatefulWidget {
  AllSemesterResultScreen({super.key});
  final CgpaModel cgpaData = Get.arguments['cgpaData'];
  @override
  State<AllSemesterResultScreen> createState() =>
      _AllSemesterResultScreenState();
}

class _AllSemesterResultScreenState extends State<AllSemesterResultScreen> {
  final ThemeController themeController = Get.find<ThemeController>();
  List<Map<String, dynamic>> _getSemesterResults() {
    return widget.cgpaData.semesters?.map((semester) {
      return {
        "semester": semester.semester, // Make sure Semesters model has `name`
        "cgpa": semester.semesterCGPA, // Handle if cgpa might be null
      };
    }).toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DIU CGPA"),
        actions: [Icon(Icons.picture_as_pdf), SizedBox(width: 16)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              _buildPersonalInformationSection(),
              _buildSemesterInformationSection(),
              SizedBox(height: 32),
              Container(
                color: themeController.isDarkMode.value ? Colors.black12 : null,
                padding: EdgeInsets.all(16),
                child: DynamicCGPACurveChart(
                  semesterResults: _getSemesterResults(),
                ),
              ),

              SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1.8,
                ),
                itemCount: widget.cgpaData.semesters?.length ?? 0,
                itemBuilder: (context, index) {
                  Semesters semester = widget.cgpaData.semesters![index];
                  return _buildSemesterOverviewResult(context, semester);
                },
              ),
              SizedBox(height: 8)
            ],
          ),
        ),
      ),
        drawer: AppDrawer()

    );
  }

  Widget _buildSemesterOverviewResult(BuildContext context, Semesters semester) {
    return GestureDetector(
      onTap: (){
        Get.to(
          const SemesterResultDetailsScreen(),
          arguments: semester,
        );
      },
      child: Card(
        elevation: 2,
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${semester.semesterCGPA}", textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge
            ),
            SizedBox(height: 8),
            Text("${semester.semester}",
                style: Theme.of(context).textTheme.titleSmall
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSemesterInformationSection() {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        elevation: 2,
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Semester Information", style: Theme.of(context).textTheme.titleLarge,),
                    Text("Student Id : ${widget.cgpaData.student!.id}",
                      style: Theme.of(context).textTheme.titleMedium,),
                    Text("Credit : ${widget.cgpaData.totalCredits}",
                      style: Theme.of(context).textTheme.titleMedium,),
                    Text("Semester : ${widget.cgpaData.semesters?.length}",
                      style: Theme.of(context).textTheme.titleMedium,),
                    Text("Year : ${widget.cgpaData.student!.year}",
                      style: Theme.of(context).textTheme.titleMedium,),
                    Text("Batch : ${widget.cgpaData.student!.batch}",
                      style: Theme.of(context).textTheme.titleMedium,),
                  ],
                ),
              ),
              CgpaIndicator(
                cgpa: widget.cgpaData.finalCGPA!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInformationSection() {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        elevation: 2,
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal Information",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              Text("Name : ${widget.cgpaData.student!.name}",
                style: Theme.of(context).textTheme.titleMedium,),
              Text("Program : ${widget.cgpaData.student!.program}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(overflow: TextOverflow.ellipsis),),
              Text("Campus : ${widget.cgpaData.student!.campus}",
                style: Theme.of(context).textTheme.titleMedium,),
              Text("Shift : ${widget.cgpaData.student!.shift}",
                style: Theme.of(context).textTheme.titleMedium,),
              Text("Department :${widget.cgpaData.student!.department} ",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(overflow: TextOverflow.ellipsis),),
              Text("Faculty : ${widget.cgpaData.student!.faculty}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(overflow: TextOverflow.ellipsis),),
            ],
          ),
        ),
      ),
    );
  }
}

