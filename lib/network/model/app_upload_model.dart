

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soap/network/entity/bean_upload_result.dart';
import 'package:flutter_soap/utils/common_utils.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

import '../network_manager.dart';


class ApkUploadModel{
  downloadAndInstall(BuildContext context) async {
    if (Platform.isIOS) {
      String url =
          'https://apps.apple.com/cn/app/%E9%AB%98%E5%BE%B7%E5%9C%B0%E5%9B%BE-%E7%B2%BE%E5%87%86%E5%9C%B0%E5%9B%BE-%E6%97%85%E6%B8%B8%E5%87%BA%E8%A1%8C%E5%BF%85%E5%A4%87/id461703208?l=en'; // 这是微信的地址，到时候换成自己的应用的地址
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      String saveDirectory = await CommonUtils.getPhoneLocalPath(context);
      String fileName = "new2.apk";
      String saveFilePath = "$saveDirectory/$fileName";
      print("saveFilePath"+saveFilePath);
      Response response = await NetworkManager.shared().download(
          'http://114.215.147.2:9355/FileUpLoad/2020-10/Apks/kydw002_1_01.apk', saveFilePath,
          showProgress: true, options: RequestOptions(  baseUrl:"http://114.215.147.2:9355/",receiveTimeout: 10 * 60 * 1000));
      if (response.statusCode == 200) {
        InstallPlugin.installApk(saveFilePath, 'com.example.kydwallround')
            .then((result) {
          print('install apk $result');
        }).catchError((error) {
          print('install apk error: $error');
        });
      }
    }
  }
}