import 'package:json_annotation/json_annotation.dart';

import 'owner_model.dart';

part 'repository_model.g.dart';

@JsonSerializable()
class RepositoryModel {
  final int? id;
  @JsonKey(name: 'node_id')
  final String? nodeId;
  final String? name;
  @JsonKey(name: 'full_name')
  final String? fullName;
  final bool? private;
  final OwnerModel? owner;
  @JsonKey(name: 'html_url')
  final String? htmlUrl;
  final String? description;
  final bool? fork;
  final String? url;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'pushed_at')
  final String? pushedAt;
  @JsonKey(name: 'git_url')
  final String? gitUrl;
  @JsonKey(name: 'ssh_url')
  final String? sshUrl;
  @JsonKey(name: 'clone_url')
  final String? cloneUrl;
  @JsonKey(name: 'svn_url')
  final String? svnUrl;
  final int? size;
  @JsonKey(name: 'stargazers_count')
  final int? stargazersCount;
  @JsonKey(name: 'watchers_count')
  final int? watchersCount;
  final String? language;
  @JsonKey(name: 'has_issues')
  final bool? hasIssues;
  @JsonKey(name: 'has_projects')
  final bool? hasProjects;
  @JsonKey(name: 'has_downloads')
  final bool? hasDownloads;
  @JsonKey(name: 'has_wiki')
  final bool? hasWiki;
  @JsonKey(name: 'has_pages')
  final bool? hasPages;
  @JsonKey(name: 'has_discussions')
  final bool? hasDiscussions;
  @JsonKey(name: 'forks_count')
  final int? forksCount;
  final bool? archived;
  final bool? disabled;
  @JsonKey(name: 'open_issues_count')
  final int? openIssuesCount;
  @JsonKey(name: 'allow_forking')
  final bool? allowForking;
  @JsonKey(name: 'is_template')
  final bool? isTemplate;
  @JsonKey(name: 'web_commit_signoff_required')
  final bool? webCommitSignoffRequired;
  final String? visibility;
  final int? forks;
  @JsonKey(name: 'open_issues')
  final int? openIssues;
  final int? watchers;
  @JsonKey(name: 'default_branch')
  final String? defaultBranch;

  RepositoryModel({
    this.id,
    this.nodeId,
    this.name,
    this.fullName,
    this.private,
    this.owner,
    this.htmlUrl,
    this.description,
    this.fork,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.pushedAt,
    this.gitUrl,
    this.sshUrl,
    this.cloneUrl,
    this.svnUrl,
    this.size,
    this.stargazersCount,
    this.watchersCount,
    this.language,
    this.hasIssues,
    this.hasProjects,
    this.hasDownloads,
    this.hasWiki,
    this.hasPages,
    this.hasDiscussions,
    this.forksCount,
    this.archived,
    this.disabled,
    this.openIssuesCount,
    this.allowForking,
    this.isTemplate,
    this.webCommitSignoffRequired,
    this.visibility,
    this.forks,
    this.openIssues,
    this.watchers,
    this.defaultBranch,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) =>
      _$RepositoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$RepositoryModelToJson(this);
}
