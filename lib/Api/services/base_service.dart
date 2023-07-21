class BaseService {
  static String baseUrl = 'https://codelineinfotechapis.vercel.app/api';
  static String config = '$baseUrl/v1/config/get_configs';
  static String addStudent = '$baseUrl/v1/student/add_student';
  static String getStudent = '$baseUrl/v1/student/get_students';
  static String addInquiry = '$baseUrl/v1/inquiry/add_inquiry';
  static String getInquiry = '$baseUrl/v1/inquiry/get_inquiries';
  static String depositFees = '$baseUrl/v1/fees/deposit_fees';
  static String getFeesHistory = '$baseUrl/v1/fees/get_fees_history';
  static String getCertificates = '$baseUrl/v1/certificate/get_certificates';
}
