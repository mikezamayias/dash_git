import 'package:json_annotation/json_annotation.dart';

part 'follower_model.g.dart';

@JsonSerializable()
class FollowerModel {
  final String? login;
  final int? id;
  @JsonKey(name: 'node_id')
  final String? nodeId;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  final String? gravatarId;
  final String? url;
  @JsonKey(name: 'html_url')
  final String? htmlUrl;
  @JsonKey(name: 'followers_url')
  final String? followersUrl;
  @JsonKey(name: 'following_url')
  final String? followingUrl;
  @JsonKey(name: 'gists_url')
  final String? gistsUrl;
  @JsonKey(name: 'starred_url')
  final String? starredUrl;
  @JsonKey(name: 'subscriptions_url')
  final String? subscriptionsUrl;
  @JsonKey(name: 'organizations_url')
  final String? organizationsUrl;
  @JsonKey(name: 'repos_url')
  final String? reposUrl;
  @JsonKey(name: 'events_url')
  final String? eventsUrl;
  @JsonKey(name: 'received_events_url')
  final String? receivedEventsUrl;
  final String? type;
  @JsonKey(name: 'site_admin')
  final bool? siteAdmin;

  FollowerModel({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.siteAdmin,
  });

  factory FollowerModel.fromJson(Map<String, dynamic> json) =>
      _$FollowerModelFromJson(json);
  Map<String, dynamic> toJson() => _$FollowerModelToJson(this);
}

