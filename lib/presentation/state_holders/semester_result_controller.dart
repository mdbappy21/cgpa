import 'package:cgpa/data/model/semester_details_model.dart';
import 'package:cgpa/data/services/network_caller.dart';
import 'package:cgpa/data/services/network_response.dart';
import 'package:cgpa/data/utils/urls.dart';
import 'package:get/get.dart';

class SemesterResultController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;
  var _semesterDetailsList = [];

  String? get errorMassage => _errorMassage;

  get sgpa => _semesterDetailsList;

  bool get inProgress => _inProgress;

  Future<bool> getSemesterResult(String semesterId, String studentId) async {
    bool isSuccess = false;
    _inProgress = true;
    update(); // This will trigger the GetBuilder to rebuild
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.oneSemester(semesterId, studentId),
    );
    if (response.isSuccess) {
      _errorMassage = null;
      _semesterDetailsList = (response.responseData as List).map((e) => SemesterDetailsModel.fromJson(e as Map<String, dynamic>),).toList();

      isSuccess = true;
    } else {
      _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update(); // This will trigger the GetBuilder to rebuild again
    return isSuccess;
  }
}
