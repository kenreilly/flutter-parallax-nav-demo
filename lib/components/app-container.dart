// Flutter Parallax Background Navigation Demo
// @author Kenneth Reilly <kenneth@innovationgroup.tech>
// Copyright 2019 The Innovation Group - MIT License

import 'package:flutter/material.dart';
import '../services/navigation-bus.dart';
import './nav-container.dart';
import './background.dart';

class AppContainer extends StatelessWidget {

    AppContainer({ Key key, @required this.screens }) : super(key: key);

	final List<String> screens;

	Widget build(BuildContext context) {

		return WillPopScope(

			onWillPop: () { NavigationBus.tryPop(); },
			child: Scaffold(

				body: Stack(

					alignment: AlignmentDirectional.topStart,
					children: <Widget>[
						
						Background(assetName: 'assets/bg_01.jpg'),
						NavContainer(children: screens)
					]
				)
			)
		);
    }
}