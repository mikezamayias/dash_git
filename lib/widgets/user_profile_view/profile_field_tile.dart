import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ProfileFieldTile extends StatelessWidget {
  const ProfileFieldTile({
    super.key,
    required this.fieldName,
    required this.fieldValue,
  });

  final String fieldName;
  final String fieldValue;

  @override
  Widget build(BuildContext context) {
    return PlatformListTile(
      title: Text(
        fieldName,
        style: platformThemeData(
          context,
          material: (data) => data.textTheme.bodyLarge,
          cupertino: (data) => data.textTheme.textStyle,
        ),
      ),
      subtitle: Text(
        fieldValue,
        maxLines: 5,
        style: platformThemeData(
          context,
          material: (data) => data.textTheme.bodySmall,
          cupertino: (data) => data.textTheme.textStyle,
        ),
      ),
    );
  }
}
