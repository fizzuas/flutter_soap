//
// network_connectivity.dart
// KYSuperApp
//
// Created by 曹雪松 on 2020/7/27.
// Copyright © 2020 KYDW. All rights reserved.
//

import 'package:connectivity/connectivity.dart';

Future<bool> isNetworkAvailable() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
}

Future<bool> isNetworkUnavailable() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult == ConnectivityResult.none;
}