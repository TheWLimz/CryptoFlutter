class ApiStatus<T> {
  String status;
  String message;
  T? data;

  ApiStatus({required this.status, required this.message,required this.data});

  factory ApiStatus.fromJson( Map<String,dynamic> json, Function(Map<String,dynamic>) create){
    return ApiStatus<T>(
      status : json['status'],
      message : json['message'],
     data : create(json['data'])
    );
  }

}


class ApiListStatus<T> {
  dynamic status;
  dynamic message;
  List<T>? data;

  ApiListStatus({required this.status, required this.message, required this.data});

  factory ApiListStatus.fromJson(
      Map<String, dynamic> json, Function(List<dynamic> list) create) {
    return ApiListStatus<T>(
        status: json['status'],
        message: json['message'],
        data: create(json['data']));
  }
}





