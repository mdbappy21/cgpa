class Student {
  String? id;
  String? name;
  String? program;
  String? department;
  String? campus;

  Student({this.id, this.name, this.program, this.department, this.campus});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    program = json['program'];
    department = json['department'];
    campus = json['campus'];
  }
}