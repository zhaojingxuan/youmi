import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youmi/utils/string_utils.dart';

class YoumiPoster extends StatelessWidget {
  final String postUrl;
  final double? radius;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String? heroKeyTag;

  const YoumiPoster(
      {super.key,
      required this.postUrl,
      this.radius,
      this.width,
      this.height,
      this.fit,
      this.heroKeyTag});

  @override
  Widget build(BuildContext context) {
    var child = CachedNetworkImage(
      imageUrl: postUrl, // 替换为实际的图片 URL
      // placeholder: (context, url) =>
      //     const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          LinearProgressIndicator(value: downloadProgress.progress),
      fit: fit ?? BoxFit.cover,

      // cacheManager: CacheManager(
      //   Config(
      //     'customCacheKey',
      //     stalePeriod: const Duration(days: 7), // 缓存有效期为 7 天
      //     maxNrOfCacheObjects: 100, // 最多缓存 100 个对象
      //   ),
      // ),
    );
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 5.w),
        child: StringUtils.isEmpty(heroKeyTag)
            ? child
            : Hero(tag: '$postUrl:$heroKeyTag', child: child));
  }
}
