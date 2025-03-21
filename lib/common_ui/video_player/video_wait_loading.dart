import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youmi/common_ui/youmi_loading/youmi_loading.dart';
import 'package:youmi/utils/string_utils.dart';

class VideoWaitLoading extends StatelessWidget {
  final String imageUrl;
  final String heroKeyTag;
  const VideoWaitLoading(
      {super.key, required this.imageUrl, required this.heroKeyTag});

  @override
  Widget build(BuildContext context) {
    var child = CachedNetworkImage(
      imageUrl: imageUrl,
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        color: Theme.of(context).primaryColor,
      ),
      width: double.infinity,
      height: double.infinity,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          LinearProgressIndicator(value: downloadProgress.progress),
      // fit: BoxFit.cover,
    );
    return Stack(children: [
      StringUtils.isEmpty(heroKeyTag)
          ? child
          : Hero(
              tag: "$imageUrl:$heroKeyTag",
              child: child,
            ),
      Positioned(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        child: Center(child: YoumiLoading()),
      )
    ]);
  }
}
