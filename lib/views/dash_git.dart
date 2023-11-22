import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../controllers/route_controller.dart';
import '../models/route_model.dart';

class DashGit extends ConsumerWidget {
  const DashGit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> views = RouteController()
        .routes
        .map((RouteModel routeModel) => routeModel.view)
        .toList();
    return PlatformScaffold(
      backgroundColor: platformThemeData(
        context,
        material: (ThemeData data) => data.scaffoldBackgroundColor,
        cupertino: (CupertinoThemeData data) => data.barBackgroundColor,
      ),
      body: SafeArea(
        child: PreloadPageView.builder(
          itemBuilder: (context, index) => views.elementAt(ref
              .watch(RouteController.currentRouteIndexProvider.notifier)
              .state),
          itemCount: views.length,
          preloadPagesCount: views.length,
        ),
      ),
      bottomNavBar: PlatformNavBar(
        items: <BottomNavigationBarItem>[
          ...RouteController().routes.map<BottomNavigationBarItem>(
            (RouteModel routeModel) {
              return BottomNavigationBarItem(
                icon: routeModel.icon,
                label: routeModel.label,
              );
            },
          ),
        ],
        itemChanged: (int index) {
          ref.read(RouteController.currentRouteIndexProvider.notifier).state =
              index;
        },
      ),
    );
  }
}
