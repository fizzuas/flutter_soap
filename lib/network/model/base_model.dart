//
// base_model.dart
// KYSuperApp
//
// Created by 曹雪松 on 2020/7/28.
// Copyright © 2020 KYDW. All rights reserved.
//
import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable()
class BaseModel {
  @JsonKey(name: "Code")
  int code;
  @JsonKey(name: "Detail")
  String detail;
  @JsonKey(name: "Message")
  String message;

  @JsonKey(name: "Value")
  dynamic value;

  BaseModel(this.code, this.detail, this.message, this.value);

  factory BaseModel.fromJson(Map<String, dynamic> json) => _$BaseModelFromJson(json);
  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}