class ConversationModel {
  late int id;
  late String firstName;
  late String lastName;
  late String avatarUrl;
  late String email;
  late int teacher_id;
  late int student_id;

  ConversationModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.avatarUrl,
      required this.email,
      required this.teacher_id,
      required this.student_id});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["first_name"] is String) this.firstName = json["first_name"];
    if (json["last_name"] is String) this.lastName = json["last_name"];
    if (json["avatar_url"] is String) this.avatarUrl = json["avatar_url"];
    if (json["email"] is String) this.email = json["email"];
    if (json["teacher_id"] is int) this.teacher_id = json["teacher_id"];
    if (json["student_id"] is int) this.student_id = json["student_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["first_name"] = this.firstName;
    data["last_name"] = this.lastName;
    data["avatar_url"] = this.avatarUrl;
    data["email"] = this.email;
    // data["user_id"] = this.userId;
    return data;
  }
}
