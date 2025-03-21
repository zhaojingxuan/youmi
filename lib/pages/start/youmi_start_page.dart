import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youmi/global_vm.dart';
import 'package:youmi/pages/start/youmi_start_vm.dart';
import 'package:youmi/route/route_utils.dart';
import 'package:youmi/route/routes.dart';

class YoumiStartPage extends StatefulWidget {
  const YoumiStartPage({super.key});

  @override
  State<YoumiStartPage> createState() => _YoumiStartPageState();
}

class _YoumiStartPageState extends State<YoumiStartPage> {
  YoumiStartVm youmiStartVm = YoumiStartVm();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((st) async {
      await youmiStartVm.userActivation();
      if (!mounted) return;
      await Provider.of<GlobalVm>(context, listen: false).updateUserInfo();
      if (!mounted) return;
      RouteUtils.pushNamedAndRemoveUntil(context, RoutePath.youmitab);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/start_bg.png"),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent, //把appbar的背景色改成透明
            //   // elevation: 0,//appbar的阴影
            //   title: Text("widget.title"),
            // ),
            body: Center(
              child: Image.asset(
                "assets/images/logo.png",
                width: 128.w,
                height: 128.w,
                fit: BoxFit.contain,
              ),
            )));
  }
}
