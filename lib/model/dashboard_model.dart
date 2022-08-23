class DashboardModel {
  late int id;
  late String firstName;
  late String lastName;
  late String email;
  late String avatarUrl;
  late String password;
  late String role;
  late dynamic rememberMeToken;
  late String createdAt;
  late String updatedAt;
  late String education;
  late String certification;
  late int rate;
  late num rating;
  late num age;
  late int userId;
  late String subject;

  DashboardModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.avatarUrl,
      required this.password,
      required this.role,
      required this.rememberMeToken,
      required this.createdAt,
      required this.updatedAt,
      required this.education,
      required this.certification,
      required this.rate,
      required this.rating,
      required this.age,
      required this.userId,
      required this.subject});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["first_name"] is String) this.firstName = json["first_name"];
    if (json["last_name"] is String) this.lastName = json["last_name"];
    if (json["email"] is String) this.email = json["email"];
    if (json["avatar_url"] is String) this.avatarUrl = json["avatar_url"];
    if (json["password"] is String) this.password = json["password"];
    if (json["role"] is String) this.role = json["role"];
    this.rememberMeToken = json["remember_me_token"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
    if (json["education"] is String) this.education = json["education"];
    if (json["certification"] is String)
      this.certification = json["certification"];
    if (json["rate"] is int) this.rate = json["rate"];
    if (json["rating"] is num) this.rating = json["rating"];
    if (json["age"] is num) this.age = json["age"];
    if (json["user_id"] is int) this.userId = json["user_id"];
    if (json["subject"] is String) this.subject = json["subject"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["first_name"] = this.firstName;
    data["last_name"] = this.lastName;
    data["email"] = this.email;
    data["avatar_url"] = this.avatarUrl;
    data["password"] = this.password;
    data["role"] = this.role;
    data["remember_me_token"] = this.rememberMeToken;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    data["education"] = this.education;
    data["certification"] = this.certification;
    data["rate"] = this.rate;
    data["rating"] = this.rating;
    data["age"] = this.age;
    data["user_id"] = this.userId;
    data["subject"] = this.subject;
    return data;
  }
}
