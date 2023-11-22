import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SearchUserView extends StatelessWidget {
  const SearchUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Search User'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: PlatformWidget(
                  cupertino: (context, _) => CupertinoSearchTextField(
                    placeholder: 'Search User',
                    onSubmitted: (String value) {
                      showPlatformDialog(
                        context: context,
                        builder: (_) => PlatformAlertDialog(
                          title: const Text('Search User'),
                          content: Text('You have searched for $value'),
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
                  material: (context, _) => TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search User',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (String value) {
                      showPlatformDialog(
                        context: context,
                        builder: (_) => PlatformAlertDialog(
                          title: const Text('Search User'),
                          content: Text('You have searched for $value'),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
