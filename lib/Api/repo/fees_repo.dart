import 'package:codeline_admin/Api/response_model/fees_res_model/deposit_fees_res_model.dart';

import '../response_model/fees_res_model/get_fees_history_model.dart';
import '../services/api_service.dart';
import '../services/base_service.dart';

class FeesRepo {
  Future addFees({Map<String, dynamic>? body}) async {
    var response = await APIService().getResponse(
        url: BaseService.depositFees, apiType: APIType.aPost, body: body);

    AddFeesModel addFeesModel = AddFeesModel.fromJson(response);

    return addFeesModel;
  }

  Future getFeesHistory() async {
    var response = await APIService()
        .getResponse(url: BaseService.getFeesHistory, apiType: APIType.aGet);

    GetFeesHistoryModel getFeesHistoryModel =
        GetFeesHistoryModel.fromJson(response);

    return getFeesHistoryModel;
  }
}
