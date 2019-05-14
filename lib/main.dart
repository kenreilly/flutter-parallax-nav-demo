// Flutter Parallax Background Navigation Demo
// @author Kenneth Reilly <kenneth@innovationgroup.tech>
// Copyright 2019 The Innovation Group - MIT License

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './components/app-container.dart';

class ParallaxDemo extends StatelessWidget {
	
    @override
    Widget build(BuildContext context) {

		List<String> _screens = [ "A", "B", "C", "D", "E" ];

        return MaterialApp(
            title: "Parallax BG",
            theme: ThemeData(primarySwatch: Colors.brown),
          	home: AppContainer(screens: _screens),
      	);
    }
}

Future<void> main() async {

	await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
	runApp(ParallaxDemo());
}