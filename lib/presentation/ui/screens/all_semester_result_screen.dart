import 'package:cgpa/presentation/ui/screens/semester_result_details_screen.dart';
import 'package:cgpa/presentation/ui/utils/app_color.dart';
import 'package:cgpa/presentation/ui/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AllSemesterResultScreen extends StatefulWidget {
  const AllSemesterResultScreen({super.key});

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
                itemCount: 12,
                itemBuilder: (context, index) {
                  return _buildSemesterOverviewResult(context);
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

  Widget _buildSemesterOverviewResult(BuildContext context) {
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
            Text("3.50", textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge
            ),
            SizedBox(height: 8),
            Text("Fall 2024",
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
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.themeColor1, // Applying color here
                  borderRadius: BorderRadius.circular(40), // Border radius inside BoxDecoration
                ),
                child: Text("Indicate the overAll CG"),
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
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text("Name : "),
              Text("Program : "),
              Text("Campus : "),
              Text("Shift : "),
              Text("Department : "),
              Text("Faculty : "),
            ],
          ),
        ),
      ),
    );
  }
}

