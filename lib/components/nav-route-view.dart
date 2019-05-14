// Flutter Parallax Background Navigation Demo
// @author Kenneth Reilly <kenneth@innovationgroup.tech>
// Copyright 2019 The Innovation Group - MIT License

import 'package:flutter/material.dart';

class NavRouteView extends AnimatedWidget {

	const NavRouteView({
		Key key,
		@required child,
		@required int index,
		@required Animation<double> animation,
	}) : this._child = child, this._index = index, this._animation = animation, super(key: key, listenable: animation);

	final Animation<double> _animation;
	final Widget _child;
	final int _index;

	static double scaleDouble(double value, double percent) {
		return 1.0 - ( 1.0 - (value * (1.0 - percent)) - percent );
	}

	@override
	Widget build(BuildContext context) {

		return AnimatedBuilder(
			animation: _animation,
			builder: (BuildContext context, Widget child) {

				int index = _index;
				double value = _animation.value;
				double delta = value - index + 1;

				double scale = (delta >= 0.0 && delta <= 1.0) 
					? delta
					: (delta > 1 && delta < 2) ? (2 - delta) : 0;

				double _transform = scaleDouble(scale, 0.8);

				return Transform.scale(
					scale: _transform,
					child: Opacity(child: _child, opacity: scale),
				);
			}
		);
	}
}