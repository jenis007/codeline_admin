import 'package:codeline_admin/Api/response_model/config_response_model.dart';

import '../services/api_service.dart';
import '../services/base_service.dart';

class ConfigRepo {
  Future configDetails() async {
    var response = await APIService()
        .getResponse(url: BaseService.config, apiType: APIType.aGet);

    ConfigDetailsModel configDetailsModel =
        ConfigDetailsModel.fromJson(response);

    return configDetailsModel;
  }
}
