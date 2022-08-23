class ChatModel {
  late int id;
  late int userOne;
  late int userTwo;
  late String userOneName;
  late String userTwoName;
  late String message;
  late String createdAt;
  late String updatedAt;
  late int conversationId;

  ChatModel(
      {required this.id,
      required this.userOne,
      required this.userTwo,
      required this.userOneName,
      required this.userTwoName,
      required this.message,
      required this.createdAt,
      required this.updatedAt,
      required this.conversationId});

  ChatModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["user_one"] is int) this.userOne = json["user_one"];
    if (json["user_two"] is int) this.userTwo = json["user_two"];
    if (json["user_one_name"] is String)
      this.userOneName = json["user_one_name"];
    if (json["user_two_name"] is String)
      this.userTwoName = json["user_two_name"];
    if (json["message"] is String) this.message = json["message"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
    if (json["conversation_id"] is int)
      this.conversationId = json["conversation_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["user_one"] = this.userOne;
    data["user_two"] = this.userTwo;
    data["user_one_name"] = this.userOneName;
    data["user_two_name"] = this.userTwoName;
    data["message"] = this.message;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    data["conversation_id"] = this.conversationId;
    return data;
  }
}
