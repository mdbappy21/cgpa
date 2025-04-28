class Student {
  String? id;
  String? name;
  String? program;
  String? department;
  String? campus;
  String? shift;
  String? faculty;
  String? year;
  int? batch;

  Student({
    this.id,
    this.name,
    this.program,
    this.department,
    this.campus,
    this.shift,
    this.faculty,
    this.year,
    this.batch,
  });

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    program = json['program'];
    department = json['department'];
    campus = json['campus'];
    shift = json['shift'];
    faculty = json['faculty'];
    year = json['year'];
    batch = json['batch'];
  }
}
