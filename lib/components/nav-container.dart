// Flutter Parallax Background Navigation Demo
// @author Kenneth Reilly <kenneth@innovationgroup.tech>
// Copyright 2019 The Innovation Group - MIT License

import 'dart:io';
import 'package:flutter/material.dart';
import '../services/navigation-bus.dart';
import './nav-route-view.dart';
import './nav-tab-icon.dart';

class NavContainer extends StatefulWidget {

    NavContainer({ Key key, @required this.children }) : super(key: key);

	final List<String> children;

    @override
    _NavContainerState createState() => _NavContainerState();
}

class _NavContainerState extends State<NavContainer> with SingleTickerProviderStateMixin {

	TabController _controller;

	Animation _animation;

	List<Tab> get _tabs {

		int _index = 0;
		Iterable<Tab> _map = widget.children.map<Tab>((String name) {

			Tab _tab = Tab(
				icon: new NavTabIcon(
					index: _index,
					name: name, 
					animation: _animation
				),
			);

			_index++;
			return _tab;
		});
		
		return _map.toList();
	}

	List<NavRouteView> get _routes {

		TextStyle style = Theme.of(context).textTheme.display4.copyWith(color: Colors.white);

		int _index = 0;
		Iterable<NavRouteView> _map = widget.children.map<NavRouteView>((name) { 

			NavRouteView _view = NavRouteView(
				index: _index, 
				child: Container( 
					constraints: BoxConstraints.expand(),
					child: Center(child: Text(name, style: style)) 
				), 
				animation: _animation
			);

			_index++;
			return _view;
		});
		
		return _map.toList();
	}

	@override
	void initState() {

		super.initState();

		_controller = new TabController(vsync: this, length: widget.children.length);
		_animation = _controller.animation;
		NavigationBus.registerTabController(_controller);
	}

	@override
	void dispose() {

		super.dispose();
		_controller.dispose();
	}

	@override
	Widget build(BuildContext context) {

		return Stack(
			children: <Widget> [

				Container(
					padding: Platform.isAndroid
						? EdgeInsets.only(bottom: 48)
						: EdgeInsets.only(bottom: 64),
					constraints: BoxConstraints.expand(),
					child: TabBarView(
						controller: _controller,
						children: _routes,						
					),
				),

				Column(	
					mainAxisAlignment: MainAxisAlignment.end,
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						
						( Platform.isAndroid )
						
						? TabBar(
							indicatorPadding: EdgeInsets.all(1),
							labelPadding: EdgeInsets.zero,
							controller: _controller,
							indicatorWeight: 4,
							tabs: _tabs
						)

						: Container( 
							decoration: BoxDecoration(
								gradient: LinearGradient(
									begin: Alignment.topCenter,
									end: Alignment.bottomCenter,
									colors: [
										const Color.fromARGB(8, 16, 32, 16),
										const Color.fromARGB(192, 32, 16, 32)
									]
								)
							), 
							child: TabBar(

								indicator: BoxDecoration(),
								labelPadding: EdgeInsets.only(bottom: 6, top: 4),
								indicatorPadding: EdgeInsets.only(top: 6, bottom: 12),
								controller: _controller,
								tabs: _tabs
							)
						)
					]
				)
			]
		);
	}
}