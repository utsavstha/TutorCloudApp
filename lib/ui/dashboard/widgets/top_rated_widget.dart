import 'package:flutter/material.dart';
import 'package:tutor_cloud/ui/dashboard/widgets/categories_item.dart';

import 'top_rated_item.dart';

class TopRatedWidget extends StatelessWidget {
  const TopRatedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView(
        //https://raw.githubusercontent.com/lipis/flag-icons/main/flags/4x3/ac.svg
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          TopRatedItem(
            imageUrl:
                "https://images.unsplash.com/photo-1580894732444-8ecded7900cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
            title: "Mandarin",
            count: "10",
            name: "Lane Simon",
            rating: 4,
            experience: "3",
            price: "10",
          ),
          TopRatedItem(
            imageUrl:
                "https://images.unsplash.com/photo-1590650213165-c1fef80648c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
            title: "Japanese",
            count: "12",
            name: "Lauren Herrera",
            rating: 3,
            experience: "4",
            price: "15",
          ),
          TopRatedItem(
            imageUrl:
                "https://images.unsplash.com/photo-1573496799652-408c2ac9fe98?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fHRlYWNoZXJzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
            title: "Spanish",
            count: "2",
            name: "Lorraine Mason",
            rating: 4,
            experience: "5",
            price: "15",
          ),
          TopRatedItem(
            imageUrl:
                "https://images.unsplash.com/photo-1557862921-37829c790f19?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjZ8fHRlYWNoZXJzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
            title: "French",
            count: "11",
            name: "Daniel Wright",
            rating: 3.5,
            experience: "8",
            price: "20",
          ),
        ],
      ),
    );
  }
}
