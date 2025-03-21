import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';

class StringUtils {
  ///限制字符串最大长度显示，超出用...
  static String limitString({required String? content, int? limits = 12}) {
    if (content == null && content?.isEmpty == true) {
      return "";
    }
    try {
      if ((content?.length ?? 0) <= (limits ?? 12)) {
        return content ?? "";
      } else {
        return "${content?.substring(0, limits)}...";
      }
    } catch (err) {
      return "";
    }
  }

  ///校验字符串是否为空
  static String str2base64(String? target) {
    if (isEmpty(target)) {
      return '';
    }
    List<int> bytes = utf8.encode(target ?? '');
    return base64.encode(bytes);
  }

  ///校验字符串是否为空
  static bool isEmpty(String? target) {
    return target == null || target == "";
  }

  ///校验输入框字符串是否为空
  static bool isEmptyByTEditController(TextEditingController? controller) {
    return isEmpty(controller?.text);
  }

  ///默认取数组第一个下标，传入index取指定下标值
  static String takeStrForList(List<String?>? imageList, {int? index}) {
    if (imageList == null || imageList.isEmpty == true) {
      return "";
    }
    if (index == null) {
      return imageList[0] ?? "";
    } else {
      if ((imageList.length - 1) >= index) {
        return imageList[index] ?? "";
      } else {
        return "";
      }
    }
  }

  static String toMd5(String str) {
    final bytes = utf8.encode(str);

    return md5.convert(bytes).toString();
  }

  // 签名函数
  static String signData(Map<String, dynamic> data, String key) {
    // 第一步：过滤非空参数并按 ASCII 码排序
    final nonEmptyParams = <String, dynamic>{};
    data.forEach((k, v) {
      if (v != 0 && v != null && v.toString().isNotEmpty) {
        nonEmptyParams[k] = v;
      }
    });
    final sortedKeys = nonEmptyParams.keys.toList()..sort();
    // 拼接成 URL 键值对格式的字符串 stringA
    final stringA =
        sortedKeys.map((key) => '$key=${nonEmptyParams[key]}').join('&');
    // 第二步：在 stringA 最后拼接上 key 得到 stringSignTemp 字符串
    final stringSignTemp = '$stringA&$key';

    // 对 stringSignTemp 进行 MD5 运算
    return toMd5(stringSignTemp);
  }

  static String formatDuration(Duration duration) {
    // 获取小时、分钟和秒数
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;

    // 如果时间大于一小时，显示小时、分钟和秒
    if (hours > 0) {
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    } else {
      // 如果时间小于一小时，显示分钟和秒
      return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    }
  }
}
