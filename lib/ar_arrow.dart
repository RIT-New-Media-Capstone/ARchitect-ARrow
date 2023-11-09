import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';

class ArArrow extends StatefulWidget {
  const ArArrow({super.key});

  @override
  State<ArArrow> createState() => _ArArrowState();
}

class _ArArrowState extends State<ArArrow> {
  ArCoreController? augmentedRealityCoreController;
  augmentedRealityViewCreated(ArCoreController coreController) {
    augmentedRealityCoreController = coreController;

    displayArrow(augmentedRealityCoreController!);
  }

  displayArrow(ArCoreController coreController) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("AR Arrow"),
          centerTitle: true,
        ),
        body: ArCoreView(onArCoreViewCreated: augmentedRealityViewCreated));
  }
}
