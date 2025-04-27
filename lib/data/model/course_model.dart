class Courses {
  String? title;
  String? code;
  String? grade;
  int? credits;
  double? cgpa;

  Courses({this.title, this.code, this.grade, this.credits, this.cgpa});

  Courses.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    code = json['code'];
    grade = json['grade'];
    credits = json['credits'];
    cgpa = json['cgpa'];
  }
}