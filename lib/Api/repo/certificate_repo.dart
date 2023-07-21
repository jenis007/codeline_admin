import 'package:codeline_admin/Api/response_model/certificate_res_model/add_certificate_res_model.dart';
import 'package:codeline_admin/Api/response_model/certificate_res_model/get_certificate_es_model.dart';
import 'package:codeline_admin/Api/services/dio_services.dart';
import 'package:dio/dio.dart' as d;

import '../services/api_service.dart';
import '../services/base_service.dart';

class CertificateRepo {
  Future certificateUploadRepo({String? url, d.FormData? body}) async {
    var response = await DioServices().getResponse(url: url!, body: body);

    AddCertificateModel addCertificateModel =
        AddCertificateModel.fromJson(response);

    return addCertificateModel;
  }

  Future getCertificate() async {
    var response = await APIService()
        .getResponse(url: BaseService.getCertificates, apiType: APIType.aGet);

    GetCertificateDataModel getCertificateDataModel =
        GetCertificateDataModel.fromJson(response);

    return getCertificateDataModel;
  }
}
