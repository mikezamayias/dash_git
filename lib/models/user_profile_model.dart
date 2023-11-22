import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  String? login;
  int? id;
  @JsonKey(name: 'node_id')
  String? nodeId;
  @JsonKey(name: 'avatar_url')
  String? avatarUrl;
  @JsonKey(name: 'gravatar_id')
  String? gravatarId;
  String? url;
  @JsonKey(name: 'html_url')
  String? htmlUrl;
  @JsonKey(name: 'followers_url')
  String? followersUrl;
  @JsonKey(name: 'following_url')
  String? followingUrl;
  @JsonKey(name: 'gists_url')
  String? gistsUrl;
  @JsonKey(name: 'starred_url')
  String? starredUrl;
  @JsonKey(name: 'subscriptions_url')
  String? subscriptionsUrl;
  @JsonKey(name: 'organizations_url')
  String? organizationsUrl;
  @JsonKey(name: 'repos_url')
  String? reposUrl;
  @JsonKey(name: 'events_url')
  String? eventsUrl;
  @JsonKey(name: 'received_events_url')
  String? receivedEventsUrl;
  String? type;
  @JsonKey(name: 'site_admin')
  bool? siteAdmin;
  String? name;
  String? company;
  String? blog;
  String? location;
  String? email;
  bool? hireable;
  String? bio;
  @JsonKey(name: 'twitter_username')
  String? twitterUsername;
  @JsonKey(name: 'public_repos')
  int? publicRepos;
  @JsonKey(name: 'public_gists')
  int? publicGists;
  int? followers;
  int? following;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  UserProfileModel({
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
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.hireable,
    this.bio,
    this.twitterUsername,
    this.publicRepos,
    this.publicGists,
    this.followers,
    this.following,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor for creating a new `UserProfileModel` instance
  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  // Method for converting a `UserProfileModel` instance to a map
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
