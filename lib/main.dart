import 'package:flutter/material.dart';

import 'package:subterranean_descent/navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData.dark(),
        initialRoute: RouteKey.initial.path,
        routes: routes,
        navigatorKey: Navigation.navigatorKey,
        // debugShowMaterialGrid: true,
      );
}
