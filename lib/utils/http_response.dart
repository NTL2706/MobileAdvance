

class Error {
  String? message;
  int? status;

  Error.unknown():message=null, status=null;

  Error(
    {
      this.message,
      this.status
    }
  );

  factory Error.fromJson(Map<String,dynamic> json){
    return Error(
      message: json['message'],
      status: json['status']
    );
  }
}

class HttpResponse<T> {
  String? message;
  int? status; 
  bool? isLoading;
  T? result;
  
  set setLoading(bool isLoading){
    isLoading = isLoading;
  }

  HttpResponse.unknown():isLoading = false, message = null, status = null, result =null;
  
  void updateResponse(Map<String,dynamic> json) {
    this.message = json['message'] ?? this.message;
    this.status = json['status'] ?? this.status;
    this.result = json['result'];
  }
}