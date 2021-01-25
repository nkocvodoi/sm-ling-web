import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app/components/size_tracking.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<Size> _size = ValueNotifier<Size>(Size(0, 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("example")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueListenableBuilder(
              builder: (BuildContext context, Size value, Widget child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Height of the child: ${value.height}'),
                    Text('Width of the child: ${value.width}'),
                    SizeTrackingWidget(
                      child: Container(
                          height: MediaQuery.of(context).size.width*0.4,
                          width:  MediaQuery.of(context).size.width*0.3,
                          color: Colors.red
                      ),
                      sizeValueNotifier: _size,
                    )
                  ],
                );
              },
              valueListenable: _size,
              child: null,
            )
          ],
        ),
      ),
    );
  }
}
