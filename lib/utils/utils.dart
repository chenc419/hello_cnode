import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:hello_cnode/constants/index.dart';
import 'package:hello_cnode/routes/routeParams.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static String randomAvatar() {
    List<String> _avatars = [
      DEFAULT_AVATAR,
      DEFAULT_AVATAR_1,
      DEFAULT_AVATAR_2,
      DEFAULT_AVATAR_3,
      DEFAULT_AVATAR_4,
      DEFAULT_AVATAR_5,
      DEFAULT_AVATAR_6,
      DEFAULT_AVATAR_7,
      DEFAULT_AVATAR_8,
      DEFAULT_AVATAR_9,
      DEFAULT_AVATAR_10,
      DEFAULT_AVATAR_11,
      DEFAULT_AVATAR_12,
      DEFAULT_AVATAR_13,
      DEFAULT_AVATAR_14,
      DEFAULT_AVATAR_15,
      DEFAULT_AVATAR_16,
      DEFAULT_AVATAR_17
    ];
    Random _index = Random();
    return _avatars[_index.nextInt(18)];
  }

  // 文件缓存
  static Future<SharedPreferences> preference() async {
    return await SharedPreferences.getInstance();
  }

  // 扫描二维码
  static Future<Null> scanQrCode<T extends Function>(BuildContext context, [T callback]) async {
    String cameraScanResult = await scanner.scan();
    if (cameraScanResult.startsWith('http')) {
      Navigator.of(context)
          .pushNamed('/webview', arguments: ToWebView(cameraScanResult, '扫码'));
    } else {
      final prefs = await Utils.preference();
      prefs.setString('token', cameraScanResult);
      if (callback != null) {
        callback();
      }
    }
  }
}
