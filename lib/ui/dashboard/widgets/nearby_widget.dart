import 'package:flutter/material.dart';
import 'package:tutor_cloud/ui/dashboard/widgets/categories_item.dart';

import '../../../model/dashboard_model.dart';
import '../../../routes/app_pages.dart';
import 'nearby_item.dart';

class NearbyWidget extends StatelessWidget {
  var dashboardModel = <DashboardModel>[];
  NearbyWidget({required this.dashboardModel});

  _buildList() {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 136,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dashboardModel.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.profile, arguments: {
                "name": dashboardModel[index].firstName +
                    dashboardModel[index].lastName,
                "email": dashboardModel[index].email,
                "avatar_url": dashboardModel[index].avatarUrl,
                "education": dashboardModel[index].education,
                "certification": dashboardModel[index].certification,
                "subject": dashboardModel[index].subject,
                "rate": dashboardModel[index].rate,
                "rating": dashboardModel[index].rating,
                "age": dashboardModel[index].age,
                "id": dashboardModel[index].id,
              });
            },
            child: NearbyItem(
              imageUrl: dashboardModel[index].avatarUrl,
              title:
                  "${dashboardModel[index].firstName} ${dashboardModel[index].lastName}",
              rating: dashboardModel[index].rating.toString(),
            ),
          );
        },
      ),
    );
    // return SizedBox(
    //   height: 130,
    //   child: ListView(
    //     //https://raw.githubusercontent.com/lipis/flag-icons/main/flags/4x3/ac.svg
    //     // This next line does the trick.
    //     scrollDirection: Axis.horizontal,
    //     children: <Widget>[
    //       NearbyItem(
    //           imageUrl: "https://i.pravatar.cc/150?img=68",
    //           title: "Paul Lipsey",
    //           rating: "3.5"),
    //       NearbyItem(
    //           imageUrl: "https://i.pravatar.cc/150?img=49",
    //           title: "Lane Simon",
    //           rating: "4"),
    //       NearbyItem(
    //           imageUrl: "https://i.pravatar.cc/150?img=35",
    //           title: "Sapphire",
    //           rating: "2.5"),
    //       NearbyItem(
    //           imageUrl: "https://i.pravatar.cc/150?img=18",
    //           title: "Mortimer Elliott",
    //           rating: "4.5"),
    //       NearbyItem(
    //           imageUrl: "https://i.pravatar.cc/150?img=12",
    //           title: "Ward Cannon",
    //           rating: "3.5"),
    //     ],
    //   ),
    // );
  }
}
