class ServiceResponse<T> {
  int code;
  String? codeDesc;
  String message;
  T? content;

  ServiceResponse.fromJsonError(Map<String, dynamic> json)
      : code = json['status'],
        message = (json['errors'] as Map).values.join(", ");

  ServiceResponse.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        codeDesc = json['codeDesc'],
        message = json['message'],
        content = json['content'];
}
