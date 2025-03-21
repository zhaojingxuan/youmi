import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:youmi/common_ui/youmi_postar/youmi_poster.dart';
import 'package:youmi/pages/home_page/Discover/discover_vm.dart';
import 'package:youmi/repository/models/youmi_home_model/youmi_banner.dart';
import 'package:youmi/route/route_utils.dart';
import 'package:youmi/route/routes.dart';

class MyBannerHeader extends StatelessWidget {
  const MyBannerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Selector<DiscoverVm, List<YoumiBanner>?>(
        selector: (_, vm) => vm.bannerList,
        builder: (context, bannerList, child) {
          return Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 6.w, bottom: 16.w),
            child: Stack(
              children: [
                SizedBox(
                  height: 291.w,
                  width: double.infinity,
                  child: Swiper(
                    index: currentIndex,
                    scale: 0.8,
                    viewportFraction: 0.5,
                    indicatorLayout: PageIndicatorLayout.NONE,
                    autoplay: true,
                    pagination: const SwiperPagination(),
                    control: null,
                    itemCount: bannerList?.length ?? 0,
                    onIndexChanged: (value) {
                      currentIndex = value;
                    },
                    itemBuilder: (context, index) {
                      var heroKeyTag = 'discoverPage_banner_$index';
                      return GestureDetector(
                          onTap: () {
                            RouteUtils.pushForNamed(context, RoutePath.playPage,
                                arguments: {
                                  "dramaId": bannerList?[index].dramaId,
                                  "picUrl": bannerList?[index].bannerImage,
                                  "heroKeyTag": heroKeyTag
                                });
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                  width: 208.w,
                                  height: 291.w,
                                  child: YoumiPoster(
                                      heroKeyTag: heroKeyTag,
                                      postUrl: bannerList?[index].bannerImage ??
                                          '')),
                            ],
                          ));
                    },
                  ),
                ),
                (bannerList?.isNotEmpty ?? false)
                    ? Positioned(
                        left: 263.w,
                        bottom: 30.w,
                        child: GestureDetector(
                          onTap: () {
                            RouteUtils.pushForNamed(context, RoutePath.playPage,
                                arguments: {
                                  "dramaId": bannerList?[currentIndex].dramaId,
                                  "picUrl":
                                      bannerList?[currentIndex].bannerImage,
                                  "heroKeyTag":
                                      'discoverPage_banner_$currentIndex'
                                });
                          },
                          child: Image.asset(
                            "assets/images/banner-btn.png",
                            width: 61.w,
                            height: 38.w,
                          ),
                        ))
                    : SizedBox.shrink()
              ],
            ),
          );
        });
  }
}
