import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutor_cloud/routes/app_pages.dart';
import 'package:tutor_cloud/routes/app_routes.dart';
import 'package:tutor_cloud/ui/auth/login_ui.dart';
import 'package:tutor_cloud/ui/dashboard/widgets/top_rated_widget.dart';
import 'package:tutor_cloud/utils/no_data.dart';
import 'package:tutor_cloud/utils/save_data.dart';

import '../../providers/dashboard_provider.dart';
import '../../utils/progress_dialog.dart';
import 'widgets/categories_item.dart';
import 'widgets/categories_widget.dart';
import 'widgets/nearby_widget.dart';

class DashboardUI extends ConsumerStatefulWidget {
  const DashboardUI({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardUI> createState() => _DashboardUIState();
}

class _DashboardUIState extends ConsumerState<DashboardUI> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(dashboardNotifierProvider).getData();
    });
  }

  _logout() async {
    SaveData.logout();
    Navigator.pushNamed(context, Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final provider = ref.watch(dashboardNotifierProvider);
          if (provider.apiResponse.isLoading) {
            return const ProgressDialog();
          } else if (provider.apiResponse.model != null &&
              provider.apiResponse.model != "false") {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Browse',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: _logout,
                        icon: Icon(
                          Icons.logout,
                          size: 30,
                          color: Colors.grey.shade800,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See All',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CategoriesWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nearby Tutors',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See All',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NearbyWidget(dashboardModel: provider.apiResponse.model),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Rated Tutors',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See All',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TopRatedWidget()
                ],
              ),
            );
          } else {
            return const NoData();
          }
        }),
      )),
    );
  }
}
