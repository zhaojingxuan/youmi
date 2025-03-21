import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youmi/generated/l10n.dart';
import 'package:youmi/global_vm.dart';
import 'package:youmi/pages/home_page/Me/vip_store_card/countdown_timer.dart';
import 'package:youmi/pages/home_page/Me/me_vm.dart';
import 'package:youmi/repository/models/store_vip/store_vip.dart';

class VipStoreCardList extends StatefulWidget {
  const VipStoreCardList({super.key});

  @override
  State<VipStoreCardList> createState() => _VipStoreCardStateList();
}

class _VipStoreCardStateList extends State<VipStoreCardList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MeVm>(context, listen: false).getUserStoreVip();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<MeVm, List<StoreVip>>(
      selector: (context, vm) => vm.listStoreVip,
      builder: (context, listStoreVip, child) {
        return Column(
          children: [
            for (int i = 0; i < listStoreVip.length; i++)
              _vipCard(listStoreVip[i]),
          ],
        );
      },
    );
  }

  Widget _vipCard(StoreVip vip) {
    Image image = Image.asset(
      "assets/images/buyvip1.png",
      width: 343.w,
      height: 156.w,
    );
    Color color = Colors.white;
    switch (vip.type) {
      case 1:
        image = Image.asset(
          "assets/images/buyvip1.png",
          width: 343.w,
          height: 156.w,
        );
        color = Color.fromRGBO(112, 0, 204, 1);
        break;
      case 3:
        image = Image.asset(
          "assets/images/buyvip3.png",
          width: 343.w,
          height: 156.w,
        );

        color = Color.fromRGBO(183, 41, 5, 1);
        break;
      default:
    }

    String currencySymbol = NumberFormat.simpleCurrency(
            locale: Localizations.localeOf(context).languageCode)
        .currencySymbol; // 仅符号

    int secondsRemaining = Provider.of<GlobalVm>(context, listen: false)
            .meUserinfo
            ?.firstActTime ??
        0;

    return DefaultTextStyle(
        style: TextStyle(color: color),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.w),
            child: Container(
                margin: EdgeInsets.only(bottom: 16.w),
                child: Stack(
                  children: [
                    image,
                    Positioned(
                      left: 10.w,
                      top: 12.w,
                      child: Text(
                        vip.vipName ?? '',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Positioned(
                        left: 16.w,
                        top: 40.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              currencySymbol,
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              NumberFormat('#,###.00')
                                  .format(double.tryParse(vip.price ?? '0')),
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            DefaultTextStyle(
                              style: TextStyle(
                                  color: color.withValues(alpha: 0.4)),
                              child: Stack(children: [
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.w),
                                    child: Row(
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          currencySymbol,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Text(
                                          NumberFormat('#,###.00').format(
                                              double.tryParse(
                                                  vip.price ?? '0')),
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ],
                                    )),
                                Positioned(
                                    right: 0.w,
                                    left: 0,
                                    bottom: 10.w,
                                    child: Divider(
                                        color: color.withValues(alpha: 0.4),
                                        height: 1.w))
                              ]),
                            )
                          ],
                        )),
                    Positioned(
                        left: 16.w,
                        top: 82.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0;
                                i < (vip.introduce?.split(',').length ?? 0);
                                i++)
                              Padding(
                                padding: EdgeInsets.only(bottom: 4.w),
                                child: Text(
                                  vip.introduce?.split(',')[i] ?? '',
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              )
                          ],
                        )),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: secondsRemaining > 24 * 60 * 60 &&
                              vip.type == 1 // 24小时内显示倒计时
                          ? SizedBox.shrink()
                          : _tip(
                              vip.type == 1
                                  ? CountdownTimer()
                                  : Text(S.of(context).limited_time_offer),
                            ),
                    )
                  ],
                ))));
  }

  Widget _tip(Widget w) {
    return ClipRRect(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.w)),
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft, // 渐变开始的位置
              end: Alignment.bottomRight, // 渐变结束的位置
              colors: [
                Color(0xFFFF7575), // #FF7575
                Color(0xFFFF2D6F), // #FF2D6F
                Color(0xFFB90355), // #B90355
                Color(0xFF780052), // #780052
              ],
              stops: [
                0.1094, // 10.94%
                0.4068, // 40.68%
                0.6959, // 69.59%
                0.9031, // 90.31%
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.w),
          child: DefaultTextStyle(
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500), // 为了让倒计时文本颜色为白色，这里设置了一个默认文本样式
              child: w)),
    );
  }
}
