import 'package:flutter/material.dart';

class SemesterResultDetailsScreen extends StatefulWidget {
  const SemesterResultDetailsScreen({super.key});

  @override
  State<SemesterResultDetailsScreen> createState() =>
      _SemesterResultDetailsScreenState();
}

class _SemesterResultDetailsScreenState extends State<SemesterResultDetailsScreen> {
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
              SizedBox(height: 8),
              _buildSemesterInformationSection(context),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return _buildCourseResultCard(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseResultCard(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCourseResultInfo(context),
            _buildCreditContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseResultInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CSE311', style: Theme.of(context).textTheme.titleMedium),
        Text('Database Management System', style: Theme.of(context).textTheme.titleMedium,),
        Text('Grade : ', style: Theme.of(context).textTheme.titleMedium,),
        Text('Grade Point: ', style: Theme.of(context).textTheme.titleMedium,),
      ],
    );
  }

  Widget _buildCreditContainer() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.orange,
      ),
      child: Center(child: Text("3", textAlign: TextAlign.center)),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Semester Information",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text("Student Id : "),
              Text("Credit : "),
              Text("Semester : "),
              Text("Year : "),
              Text("Batch : "),
            ],
          ),
        ),
      ),
    );
  }
}
