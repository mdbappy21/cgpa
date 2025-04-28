import 'package:cgpa/data/model/course_model.dart';

class Semesters {
  String? semester;
  List<Courses>? courses;
  double? semesterCGPA;
  double? semesterCredits;

  Semesters({this.semester, this.semesterCGPA,this.semesterCredits, this.courses});

  Semesters.fromJson(Map<String, dynamic> json) {
    semester = json['semester'];
    semesterCGPA = json['semesterCGPA'];
    semesterCredits = json['semesterCredits'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(Courses.fromJson(v));
      });
    }
  }
}
