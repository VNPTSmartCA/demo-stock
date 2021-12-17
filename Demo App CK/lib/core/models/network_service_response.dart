class NetworkServiceResponse<T> {
  T? content;
  bool success;
  String? message;

  NetworkServiceResponse({this.content, required this.success, this.message});
}

class MappedNetworkServiceResponse<T> {
  dynamic mappedResult;
  NetworkServiceResponse<T> networkServiceResponse;
  MappedNetworkServiceResponse(
      {this.mappedResult, required this.networkServiceResponse});
}
