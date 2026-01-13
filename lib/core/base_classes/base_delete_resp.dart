import '/core/base_classes/base_one_response.dart';

class DeleteResponse extends BaseOneResponse {
  const DeleteResponse({
    super.success,
    List<dynamic>? super.data,
    super.message,
  });

  factory DeleteResponse.fromJson(Map<String, dynamic> json) => DeleteResponse(
        data: json['data'],
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data,
        'message': message,
        'success': success,
      };
}
