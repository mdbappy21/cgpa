import 'package:cgpa/data/model/course_model.dart';
import 'package:cgpa/data/model/semester.dart';
import 'package:cgpa/presentation/ui/widgets/app_drawer.dart';
import 'package:cgpa/presentation/ui/widgets/cgpa_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SemesterResultDetailsScreen extends StatefulWidget {
  const SemesterResultDetailsScreen({super.key});

  @override
  State<SemesterResultDetailsScreen> createState() =>
      _SemesterResultDetailsScreenState();
}

class _SemesterResultDetailsScreenState extends State<SemesterResultDetailsScreen> {
  late Semesters semester;
  @override
  void initState() {
    super.initState();
    semester = Get.arguments as Semesters;
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              _buildSemesterInformationSection(context),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: semester.courses?.length ?? 0,
                itemBuilder: (context, index) {
                  final course = semester.courses![index];
                  return _buildCourseResultCard(context,course);
                },
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }

  Widget _buildCourseResultCard(BuildContext context, Courses course) {
    return Card(
      color: colorPicker(course),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _buildCourseResultInfo(context,course)),
            _buildCreditContainer(course.credits),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseResultInfo(BuildContext context,Courses course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${course.code}', style: Theme.of(context).textTheme.titleMedium),
        Text('${course.title}', style: Theme.of(context).textTheme.titleMedium?.copyWith(overflow: TextOverflow.ellipsis),),
        Text('Grade : ${course.grade}', style: Theme.of(context).textTheme.titleMedium,),
        Text('Grade Point: ${course.cgpa}', style: Theme.of(context).textTheme.titleMedium,),
      ],
    );
  }
  Color colorPicker(Courses course){
    if(course.cgpa==4){
      return Colors.green;
    }else if(course.cgpa==3.75){
      return Colors.lightGreen;
    }else if(course.cgpa==3.5){
      return Colors.lime;
    }else if(course.cgpa==3.25){
      return Colors.yellow;
    }else if(course.cgpa==3){
      return Colors.amber;
    }else if(course.cgpa==2.75){
      return Colors.orange;
    }else if(course.cgpa==2.5){
      return Colors.deepOrange.shade500;
    }else if(course.cgpa==2.25){
      return Colors.deepOrange.shade700;
    }else if(course.cgpa==2){
      return Colors.red;
    }
    else{
      return Colors.grey.shade300;
      // return Colors.red;
    }

  }

  Widget _buildCreditContainer(double? credit) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Center(child: Text("$credit", textAlign: TextAlign.center)),
    );
  }

  Widget _buildSemesterInformationSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Semester Information",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text("Credit : ${semester.semesterCredits}",
                      style: Theme.of(context).textTheme.titleMedium),
                  Text("SGPA : ${semester.semesterCGPA}",
                      style: Theme.of(context).textTheme.titleMedium),
                  Text("Semester : ${semester.semester}",
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              CgpaIndicator(
                cgpa:semester.semesterCGPA!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
