import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class MyTabIndicator extends Decoration {

  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    // TODO: implement createBoxPainter
    return new _CustomPainter(this, onChanged);
  }
}

class _CustomPainter extends BoxPainter {
  
  
  final MyTabIndicator decoration;

  _CustomPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    
    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    final Rect rect = offset & configuration.size;
    final Paint paint = Paint();
    paint.color = Colors.blueAccent;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(10.0)), paint);
  }

}