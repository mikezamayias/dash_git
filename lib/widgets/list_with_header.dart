import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ListWithHeader extends StatelessWidget {
  const ListWithHeader({
    super.key,
    required this.header,
    required this.widgets,
  });

  final PlatformListTile header;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      cupertino: (context, _) => SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: CupertinoListSection.insetGrouped(
          topMargin: 0,
          hasLeading: false,
          header: header,
          children: widgets,
        ),
      ),
      material: (context, _) => Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              header,
              for (final widget in widgets) widget,
            ],
          ),
        ),
      ),
    );
  }
}
