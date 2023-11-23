import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screwdriver/flutter_screwdriver.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../controllers/route_controller.dart';
import '../models/route_model.dart';
import '../providers/query_provider.dart';
import '../widgets/select_user.dart';
import '../wrappers/keep_alive_wrapper.dart';

class DashGit extends ConsumerWidget {
  const DashGit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = TextEditingController();
    List<Widget> views = RouteController().routes.map(
      (RouteModel routeModel) {
        return KeepAliveWrapper(
          child: Container(
            color: platformThemeData(
              context,
              cupertino: (data) => CupertinoColors.systemGroupedBackground,
              material: (data) => data.colorScheme.surface,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: ref.watch(usernameQueryProvider) == null
                  ? SelectUser(label: routeModel.label.toLowerCase())
                  : routeModel.view,
            ),
          ),
        );
      },
    ).toList();

    return PlatformScaffold(
      backgroundColor: platformThemeData(
        context,
        material: (ThemeData data) => data.scaffoldBackgroundColor,
        cupertino: (CupertinoThemeData data) => data.barBackgroundColor,
      ),
      appBar: PlatformAppBar(
        title: const Text('DashGit'),
        trailingActions: [
          PlatformIconButton(
            icon: Icon(context.platformIcons.search),
            onPressed: () {
              showPlatformDialog(
                context: context,
                builder: (_) => PlatformAlertDialog(
                  title: const Text('Search for a user'),
                  content: Column(
                    children: [
                      PlatformWidget(
                        cupertino: (context, _) => CupertinoSearchTextField(
                          controller: textEditingController,
                          placeholder: 'Search User',
                        ),
                        material: (context, _) => TextField(
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            hintText: 'Search User',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    PlatformDialogAction(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ValueListenableBuilder(
                      valueListenable: textEditingController,
                      builder: (context, value, child) {
                        return PlatformDialogAction(
                          onPressed: textEditingController.text.isNotEmpty
                              ? () {
                                  ref
                                      .read(usernameQueryProvider.notifier)
                                      .state = textEditingController.text;
                                  context.navigator.pop();
                                }
                              : null,
                          child: PlatformText('Search'),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: PreloadPageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => views
              .elementAt(ref.watch(RouteController.currentRouteIndexProvider)),
          itemCount: views.length,
          preloadPagesCount: views.length,
        ),
      ),
      bottomNavBar: PlatformNavBar(
        currentIndex: ref.watch(RouteController.currentRouteIndexProvider),
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
