import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youmi/global_vm.dart';

class SwitchAutomaticRelease extends StatefulWidget {
  const SwitchAutomaticRelease({super.key});

  @override
  State<SwitchAutomaticRelease> createState() => _SwitchAutomaticReleaseState();
}

class _SwitchAutomaticReleaseState extends State<SwitchAutomaticRelease> {
  late GlobalVm _globalVm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _globalVm = Provider.of<GlobalVm>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<GlobalVm, bool>(
      selector: (context, vm) => vm.automaticRelease,
      builder: (context, automaticRelease, child) {
        return Switch(
          value: automaticRelease,
          onChanged: (bool newValue) {
            setState(() {
              _globalVm.automaticRelease = newValue;
            });
          },
        );
      },
    );
  }
}
