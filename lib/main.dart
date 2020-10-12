import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart';
import 'Objeto.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Correios SOAP Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Correios SOAP Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: Colors.grey,
              child: Text("check"),
              onPressed: _check,
            ),
            FlatButton(
              color: Colors.grey,
              child: Text("getUrl"),
              onPressed: _getUrL,
            ),
            FlatButton(
              color: Colors.grey,
              child: Text("download"),
              onPressed: _download,
            ),
            FlatButton(
              color: Colors.grey,
              child: Text("storage 权限"),
              onPressed: _getSdPermission,
            ),
            FlatButton(
              color: Colors.grey,
              child: Text("覆盖"),
              onPressed: _cover,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _check() async {
    String now = getLongNow();
    String boxId = "MB4WPIP";
    print("check" + ",now=" + now.toString());
    var envelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <checkDataUpdate xmlns="http://www.autorke.cn/">
      <boxId>${boxId}</boxId>
      <localDataTime>${now}</localDataTime>
    </checkDataUpdate>
  </soap:Body>
</soap:Envelope>
''';
    http.Response response =
        await http.post('http://www.kydz.online:8188/KYDZMiniWebService.asmx',
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "SOAPAction": "http://www.autorke.cn/checkDataUpdate",
              "Host": "www.kydz.online"
            },
            body: envelope);

    xml.XmlDocument parsedXml = xml.parse(response.body);
    print("response=="+parsedXml.toString());
    final textual = parsedXml.findAllElements("Value");
    if(textual.isNotEmpty){
      bool needUpdate=textual.toList()[0].text.parseBool();
      print(needUpdate.toString());
    }
  }

  void _getUrL() async{
    String now = getLongNow();
    String boxId = "MB4WPIP";
    print("check" + ",now=" + now.toString());
    var envelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <getDownloadUrl xmlns="http://www.autorke.cn/">
      <boxId>${boxId}</boxId>
      <localDataTime>${now}</localDataTime>
    </getDownloadUrl>
  </soap:Body>
</soap:Envelope>
''';
    http.Response response =
        await http.post('http://www.kydz.online:8188/KYDZMiniWebService.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://www.autorke.cn/getDownloadUrl",
          "Host": "www.kydz.online"
        },
        body: envelope);

    xml.XmlDocument parsedXml = xml.parse(response.body);
    print("response=="+parsedXml.toString());
    final textual = parsedXml.findAllElements("Value");
    if(textual.isNotEmpty){
      String url=textual.toList()[0].text;
      print(url);
    }
  }
  _download() async {
    Directory dir = await getExternalStorageDirectory();
    String dest = join(dir.path, "data_access.db");
    print("dest" + dest);

    Dio dio = new Dio();
    dio.download(
        "http://www.kydz.online:8188/minidata/mini00-ful-202009300921.bin",
        dest, onReceiveProgress: (count, total) {
      print("progress" +((count/total *10000 )/100).round().toString()+"%");

    });
  }

  String getLongNow() {
    String year = DateTime.now().year.toString();
    // String year = "2022";
    String mouth = (DateTime.now().month > 9)
        ? DateTime.now().month.toString()
        : ("0" + DateTime.now().month.toString());
    String day = DateTime.now().day > 9
        ? DateTime.now().day.toString()
        : ("0" + DateTime.now().day.toString());

    return (year + mouth + day + "0000");
  }

  void _getSdPermission() async{

    List<PermissionGroup> permissions = <PermissionGroup>[
      PermissionGroup.storage
    ];
    Map<PermissionGroup, PermissionStatus> permissionMap =
        await PermissionHandler().requestPermissions(permissions);
  }

  void _cover() async {
    var dbPath = await getDatabasesPath();
    var docFilePath = join(dbPath, "data_access.db");
    var exists = await databaseExists(docFilePath);
    if(!exists){
      ByteData data = await rootBundle.load(join("assets/database", "data_access.db"));
      List<int> bytes = data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(docFilePath).writeAsBytes(bytes, flush: true);
      print("first load suc");
    }else{
      print("cover");
      ByteData data = await rootBundle.load(join("assets/database_cover", "data_access.db"));
      List<int> bytes = data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(docFilePath).writeAsBytes(bytes, flush: true);
      print("covered");

    }
  }
}
extension BoolParsing on String {
  bool parseBool() {
    return this.toLowerCase() == 'true';
  }
}
