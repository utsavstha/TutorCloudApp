import 'package:flutter/material.dart';
import 'package:tutor_cloud/utils/save_data.dart';

import 'dart:math';
import '../../constants.dart';
import '../../network/http_requests.dart';
import '../../routes/app_pages.dart';
import '../../utils/api_constants.dart';
import 'widgets/review_item.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ProfileUI extends StatefulWidget {
  const ProfileUI({Key? key}) : super(key: key);

  @override
  State<ProfileUI> createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUI> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  Future<void> initSocket() async {
    print('Connecting to chat service');
    // String registrationToken = await getFCMToken();
    socket = IO.io(ApiConstants.baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'userName': "test", 'registrationToken': "test"}
    });
    socket.connect();
    socket.onConnect((_) {
      print('connected to websocket');
    });
  }

  _buildReviews() {
    var reviews = <Widget>[];
    var names = [
      "Utsav Shrestha",
      "Paruhang Angdembe",
      "Tshering Wangchuk Sherpa",
      "Sudeep Koirala",
      "Samit Mahat",
      "Bikesh Thapa",
      "Anuj Maharjan"
    ];
    var avatars = ["22", "8", "11", "23", "5", "14", "30"];
    List<double> ratings = [4, 4.5, 4, 5, 5, 2, 2.5];
    var comments = [
      "Loved this course",
      "Very helpful",
      "I learned a lot from this course",
      "This was an amazing experience, will try again",
      "Hands down the best teacher ",
      "He tried, but I didnt understand very well",
      "Not the best"
    ];
    Random rnd;
    int min = 0;
    int max = 6;
    int lastGenerated = -1;
    rnd = Random();
    for (var i = 0; i < 3; i++) {
      int index = min + rnd.nextInt(max - min);
      if (lastGenerated == index && index < 6) {
        index = min + rnd.nextInt(max - min) + 1;
      }
      reviews.add(ReviewItem(
          imageUrl: "https://i.pravatar.cc/150?img=${avatars[index]}",
          name: names[index],
          rating: ratings[index],
          comment: comments[index]));
    }

    return reviews;
  }

  _createConversation(
      String name, String email, String avatar, String teacherId) async {
    try {
      int studentId = await SaveData.getId();
      HttpNetworkRequest httpRequest = HttpNetworkRequest();
      String url = ApiConstants.conversation;
      final Map<String, dynamic> data = {
        "teacher_id": teacherId,
        "student_id": studentId,
      };
      var response = await httpRequest.post(url, data);
      num conversationId = response['id'];
      socket.emit("newConversation", teacherId);
      _gotoChat(name, email, avatar, teacherId, conversationId, studentId);
      // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Navigator.pushNamed(context, Routes.chat);

      // });
      // if (response.)

      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
    }
  }

  _gotoChat(String name, String email, String avatar, String teacherId,
      num conversationId, int studentId) {
    Navigator.pushNamed(context, Routes.chat, arguments: {
      "name": name,
      "email": email,
      "avatar": avatar,
      "conversation_id": conversationId.toString(),
      "user_id": studentId.toString(),
      "receiver_id": teacherId.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final name = args['name'] as String;
    final email = args['email'] as String;
    final subject = args['subject'] as String;
    final avatarUrl = args['avatar_url'] as String;
    final education = args['education'] as String;
    final certification = args['certification'] as String;
    final rate = args['rate'] as num;
    final rating = args['rating'] as num;
    final age = args['age'] as num;
    final id = args['id'] as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1585314062340-f1a5a7c9328d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 30, // Image radius
                      backgroundImage: NetworkImage(avatarUrl),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$subject Language",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "⬤",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "7 Years Experience",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          "Available",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${rate - 2}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Text(
                              "Rating",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "${rate - 5}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Text(
                              "Reviews",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "$age",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Text(
                              "Years Old",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8, top: 16),
              child: Text(
                "Education",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                education,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8, top: 16),
              child: Text(
                "Certificates",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                certification,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8, top: 16),
              child: Text(
                "Reviews",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            Column(
              children: _buildReviews(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity, // <-- match_parent
                height: 50,
                child: TextButton(
                  style: flatButtonStyle,
                  onPressed: () {
                    _createConversation(name, email, avatarUrl, id.toString());
                  },
                  child: Text('Book Now'),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
