import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youmi/pages/home_page/Discover/discover_vm.dart';
import 'package:youmi/pages/home_page/Discover/listItemView/listItemView1.dart';
import 'package:youmi/pages/home_page/Discover/listItemView/listItemView2.dart';
import 'package:youmi/pages/home_page/Discover/listItemView/listItemView3.dart';
import 'package:youmi/repository/models/youmi_home_model/youmi_home_module.dart';

class MyHomeListView extends StatelessWidget {
  const MyHomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<DiscoverVm, List<YoumiHomeModule>?>(
        selector: (_, vm) => vm.modulesList,
        builder: (context, modulesList, child) {
          return Column(
            children: [
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: modulesList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    int type = modulesList?[index].type ?? 2;
                    switch (type) {
                      case 1:
                        return ListitemView1(
                            item: modulesList?[index], diffKey: '$index');
                      case 2:
                        return ListitemView2(
                            item: modulesList?[index], diffKey: '$index');
                      default:
                        return ListitemView3(
                            item: modulesList?[index], diffKey: '$index');
                    }
                  },
                ),
              ),
            ],
          );
        });
  }
}
