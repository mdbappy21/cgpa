class StudentDetailsInfoModel {
  String? studentId;
  String? fkCampus;
  String? campusName;
  String? studentName;
  String? batchId;
  int? batchNo;
  int? programCredit;
  String? programId;
  String? programName;
  String? progShortName;
  String? programType;
  String? deptShortName;
  String? departmentName;
  String? facultyName;
  String? facShortName;
  String? semesterId;
  String? semesterName;
  String? shift;

  StudentDetailsInfoModel(
      {this.studentId,
        this.fkCampus,
        this.campusName,
        this.studentName,
        this.batchId,
        this.batchNo,
        this.programCredit,
        this.programId,
        this.programName,
        this.progShortName,
        this.programType,
        this.deptShortName,
        this.departmentName,
        this.facultyName,
        this.facShortName,
        this.semesterId,
        this.semesterName,
        this.shift});

  StudentDetailsInfoModel.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    fkCampus = json['fkCampus'];
    campusName = json['campusName'];
    studentName = json['studentName'];
    batchId = json['batchId'];
    batchNo = _safeIntConversion(json['batchNo']);
    programCredit = _safeIntConversion(json['programCredit']);
    programId = json['programId'];
    programName = json['programName'];
    progShortName = json['progShortName'];
    programType = json['programType'];
    deptShortName = json['deptShortName'];
    departmentName = json['departmentName'];
    facultyName = json['facultyName'];
    facShortName = json['facShortName'];
    semesterId = json['semesterId'];
    semesterName = json['semesterName'];
    shift = json['shift'];
  }
  int? _safeIntConversion(dynamic value) {
    if (value == null) return null;
    if (value is double) return value.toInt();
    if (value is int) return value;
    return null;
  }
}
