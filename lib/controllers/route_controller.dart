import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/route_model.dart';
import '../views/followers_view.dart';
import '../views/repositories_view.dart';
import '../views/search_user_view.dart';
import '../views/user_profile_view.dart';

class RouteController {
  // singleton constructor
  static final RouteController _instance = RouteController._internal();

  factory RouteController() => _instance;

  RouteController._internal();

  // attributes
  static final userProfileRoute = RouteModel(
    label: 'User Profile',
    icon: Builder(
      builder: (context) => Icon(context.platformIcons.person),
    ),
    view: const UserProfileView(),
  );
  static final repositoriesRoute = RouteModel(
    label: 'Repositories',
    icon: Builder(
      builder: (context) => Icon(context.platformIcons.folder),
    ),
    view: const RepositoriesView(),
  );
  static final followersRoute = RouteModel(
    label: 'Followers',
    icon: Builder(
      builder: (context) => Icon(context.platformIcons.person),
    ),
    view: const FollowersView(),
  );
  static final searchRoute = RouteModel(
    label: 'Search User',
    icon: Builder(
      builder: (context) => Icon(context.platformIcons.search),
    ),
    view: const SearchUserView(),
  );
  final routes = [
    userProfileRoute,
    repositoriesRoute,
    followersRoute,
    searchRoute,
  ];
  static StateProvider currentRouteIndexProvider =
      StateProvider<int>((ref) => 0);
  static StateProvider currentRouteProvider = StateProvider<RouteModel>((ref) {
    final index = ref.watch(currentRouteIndexProvider);
    log(
      _instance.routes[index].label,
      name: 'RouteController.currentRoute',
    );
    return _instance.routes[index];
  });
}
