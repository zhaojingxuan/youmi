import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youmi/repository/models/vip_task_list/task_item.dart';

class TaskProgressBar extends StatefulWidget {
  final TaskItem item;
  const TaskProgressBar({super.key, required this.item});

  @override
  State<TaskProgressBar> createState() => _TaskProgressBarState();
}

class _TaskProgressBarState extends State<TaskProgressBar> {
  TaskItem get item => widget.item;
  int _number = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((st) async {
      await Future.delayed(Duration(milliseconds: 300));
      if (mounted) {
        setState(() {
          _number = item.number ?? 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          width: double.infinity,
          height: 20.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.w),
            image: DecorationImage(
              image: AssetImage(item.states != 1
                  ? 'assets/images/progress-bg.png'
                  : 'assets/images/progress-bg-get.png'), // Use an image from assets
              fit: BoxFit
                  .cover, // Adjusts how the image fits within the container
            ),
            border: Border.all(
              color: item.states != 1
                  ? const Color.fromRGBO(172, 174, 187, 1)
                  : const Color.fromRGBO(29, 29, 39, 1), // 边框颜色
              width: 2, // 边框宽度
            ),
          ),
          child: AnimatedSwitcher(
              duration: Duration(microseconds: 300),
              child: item.states != 1
                  ? LayoutBuilder(builder: (context, constraints) {
                      return Align(
                          alignment: Alignment.topLeft,
                          child: Stack(children: [
                            AnimatedContainer(
                              duration: Duration(
                                  milliseconds: 300), // 关键点 3：必须设置 duration
                              curve: Curves.easeInOut,
                              width: constraints.maxWidth /
                                  (item.taskNumber ?? 1) *
                                  _number,
                              height: constraints.maxHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF780052),
                                    Color(0xFFB90355),
                                    Color(0xFFFF2D6F),
                                    Color(0xFFFFE5C3)
                                  ],
                                  stops: [0.0, 0.161, 0.721, 1.0],
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                width: constraints.maxWidth /
                                    (item.taskNumber ?? 1) *
                                    _number,
                                margin: EdgeInsets.all(3), // 留出边框间距
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment(-0.23, 0.97),
                                    end: Alignment(1, -0.02),
                                    colors: [
                                      Color(0xFFFF2D6F),
                                      Color(0xFFB90355)
                                    ],
                                    stops: [0.3567, 0.7149],
                                  ),
                                ),
                              ),
                            ),
                          ]));
                    })
                  : SizedBox.shrink())),
      Positioned.fill(
        child: Center(
          child: Text(
            "${item.number ?? 0}/${item.taskNumber ?? 0}",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    ]);
  }
}
