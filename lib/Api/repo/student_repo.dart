import '../response_model/student__res_model/add_student_model.dart';
import '../response_model/student__res_model/get_particular_student_model.dart';
import '../response_model/student__res_model/get_student_model.dart';
import '../response_model/student__res_model/update_student_model.dart';
import '../services/api_service.dart';
import '../services/base_service.dart';

class StudentRepo {
  Future addStudent({Map<String, dynamic>? body}) async {
    var response = await APIService().getResponse(
        url: BaseService.addStudent, apiType: APIType.aPost, body: body);

    AddStudentModel addStudentModel = AddStudentModel.fromJson(response);

    return addStudentModel;
  }

  Future getStudent() async {
    var response = await APIService()
        .getResponse(url: BaseService.getStudent, apiType: APIType.aGet);

    GetStudentModel getStudentModel = GetStudentModel.fromJson(response);

    return getStudentModel;
  }

  Future getParticularStudent({String? id}) async {
    var response = await APIService().getResponse(
        url:
            'https://codelineinfotechapis.vercel.app/api/v1/student/get_student_details/$id',
        apiType: APIType.aGet);

    GetParticularStudentModel getParticularStudentModel =
        GetParticularStudentModel.fromJson(response);

    return getParticularStudentModel;
  }

  Future updateStudent({String? id, Map<String, dynamic>? body}) async {
    var response = await APIService().getResponse(
        url:
            'https://codelineinfotechapis.vercel.app/api/v1/student/edit_student/$id',
        apiType: APIType.aPut,
        body: body);

    UpdateStudentModel updateStudentModel =
        UpdateStudentModel.fromJson(response);

    return updateStudentModel;
  }
}
