import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../controllers/repository_controller.dart';
import '../models/repository_model.dart';

class RepositoriesView extends StatelessWidget {
  const RepositoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    // ○ Fetch a list of the user's public repositories from the Github API. The API endpoint is https://api.github.com/users/{username}/repos
    // ○ Display a list of the user's public repositories, including their name, description, and number of stars.
    // ○ Allow the user to sort the list of repositories by stars in ascending or descending order.
    return FutureBuilder<List<RepositoryModel>>(
      future: RepositoryController().fetchRepositories('mikezamayias'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // return SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       for (int index = 0; index < snapshot.data!.length; index++)
          //         PlatformListTile(
          //           title: PlatformText(snapshot.data![index].name!),
          //           subtitle: snapshot.data![index].description != null
          //               ? PlatformText(snapshot.data![index].description!)
          //               : null,
          //           trailing: PlatformText(
          //             snapshot.data![index].stargazersCount.toString(),
          //           ),
          //         ),
          //     ],
          //   ),
          // );
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
    );
  }
}
