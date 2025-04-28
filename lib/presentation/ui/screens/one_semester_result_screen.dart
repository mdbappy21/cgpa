import 'package:cgpa/data/model/semester_details_model.dart';
import 'package:cgpa/data/model/student_details_info_model.dart';
import 'package:cgpa/presentation/ui/utils/app_color.dart';
import 'package:cgpa/presentation/ui/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class OneSemesterResultScreen extends StatefulWidget {
  final List<SemesterDetailsModel> semesterDetailsList;
  final StudentDetailsInfoModel studentInfoDetails;

  const OneSemesterResultScreen({super.key, required this.semesterDetailsList, required this.studentInfoDetails});

  @override
  State<OneSemesterResultScreen> createState() =>
      _OneSemesterResultScreenState();
}

class _OneSemesterResultScreenState extends State<OneSemesterResultScreen> {
  double totalCredit=0;
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
              _buildPersonalInformationSection(context),
              SizedBox(height: 8),
              _buildSemesterInformationSection(),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: widget.semesterDetailsList.length,
                itemBuilder: (context, index) {
                  SemesterDetailsModel semester = widget.semesterDetailsList[index];
                  return _buildCourseResultCard(semester);
                },
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }

  Widget _buildCourseResultCard(SemesterDetailsModel semester) {
    return Card(
      color: ColorPicker(semester),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCourseResultInfo(semester),
            _buildCreditContainer(semester),
          ],
        ),
      ),
    );
  }
  Widget _buildCourseResultInfo(SemesterDetailsModel semester) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${semester.customCourseId}', style: Theme.of(context).textTheme.titleMedium),
        Text('${semester.courseTitle}', style: Theme.of(context).textTheme.titleMedium,),
        Text('Grade Letter: ${semester.gradeLetter}', style: Theme.of(context).textTheme.titleMedium,),
        Text('Grade Point: ${semester.pointEquivalent}', style: Theme.of(context).textTheme.titleMedium,),
      ],
    );
  }

  Color ColorPicker(SemesterDetailsModel semester){
    if(semester.pointEquivalent==4){
      return Colors.green;
    }else if(semester.pointEquivalent==3.75){
      return Colors.purple;
    }else if(semester.pointEquivalent==3.5){
      return Colors.amber;
    }else if(semester.pointEquivalent==3.25){
      return Colors.blue;
    }else if(semester.pointEquivalent==3){
      return Colors.cyan;
    }else if(semester.pointEquivalent==2.75){
      return Colors.teal;
    }else if(semester.pointEquivalent==2.5){
      return Colors.brown;
    }else if(semester.pointEquivalent==2.25){
      return Colors.blueGrey;
    }else if(semester.pointEquivalent==2){
      return Colors.grey.shade300;
    }
    else{
      // return Colors.grey.shade300;
      return Colors.red;
    }

  }

  Widget _buildCreditContainer(SemesterDetailsModel semester) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.orange,
      ),
      child: Center(child: Text("${semester.totalCredit}", textAlign: TextAlign.center)),
    );
  }

  Widget _buildSemesterInformationSection() {
    SemesterDetailsModel semester = widget.semesterDetailsList[0];
    double totalCredit = calculateTotalCredit(widget.semesterDetailsList);
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Semester Information", style: Theme.of(context).textTheme.titleLarge?.copyWith(color:AppColors.themeColor2),),
              SizedBox(height: 8),
              Text("Student Id : ${semester.studentId}",style: Theme.of(context).textTheme.titleMedium?.copyWith(color:AppColors.themeColor1)),
              Text("Credit :$totalCredit ",style: Theme.of(context).textTheme.titleMedium?.copyWith(color:AppColors.themeColor1)),
              Text("Semester : ${semester.semesterName}-${semester.semesterYear}",style: Theme.of(context).textTheme.titleMedium?.copyWith(color:AppColors.themeColor1)),
              Text("Year : ${semester.semesterYear}",style: Theme.of(context).textTheme.titleMedium?.copyWith(color:AppColors.themeColor1)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInformationSection(BuildContext context) {
    StudentDetailsInfoModel student = widget.studentInfoDetails;
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Personal Information", style: Theme.of(context).textTheme.titleLarge?.copyWith(color:AppColors.themeColor2),),
              SizedBox(height: 8),
              Text("Name : ${student.studentName}",style: Theme.of(context).textTheme.titleMedium?.copyWith(color:AppColors.themeColor1)),
              Text("Program ${student.programName}: ",style: Theme.of(context).textTheme.titleMedium?.copyWith(color:AppColors.themeColor1)),
              Text("Campus :${student.campusName} ",style: Theme.of(context).textTheme.titleMedium?.copyWith(color:AppColors.themeColor1)),
              Text("Shift : ${student.shift}",style: Theme.of(context).textTheme.titleMedium?.copyWith(color:AppColors.themeColor1)),
              Text("Department : ${student.departmentName}",style: Theme.of(context).textTheme.titleMedium?.copyWith(color:AppColors.themeColor1)),
              Text("Batch : ${student.batchNo}",style: Theme.of(context).textTheme.titleMedium?.copyWith(color:AppColors.themeColor1)),
              Text("Faculty : ${student.facultyName}",style: Theme.of(context).textTheme.titleMedium?.copyWith(color:AppColors.themeColor1)),
            ],
          ),
        ),
      ),
    );
  }


  double calculateTotalCredit(List<SemesterDetailsModel> semesterList) {
    double totalCredit = 0.0;
    for (var semester in semesterList) {
      totalCredit += semester.totalCredit ?? 0.0;  // Add the credit if it's not null
    }
    return totalCredit;
  }
}
