class Urls{
  // static const String _baseUrl='http://software.diu.edu.bd:8006';
  static const String _baseUrl='https://diurecords.vercel.app/api';
  static const String _customBaseUrl='https://web-production-c0f0e.up.railway.app';

  static  String oneSemester(String semesterId,String studentId)=>'$_baseUrl/result?grecaptcha=&semesterId=$semesterId&studentId=$studentId';
  static  String allSemester(String studentId)=>'$_customBaseUrl/result?student_id=$studentId';
  static  String studentInfo(String studentId)=>'$_baseUrl/result/studentInfo?studentId=$studentId';
}