import 'package:flutter/material.dart';


class SlideMenuItem extends StatelessWidget {
  SlideMenuItem({
    Key key,
    @required this.child,
    this.alignment,
    this.padding,
    Color color,
    Decoration decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    BoxConstraints constraints,
    this.margin,
    this.transform,
  })  : assert(child != null),
        assert(margin == null || margin.isNonNegative),
        assert(padding == null || padding.isNonNegative),
        assert(decoration == null || decoration.debugAssertIsValid()),
        assert(constraints == null || constraints.debugAssertIsValid()),
        assert(
        color == null || decoration == null,
        'Cannot provide both a color and a decoration\n'
            'The color argument is just a shorthand for "decoration: new BoxDecoration(color: color)".'),
        decoration =
            decoration ?? (color != null ? BoxDecoration(color: color) : null),
        constraints = (height != null)
            ? constraints?.tighten(height: height) ??
            BoxConstraints.tightFor(height: height)
            : constraints,
        super(key: key);

  final BoxConstraints constraints;
  final Decoration decoration;
  final AlignmentGeometry alignment;
  final EdgeInsets padding;
  final Decoration foregroundDecoration;
  final EdgeInsets margin;
  final Matrix4 transform;
  final Widget child;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      alignment: alignment,
      constraints: constraints,
      decoration: decoration,
      padding: padding,
      width: width,
      height: height,
      foregroundDecoration: foregroundDecoration,
      margin: margin,
      transform: transform,
    );
  }
}