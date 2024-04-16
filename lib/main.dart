import 'package:flutter/material.dart';
import 'package:rui/delphi_layout/delphi_container.dart';
import 'package:rui/delphi_layout/delphi_layout.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rui"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: DelphiLayout(
              left: 0,
              top: 0,
              width: 640,
              height: 480,
              children: [
                DelphiContainer(
                  anchorLeft: true,
                  anchorTop: true,
                  anchorRight: true,
                  height: 50,
                  children: [
                    DelphiContainer(children: const [
                      Text("APP Title"),
                    ]),
                  ],
                ),
                DelphiContainer(
                  anchorLeft: true,
                  anchorTop: true,
                  anchorBottom: true,
                  width: 120,
                  children: [
                    DelphiContainer(children: const [
                      Text("left"),
                    ]),
                  ],
                ),
                DelphiContainer(
                  anchorLeft: true,
                  anchorTop: true,
                  anchorRight: true,
                  anchorBottom: true,
                  left: 125,
                  top: 55,
                  children: [
                    DelphiContainer(children: const [
                      Text("main"),
                    ]),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
