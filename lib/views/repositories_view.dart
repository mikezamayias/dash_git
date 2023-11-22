import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../controllers/repository_controller.dart';
import '../models/repository_model.dart';

class RepositoriesView extends StatelessWidget {
  const RepositoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Repositories'),
        trailingActions: [
          // sort button
          PlatformPopupMenu(
            options: <PopupMenuOption>[
              PopupMenuOption(
                label: 'Stars',
              ),
              PopupMenuOption(
                label: 'Names',
              ),
              PopupMenuOption(
                label: 'Description',
              ),
            ],
            icon: Icon(
              context.platformIcon(
                material: Icons.more_vert_rounded,
                cupertino: CupertinoIcons.ellipsis,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<RepositoryModel>>(
        future: RepositoryController().fetchRepositories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return PlatformListTile(
                  title: PlatformText(snapshot.data![index].name!),
                  subtitle: snapshot.data![index].description != null
                      ? PlatformText(snapshot.data![index].description!)
                      : null,
                  trailing: PlatformText(
                    snapshot.data![index].stargazersCount.toString(),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: PlatformText('${snapshot.error}'));
          }
          return Center(child: PlatformCircularProgressIndicator());
        },
      ),
    );
  }
}
