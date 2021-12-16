class RequestSignModel {
  String credentialId;
  String refTranId;
  String description;
  List<DatasModel> datas;
  RequestSignModel(
      {required this.credentialId,
      required this.refTranId,
      required this.description,
      required this.datas});

  Map<String, dynamic> toJson() {
    return {
      "credentialId": credentialId,
      "refTranId": refTranId,
      "description": description,
      "datas": datas
    };
  }
}

class DatasModel {
  String name;
  String dataBase64;
  DatasModel({required this.name, required this.dataBase64});

  Map<String, dynamic> toJson() {
    return {"name": name, "dataBase64": dataBase64};
  }
}
