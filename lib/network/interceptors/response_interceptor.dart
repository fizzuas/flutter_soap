//
// response_interceptor.dart
// KYSuperApp
//
// Created by 曹雪松 on 2020/9/7.
// Copyright © 2020 KYDW. All rights reserved.
//
import 'package:dio/dio.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_soap/network/model/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import '../response_code.dart';



class ResponseInterceptor extends Interceptor {

  @override
  Future onResponse(Response response) async {

    if (response.request.baseUrl == Api.baseUrl) {
      // 请求成功
      final baseModel = BaseModel.fromJson(response.data);
      if (baseModel.code == ResponseStatusCode.success) {
        return super.onResponse(response);
      }
      // 请求成功，但是接口出错
      if (baseModel.message != null && baseModel.message.isNotEmpty) {
        EasyLoading.showError(baseModel.message, duration: Duration(seconds: 2));
      }
      // if (baseModel.code == ResponseStatusCode.tokenExpired) {
      //   // 登录 token 失效
      //   // 重置本地 token, 跳转登录页面
      //   final prefs = await SharedPreferences.getInstance();
      //   prefs.setString(userTokenKey, "");
      //   navigatorState.currentState.pushNamed(Router.signInPage);
      // }
    }
    return super.onResponse(response);
  }

}