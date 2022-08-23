import 'package:flutter/material.dart';
import 'package:tutor_cloud/ui/dashboard/widgets/categories_item.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView(
        //https://raw.githubusercontent.com/lipis/flag-icons/main/flags/4x3/ac.svg
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryItem(
              imageUrl: "https://countryflagsapi.com/png/america",
              title: "English",
              count: "10"),
          CategoryItem(
              imageUrl: "https://countryflagsapi.com/png/japan",
              title: "Japanese",
              count: "12"),
          CategoryItem(
              imageUrl: "https://countryflagsapi.com/png/kr",
              title: "Korean",
              count: "4"),
          CategoryItem(
              imageUrl: "https://countryflagsapi.com/png/spain",
              title: "Spanish",
              count: "2"),
          CategoryItem(
              imageUrl: "https://countryflagsapi.com/png/france",
              title: "French",
              count: "11"),
        ],
      ),
    );
  }
}
