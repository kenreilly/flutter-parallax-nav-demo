// Flutter Parallax Background Navigation Demo
// @author Kenneth Reilly <kenneth@innovationgroup.tech>
// Copyright 2019 The Innovation Group - MIT License

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

class ControllerAttachedEvent { }
class TabAnimationEvent { }
class AppNavEvent { AppNavEvent(this.route); String route; }

abstract class NavigationBus {

	static EventBus _bus = new EventBus();
	static BuildContext context;

	static get animation => (NavigationBus.tabController == null)
		? AlwaysStoppedAnimation(1.0)
		: NavigationBus.tabController.animation;
	
	static set (TabController x) { _tabController = x; }
	static get tabController => _tabController;
	static TabController _tabController;

	static StreamSubscription registerNavigationListener(Function listener) =>
		_bus.on<AppNavEvent>().listen(listener);

	static StreamSubscription registerControllerAttachedListener(Function listener) =>
		_bus.on<ControllerAttachedEvent>().listen(listener);
	
	static void registerTabController(TabController controller) {

		_tabController = controller;
		_tabController.animation.addListener(NavigationBus.onUpdateTabAnimation);
		_bus.fire(ControllerAttachedEvent());
	}

	static void onUpdateTabAnimation() => _bus.fire(TabAnimationEvent());

	static void tryPop() {
		
		if (NavigationBus.context != null) {
			Navigator.popUntil(context, (Route route) => route.isFirst);
			NavigationBus.context = null;
		}
	}
}