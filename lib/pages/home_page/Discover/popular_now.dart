import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youmi/pages/home_page/Discover/discover_vm.dart';
import 'package:youmi/pages/home_page/Discover/listItemView/dramaDataView.dart';
import 'package:youmi/repository/models/drama_data/drama_datum.dart';

class PopularNow extends StatelessWidget {
  const PopularNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<DiscoverVm, List<DramaDatum>?>(
        selector: (_, vm) => vm.datumList,
        builder: (context, datumList, child) {
          return DramadataView(datumList: datumList ?? []);
        });
  }
}
