

import 'package:json_annotation/json_annotation.dart';
// 将在运行生成命令后自动生成
part 'bean_upload_result.g.dart';

@JsonSerializable()
class UploadFileResultNetWork {
  @JsonKey(name: "OriginalName")
  String originalName;
  @JsonKey(name: "Suffix")
  String suffix;
  @JsonKey(name: "Size")
  double size;
  @JsonKey(name: "FileAddress")
  String fileAddress;
  @JsonKey(name: "Version")
  double version;
  @JsonKey(name: "Remark")
  String remark;



  UploadFileResultNetWork(this.originalName, this.suffix, this.size,
    this.fileAddress, this.version, this.remark);


  @override
  String toString() {
    return 'UploadFileResult{ originalName: $originalName, suffix: $suffix, size: $size, fileAddress: $fileAddress, version: $version, remark: $remark}';
  }

  factory UploadFileResultNetWork.fromJson(Map<String, dynamic> json) => _$UploadFileResultNetWorkFromJson(json);


  Map<String, dynamic> toJson() => _$UploadFileResultNetWorkToJson(this);

}