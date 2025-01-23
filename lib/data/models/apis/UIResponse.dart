// class UIResponse<T> {
//   Status status = Status.LOADING;
//   T? data;
//   String message = '';

//   UIResponse.none() : status = Status.NONE;
//   UIResponse.loading() : status = Status.LOADING;
//   UIResponse.completed(this.data) : status = Status.COMPLETED;
//   UIResponse.error(this.message) : status = Status.ERROR;

//   @override
//   String toString() {
//     return "Status : $status \n Message : $message \n Data : $data";
//   }
// }

// enum Status { NONE,LOADING, COMPLETED, ERROR }// lib/data/models/apis/UIResponse.dart
// lib/src/models/apis/UIResponse.dart

enum Status { NONE, LOADING, COMPLETED, ERROR }

class UIResponse<T> {
  Status status = Status.LOADING;
  T? data;
  String message = '';

  UIResponse.none() : status = Status.NONE;
  UIResponse.loading() : status = Status.LOADING;
  UIResponse.completed(this.data) : status = Status.COMPLETED;
  UIResponse.error(this.message) : status = Status.ERROR;

  // Getter to check if the response is successful
  bool get isSuccess => status == Status.COMPLETED;

  // Getter to retrieve the error message
  String? get error => status == Status.ERROR ? message : null;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
