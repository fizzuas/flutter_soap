//
// header_interceptor.dart
// KYSuperApp
//
// Created by 曹雪松 on 2020/7/27.
// Copyright © 2020 KYDW. All rights reserved.
//
// HeaderInterceptor 用于处理所有请求头的 token
// generator_interceptor.dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';


class HeaderInterceptor extends Interceptor {

  @override
  Future onRequest(RequestOptions options) async {
    if (options.baseUrl == Api.baseUrl) {
      final prefs = await SharedPreferences.getInstance();
      // options.headers.addAll({
      //   userTokenKey : prefs.get(userTokenKey)
      // });
    }
    return super.onRequest(options);
  }

}
