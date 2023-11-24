import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FutureProviderWrapper<T> extends ConsumerWidget {
  const FutureProviderWrapper({
    super.key,
    required this.provider,
    required this.builder,
  });

  final FutureProvider<T> provider;
  final Widget Function(T) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(provider).when(
          data: builder,
          loading: () => Center(
            child: PlatformCircularProgressIndicator(),
          ),
          error: (error, _) => Center(
            child: Text(
              '$error',
              style: platformThemeData(
                context,
                material: (data) => data.textTheme.bodyLarge!.copyWith(
                  color: data.colorScheme.error,
                ),
                cupertino: (data) => data.textTheme.textStyle.copyWith(
                  color: CupertinoColors.destructiveRed,
                ),
              ),
            ),
          ),
        );
  }
}
