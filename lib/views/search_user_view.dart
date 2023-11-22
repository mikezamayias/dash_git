import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SearchUserView extends StatelessWidget {
  const SearchUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Search User'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              PlatformWidget(
                cupertino: (context, _) => CupertinoSearchTextField(
                  controller: textEditingController,
                  placeholder: 'Search User',
                ),
                material: (context, _) => TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Search User',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              PlatformElevatedButton(
                child: PlatformText('Search'),
                onPressed: () {
                  showPlatformDialog(
                    context: context,
                    builder: (_) => PlatformAlertDialog(
                      title: const Text('Search User'),
                      content: Text(
                          'You have searched for ${textEditingController.text}'),
                      actions: <Widget>[
                        PlatformDialogAction(
                          child: PlatformText('OK'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
