import 'package:cgpa/data/model/student_details_info_model.dart';
import 'package:cgpa/data/services/network_caller.dart';
import 'package:cgpa/data/services/network_response.dart';
import 'package:cgpa/data/utils/urls.dart';
import 'package:get/get.dart';

class StudentDetailsInfoController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;
  late StudentDetailsInfoModel _studentInfoDetailsList;
  // var _studentInfoDetailsList = [];

  String? get errorMassage => _errorMassage;

  get studentInfo => _studentInfoDetailsList;

  bool get inProgress => _inProgress;

  Future<bool> getStudentInfo(String studentId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.studentInfo(studentId),
    );
    if (response.isSuccess) {
      _errorMassage = null;
      _studentInfoDetailsList=StudentDetailsInfoModel.fromJson(response.responseData);
      // _studentInfoDetailsList = (response.responseData as List).map((e) => StudentDetailsInfoModel.fromJson(e as Map<String, dynamic>),).toList();
      // _sliderList = SliderListModel.fromJson(response.responseData).sliderList ?? [];
      // _studentInfoDetailsList=StudentDetailsInfoModel.fromJson(response.responseData);

      isSuccess = true;
    } else {
      _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
