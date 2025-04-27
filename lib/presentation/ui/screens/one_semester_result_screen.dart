import 'package:cgpa/data/model/semester_details_model.dart';
import 'package:flutter/material.dart';

class OneSemesterResultScreen extends StatefulWidget {
  final List<SemesterDetailsModel> semesterDetailsList;

  const OneSemesterResultScreen({super.key, required this.semesterDetailsList});

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
        leading: Icon(Icons.menu),
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
    );
  }

  Widget _buildCourseResultCard(SemesterDetailsModel semester) {
    return Card(
      color: Colors.grey.shade300,
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
              Text("Semester Information",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              Text("Student Id : ${semester.studentId}",style: Theme.of(context).textTheme.titleMedium),
              Text("Credit :$totalCredit ",style: Theme.of(context).textTheme.titleMedium),
              Text("Semester : ${semester.semesterName}-${semester.semesterYear}",style: Theme.of(context).textTheme.titleMedium),
              Text("Year : ${semester.semesterYear}",style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInformationSection(BuildContext context) {
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
              Text(
                "Personal Information",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              Text("Name : ",style: Theme.of(context).textTheme.titleMedium),
              Text("Program : ",style: Theme.of(context).textTheme.titleMedium),
              Text("Campus : ",style: Theme.of(context).textTheme.titleMedium),
              Text("Shift : ",style: Theme.of(context).textTheme.titleMedium),
              Text("Department : ",style: Theme.of(context).textTheme.titleMedium),
              Text("Batch : ",style: Theme.of(context).textTheme.titleMedium),
              Text("Faculty : ",style: Theme.of(context).textTheme.titleMedium),
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
