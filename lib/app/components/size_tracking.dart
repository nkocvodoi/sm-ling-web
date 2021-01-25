import 'package:flutter/cupertino.dart';

class SizeTrackingWidget extends StatefulWidget {
  Widget child;
  ValueNotifier<Size> sizeValueNotifier;
  SizeTrackingWidget({Key key, @required this.sizeValueNotifier, @required this.child}) : super(key: key);
  @override
  _SizeTrackingWidgetState createState() => _SizeTrackingWidgetState();
}

class _SizeTrackingWidgetState extends State<SizeTrackingWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getSize();
    });
  }

  _getSize() {
    RenderBox renderBox = context.findRenderObject();
    widget.sizeValueNotifier.value = renderBox.size;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}