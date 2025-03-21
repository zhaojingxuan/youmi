import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class YoumiLoading extends StatelessWidget {
  const YoumiLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 50.w,
        child: LoadingIndicator(
            indicatorType: Indicator.lineSpinFadeLoader,

            /// Required, The loading type of the widget
            colors: [
              Colors.red,
              Colors.orange,
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.indigo,
              Colors.purple,
            ],

            /// Optional, The color collections
            strokeWidth: 2,

            /// Optional, The stroke of the line, only applicable to widget which contains line
            // backgroundColor: Colors.black,
            /// Optional, Background of the widget
            pathBackgroundColor: Colors.black

            /// Optional, the stroke backgroundColor
            ));
  }
}
