import 'package:cgpa/data/model/cgpa_model.dart';
import 'package:cgpa/data/services/network_caller.dart';
import 'package:cgpa/data/services/network_response.dart';
import 'package:cgpa/data/utils/urls.dart';
import 'package:get/get.dart';

class AverageCgpaController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;
  CgpaModel? _cgpaModel;

  String? get errorMassage => _errorMassage;
  CgpaModel? get cgpaData => _cgpaModel;
  bool get inProgress => _inProgress;

  Future<bool> getCgpa(String studentId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.allSemester(studentId),
    );
    if (response.isSuccess) {
      _errorMassage = null;
      _cgpaModel = CgpaModel.fromJson(response.responseData as Map<String, dynamic>);
      isSuccess = true;
    } else {
      _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
