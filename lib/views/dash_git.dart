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
              child: ref.watch(usernameQueryProvider) != null &&
                      ref.watch(usernameQueryProvider)!.isNotEmpty
                  ? routeModel.view
                  : SelectUser(label: routeModel.label.toLowerCase()),
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
              showCustomDialog(context, textEditingController);
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

  Future<dynamic> showCustomDialog(
    BuildContext context,
    TextEditingController textEditingController,
  ) {
    return showPlatformDialog(
      context: context,
      builder: (_) => Consumer(
        builder: (context, ref, child) {
          return PlatformAlertDialog(
            title: const Text('Search for a user'),
            content: PlatformWidget(
              cupertino: (context, _) => Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CupertinoSearchTextField(
                  controller: textEditingController,
                  placeholder: 'username',
                ),
              ),
              material: (context, _) => TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  hintText: 'username',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            actions: [
              PlatformDialogAction(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
                cupertino: (_, __) => CupertinoDialogActionData(
                  isDestructiveAction: true,
                ),
                material: (_, __) => MaterialDialogActionData(
                  style: TextButton.styleFrom(
                    foregroundColor: context.theme.colorScheme.error,
                  ),
                ),
              ),
              PlatformDialogAction(
                child: const Text('Reset'),
                onPressed: () {
                  ref.read(usernameQueryProvider.notifier).state = null;
                  Navigator.pop(context);
                },
              ),
              ValueListenableBuilder(
                valueListenable: textEditingController,
                builder: (context, value, child) {
                  return PlatformDialogAction(
                    onPressed: textEditingController.text.isEmpty
                        ? null
                        : () {
                            ref.read(usernameQueryProvider.notifier).state =
                                textEditingController.text;
                            context.navigator.pop();
                          },
                    child: const Text('Search'),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
