import '../response_model/inquiry_res_model/add_inquiry_model.dart';
import '../response_model/inquiry_res_model/get_inquiry_model.dart';
import '../response_model/inquiry_res_model/update_inquiry_model.dart';
import '../services/api_service.dart';
import '../services/base_service.dart';

class InquiryRepo {
  Future addInquiry({Map<String, dynamic>? body}) async {
    var response = await APIService().getResponse(
        url: BaseService.addInquiry, apiType: APIType.aPost, body: body);

    AddInquiryModel addInquiryModel = AddInquiryModel.fromJson(response);

    return addInquiryModel;
  }

  Future getInquiry() async {
    var response = await APIService()
        .getResponse(url: BaseService.getInquiry, apiType: APIType.aGet);

    GetInquiryModel getInquiryModel = GetInquiryModel.fromJson(response);

    return getInquiryModel;
  }

  Future updateInquiry({String? id, Map<String, dynamic>? body}) async {
    var response = await APIService().getResponse(
        url:
            'https://codelineinfotechapis.vercel.app/api/v1/inquiry/edit_inquiry/$id',
        apiType: APIType.aPut,
        body: body);

    UpdateInquiryModel updateInquiryModel =
        UpdateInquiryModel.fromJson(response);

    return updateInquiryModel;
  }
}
