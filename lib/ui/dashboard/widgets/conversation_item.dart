import 'package:flutter/material.dart';

class ConversationItem extends StatelessWidget {
  String imageUrl;
  String name;
  String message;

  ConversationItem(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20, // Image radius
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Text(
                  message,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
        Divider(color: Colors.grey.shade600)
      ],
    );
  }
}
