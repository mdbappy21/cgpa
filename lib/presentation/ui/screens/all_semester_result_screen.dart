import 'package:cgpa/data/model/cgpa_model.dart';
import 'package:cgpa/presentation/ui/screens/semester_result_details_screen.dart';
import 'package:cgpa/presentation/ui/widgets/app_drawer.dart';
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
              SizedBox(height: 8),
              Container(
                height: 250,
                width: double.maxFinite,
                color: Colors.grey,
                child: Text("Curve will here", textAlign: TextAlign.center),
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
                  var semester = widget.cgpaData.semesters![index];
                  // print('${widget.cgpaData.semesters}');
                  print('${semester}');
                  return _buildSemesterOverviewResult(context,semester);
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

  Widget _buildSemesterOverviewResult(BuildContext context,var semester) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>SemesterResultDetailsScreen());
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
            Text("3.5", textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge
            ),
            SizedBox(height: 8),
            Text("$semester",
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Semester Information", style: Theme.of(context).textTheme.titleLarge,),
                  Text("Student Id : ${widget.cgpaData.student!.id}",
                    style: Theme.of(context).textTheme.titleMedium,),
                  Text("Credit : ${widget.cgpaData.totalCredits}",
                    style: Theme.of(context).textTheme.titleMedium,),
                  Text("Semester : ${widget.cgpaData.semesters?.length}",
                    style: Theme.of(context).textTheme.titleMedium,),
                  Text("Year : will be update soon",
                    style: Theme.of(context).textTheme.titleMedium,),
                  Text("Batch : will be update soon",
                    style: Theme.of(context).textTheme.titleMedium,),
                ],
              ),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.green, // Applying color here
                  borderRadius: BorderRadius.circular(40), // Border radius inside BoxDecoration
                ),
                child: Align(alignment:Alignment.center,child: Text("${widget.cgpaData.finalCGPA}")),
              )

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
                style: Theme.of(context).textTheme.titleMedium,),
              Text("Campus : ${widget.cgpaData.student!.campus}",
                style: Theme.of(context).textTheme.titleMedium,),
              Text("Shift : ${widget.cgpaData.student!}",
                style: Theme.of(context).textTheme.titleMedium,),
              Text("Department :${widget.cgpaData.student!.department} ",
                style: Theme.of(context).textTheme.titleMedium,),
              Text("Faculty : ${widget.cgpaData.student}",
                style: Theme.of(context).textTheme.titleMedium,),
            ],
          ),
        ),
      ),
    );
  }
}

