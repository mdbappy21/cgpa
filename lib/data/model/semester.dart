import 'package:cgpa/data/model/course_model.dart';

class Semesters {
  String? semester;
  List<Courses>? courses;

  Semesters({this.semester, this.courses});

  Semesters.fromJson(Map<String, dynamic> json) {
    semester = json['semester'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
  }
}