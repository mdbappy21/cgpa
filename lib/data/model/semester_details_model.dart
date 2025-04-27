class SemesterDetailsModel {
  String? semesterId;
  String? semesterName;
  int? semesterYear;
  String? studentId;
  String? courseId;
  String? customCourseId;
  String? courseTitle;
  double? totalCredit;
  Null? grandTotal;
  double? pointEquivalent;
  String? gradeLetter;
  double? cgpa;
  String? blocked;
  Null? blockCause;
  String? tevalSubmitted;
  String? teval;
  Null? semesterAccountsClearance;

  SemesterDetailsModel(
      {this.semesterId,
        this.semesterName,
        this.semesterYear,
        this.studentId,
        this.courseId,
        this.customCourseId,
        this.courseTitle,
        this.totalCredit,
        this.grandTotal,
        this.pointEquivalent,
        this.gradeLetter,
        this.cgpa,
        this.blocked,
        this.blockCause,
        this.tevalSubmitted,
        this.teval,
        this.semesterAccountsClearance});

  SemesterDetailsModel.fromJson(Map<String, dynamic> json) {
    semesterId = json['semesterId'];
    semesterName = json['semesterName'];
    semesterYear = json['semesterYear'];
    studentId = json['studentId'];
    courseId = json['courseId'];
    customCourseId = json['customCourseId'];
    courseTitle = json['courseTitle'];
    totalCredit = _safeDoubleConversion(json['totalCredit']);
    grandTotal = json['grandTotal'];
    pointEquivalent = _safeDoubleConversion(json['pointEquivalent']);
    gradeLetter = json['gradeLetter'];
    cgpa = _safeDoubleConversion(json['cgpa']);
    blocked = json['blocked'];
    blockCause = json['blockCause'];
    tevalSubmitted = json['tevalSubmitted'];
    teval = json['teval'];
    semesterAccountsClearance = json['semesterAccountsClearance'];
  }

  double? _safeDoubleConversion(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return null;
  }

}
