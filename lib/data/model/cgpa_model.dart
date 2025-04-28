import 'package:cgpa/data/model/semester.dart';
import 'package:cgpa/data/model/student_model.dart';

class CgpaModel {
  Student? student;
  List<Semesters>? semesters;
  double? totalCredits;
  double? finalCGPA;
  bool? defenseIncluded;

  CgpaModel(
      {this.student,
        this.semesters,
        this.totalCredits,
        this.finalCGPA,
        this.defenseIncluded});

  CgpaModel.fromJson(Map<String, dynamic> json) {
    student =
    json['student'] != null ?  Student.fromJson(json['student']) : null;
    if (json['semesters'] != null) {
      semesters = <Semesters>[];
      json['semesters'].forEach((v) {
        semesters!.add( Semesters.fromJson(v));
      });
    }
    totalCredits = json['totalCredits'];
    finalCGPA = json['finalCGPA'];
    defenseIncluded = json['defenseIncluded'];
  }
}

