import 'package:json_annotation/json_annotation.dart';

part 'license_model.g.dart';

@JsonSerializable()
class LicenseModel {
  String? key;
  String? name;
  @JsonKey(name: 'spdx_id')
  String? spdxId;
  String? url;
  @JsonKey(name: 'node_id')
  String? nodeId;

  LicenseModel({this.key, this.name, this.spdxId, this.url, this.nodeId});

  factory LicenseModel.fromJson(Map<String, dynamic> json) =>
      _$LicenseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LicenseModelToJson(this);
}
