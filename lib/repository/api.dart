import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:youmi/http/dio_instance.dart';
import 'package:youmi/repository/models/drama_data/drama_data.dart';
import 'package:youmi/repository/models/drama_list/drama_list.dart';
import 'package:youmi/repository/models/drama_un_lock.dart';
import 'package:youmi/repository/models/history_list/history.dart';
import 'package:youmi/repository/models/history_list/history_list.dart';
import 'package:youmi/repository/models/index_sale/item_sale.dart';
import 'package:youmi/repository/models/index_sale/list_sale.dart';
import 'package:youmi/repository/models/op_action_list/op_action_list.dart';
import 'package:youmi/repository/models/store_sign_in/store_sign_in.dart';
import 'package:youmi/repository/models/store_vip/list_store_vip.dart';
import 'package:youmi/repository/models/store_vip/store_vip.dart';
import 'package:youmi/repository/models/user_activation_model.dart';
import 'package:youmi/repository/models/me_userinfo.dart';
import 'package:youmi/repository/models/user_rights/user_rights.dart';
import 'package:youmi/repository/models/vip_task_list/vip_task_list.dart';
import 'package:youmi/repository/models/youmi_home_model/youmi_home_model.dart';

class Api {
  static Api instance = Api._();
  Api._();

  ///激活账号
  Future<UserActivationModel> userActivation(Object req) async {
    showToast('激活账号 before');
    await Future.delayed(Duration(seconds: 3));
    try {
      Response response = await DioInstance.instance()
          .post(path: "api/v1/user/activation", data: req);
      showToast('激活账号 after');
      await Future.delayed(Duration(seconds: 3));
      var model = UserActivationModel.fromJson(response.data);
      return model;
    } catch (e) {
      showToast('激活账号 error: $e');
      await Future.delayed(Duration(seconds: 3));
    }
    showToast('激活账号 return');
    await Future.delayed(Duration(seconds: 3));
    return UserActivationModel();
  }

  ///首页
  Future<YoumiHomeModel> youmiHome() async {
    Response response = await DioInstance.instance().get(path: "api/v1/index");
    var model = YoumiHomeModel.fromJson(response.data);
    return model;
  }

  ///剧列表
  Future<DramaData> dramaData(int page) async {
    Response response = await DioInstance.instance()
        .get(path: "api/v1/drama/data", param: {"number": 10, "page": page});
    var model = DramaData.fromJson(response.data[0]);
    return model;
  }

  ///推荐页 /api/v1/user/index/sale
  Future<ListSale> getIndexSale() async {
    Response response =
        await DioInstance.instance().get(path: "api/v1/user/index/sale");
    var model = ListSale.fromJson({"data": response.data});
    return model;
  }

  ///用户点赞 和 收藏
  Future<bool> userOpActionSet(
    ItemSale req,
    int type,
    int action,
  ) async {
    Response response = await DioInstance.instance()
        .post(path: "api/v1/user/op_action_set", data: {
      "drama_id": req.dramaId.toString(),
      "ep_id": req.epId.toString(),
      "type": type,
      "action": action
    });
    return response.data[0] as bool;
  }

  ///用户详情
  Future<MeUserinfo> meUserInfo() async {
    Response response =
        await DioInstance.instance().get(path: "api/v1/user/info");
    return MeUserinfo.fromJson(response.data);
  }

  ///用户权益
  Future<UserRights> userRights() async {
    Response response =
        await DioInstance.instance().get(path: "api/v1/user/rights");
    return UserRights.fromJson(response.data);
  }

  ///用户权益
  Future<List<StoreVip>> userStoreVip() async {
    Response response =
        await DioInstance.instance().get(path: "api/v1/user/store/vip");
    return ListStoreVip.fromJson({'data': response.data}).data ?? [];
  }

  ///签到列表
  Future<StoreSignIn> vipStoreSignIn() async {
    Response response =
        await DioInstance.instance().get(path: "api/v1/vip/store/sign_in");
    return StoreSignIn.fromJson(response.data);
  }

  ///签到
  Future<bool> userSignAction() async {
    Response response =
        await DioInstance.instance().post(path: "api/v1/user/sign_action");
    return response.data[0] as bool;
  }

  ///历史记录
  Future<List<History>?> userHistory() async {
    Response response =
        await DioInstance.instance().get(path: "api/v1/user/history");
    return HistoryList.fromJson({"data": response.data}).data;
  }

  ///任务列表
  Future<VipTaskList> vipTaskList() async {
    Response response =
        await DioInstance.instance().get(path: "api/v1/vip/task/list");

    return VipTaskList.fromJson(response.data);
  }

  ///用户喜欢和收藏列表
  Future<OpActionList> getOpActionList(
      {required String type, required int page}) async {
    Response response = await DioInstance.instance().get(
        path: "api/v1/user/op_action_list",
        param: {"type": type, "page": page});
    return OpActionList.fromJson(response.data);
  }

  ///剧集分页
  Future<DramaList> getDramaList(
      {required int dramaId, required String page}) async {
    Response response = await DioInstance.instance().get(
        path: "api/v1/user/dramaList",
        param: {"drama_id": dramaId, "page": page});
    return DramaList.fromJson(response.data);
  }

  ///添加用户观看记录
  Future createUserShow({
    required int dramaId,
    required int epId,
    required String playTime,
    required String playDuration,
  }) async {
    await DioInstance.instance().post(path: "api/v1/create_user_show", data: {
      "drama_id": dramaId.toString(),
      "ep_id": epId.toString(),
      "play_time": playTime,
      "play_duration": playDuration,
    });
  }

  ///分享任务接口
  Future userShare({
    required String id,
  }) async {
    return (await DioInstance.instance().post(path: "api/v1/user/share", data: {
      "id": id,
    }))
        .data[0];
  }

  ///分享任务接口
  Future userTaskAward({
    required String taskId,
  }) async {
    await DioInstance.instance().post(path: "api/v1/user/taskAward", data: {
      "task_id": taskId,
    });
  }

  ///邮箱任务提交
  Future userBingEmail({
    required int id,
    required String email,
  }) async {
    return (await DioInstance.instance()
            .post(path: "api/v1/user/bing/email", data: {
      "id": id,
      "email": email,
    }))
        .data[0];
  }

  ///开启系统通知上报
  Future userSingleUp({
    required int id,
  }) async {
    return (await DioInstance.instance()
            .post(path: "api/v1/user/singleUp", data: {
      "id": id,
    }))
        .data[0];
  }

  ///剧集解锁
  Future<DramaUnLock> userDramaUnLock(Object req) async {
    Response response = await DioInstance.instance()
        .post(path: "api/v1/user/dramaUnLock", data: req);
    debugPrint("response.data: ${response.data}");
    var model = DramaUnLock.fromJson(response.data);
    return model;
  }
}
