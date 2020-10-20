import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// base64库
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'easy_alert.dart';
class CommonUtils{
  //获取手机目录-文件保存路径
  static Future<String> getPhoneLocalPath(BuildContext context) async {
    final directory=Theme.of(context).platform==TargetPlatform.android?await getExternalStorageDirectory():await getApplicationDocumentsDirectory();
    return directory.path;
  }

  //关闭键盘
  static void closeSoftBoard(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /*
  * Base64加密
  */
  static String encode(String data){
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }
  /*
  * Base64解密
  */
  static String decode(String data){
    List<int> bytes = base64Decode(data);
    // 网上找的很多都是String.fromCharCodes，这个中文会乱码
    //String txt1 = String.fromCharCodes(bytes);
    String result = utf8.decode(bytes);
    return result;
  }

  /*
  * 通过图片路径将图片转换成Base64字符串
  */
  static Future<String> image2Base64(String path) async {
    File file = new File(path);
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }
  /*
  * 将图片文件转换成Base64字符串
  */
  static Future<String> imageFile2Base64(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  /*
  * 将Base64字符串的图片转换成图片
  */
  static Future<Image> base642Image(String base64Txt) async {
    var  decodeTxt = base64.decode(base64Txt);
    return Image.memory(decodeTxt,
      width:100,fit: BoxFit.fitWidth,
      gaplessPlayback:true, //防止重绘
    );
  }

  static Future<ui.Image> getImage(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }


  static save(String key,String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
  static Future<String> get(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return   prefs.getString(key);
  }


  static void showSureTipsDialog(String content){
    var context = navigatorState.currentState.overlay.context;
    EasyAlert.show(context,  title: "提示" ,  content: content,  showCancel: false,
        confirmText: "确定");
  }
}