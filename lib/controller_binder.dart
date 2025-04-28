import 'package:cgpa/data/services/network_caller.dart';
import 'package:cgpa/presentation/state_holders/average_cgpa_controller.dart';
import 'package:cgpa/presentation/state_holders/semester_result_controller.dart';
import 'package:cgpa/presentation/state_holders/student_details_info_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(Logger());
    Get.put(NetworkCaller(logger: Get.find<Logger>()));
    Get.put(SemesterResultController());
    Get.put(StudentDetailsInfoController());
    Get.put(AverageCgpaController());
  }
}
