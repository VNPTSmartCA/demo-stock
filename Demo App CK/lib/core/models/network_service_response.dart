import 'package:flutter/cupertino.dart';

class NetworkServiceResponse<T> {
  T content;
  bool success;
  String message;

  NetworkServiceResponse(
      {required this.content, required this.success, required this.message});
}

class MappedNetworkServiceResponse<T> {
  dynamic mappedResult;
  NetworkServiceResponse<T> networkServiceResponse;
  MappedNetworkServiceResponse(
      {this.mappedResult, required this.networkServiceResponse});
}
