import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/route_controller.dart';
import '../models/route_model.dart';

class DashGit extends ConsumerWidget {
  const DashGit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title:
            PlatformText(ref.watch(RouteController.currentRouteProvider).label),
      ),
      body: ref.watch(RouteController.currentRouteProvider).view,
      bottomNavBar: PlatformNavBar(
        items: <BottomNavigationBarItem>[
          ...RouteController().routes.map<BottomNavigationBarItem>(
            (RouteModel routeModel) {
              return BottomNavigationBarItem(
                icon: routeModel.icon,
                label: routeModel.label,
              );
            },
          )
        ],
        itemChanged: (int index) {
          ref.read(RouteController.currentRouteIndexProvider.notifier).state =
              index;
        },
      ),
    );
  }
}
