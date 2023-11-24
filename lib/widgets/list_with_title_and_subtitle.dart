import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ListWithTitleAndSubtitle extends StatelessWidget {
  const ListWithTitleAndSubtitle({
    super.key,
    this.title,
    this.header,
    required this.widgets,
  });

  final Widget? title;
  final Widget? header;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      cupertino: (context, _) => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 16),
              child: header,
            ),
            CupertinoListSection.insetGrouped(
              topMargin: 0,
              hasLeading: false,
              header: title,
              children: widgets,
            ),
          ],
        ),
      ),
      material: (context, _) => SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            if (header != null) header!,
            if (title != null) title!,
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => widgets[index],
              separatorBuilder: (context, index) => const Divider(),
              itemCount: widgets.length,
            ),
          ],
        ),
      ),
    );
  }
}
