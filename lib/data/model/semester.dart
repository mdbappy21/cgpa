import 'package:cgpa/data/model/course_model.dart';

class Semesters {
  String? semester;
  List<Courses>? courses;
  // final double? cgpa;

  Semesters({this.semester, this.courses});

  Semesters.fromJson(Map<String, dynamic> json) {
    semester = json['semester'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(Courses.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return '$semester';
  }

  // factory Semesters.fromJson(Map<String, dynamic> json) {
  //   return Semesters(
  //     semester: json['semesterName'] ?? 'Unknown',
  //   );
  // }
}
