import 'package:get/get.dart';

import '../api_Model/api_response.dart';
import '../repo/config_repo.dart';
import '../response_model/config_response_model.dart';

class ConfigController extends GetxController {
  List courseDetails = [];

  void changeSelectedCourses(String value) {
    if (courseDetails.contains(value)) {
      courseDetails.remove(value);
      update();
    } else {
      courseDetails.add(value);
      update();
    }
  }

  ///ConfigData--------------------------------------------------------

  ConfigDetailsModel? configDetailsModel;

  ApiResponse configResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get configApiResponse => configResponse;

  Future configDetails() async {
    configResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      configDetailsModel = await ConfigRepo().configDetails();

      configResponse = ApiResponse.complete(configDetailsModel);
    } catch (e) {
      configResponse = ApiResponse.error(message: e.toString());
    }
    update();
  }
}
