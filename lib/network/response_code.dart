//
// response_code.dart
// KYSuperApp
//
// Created by 曹雪松 on 2020/7/28.
// Copyright © 2020 KYDW. All rights reserved.
//
//  dart 枚举无法指定初始值 ，所以使用静态常量实现
//

class ResponseStatusCode {
  static const int success = 1;
  static const int tokenExpired = 7;
}