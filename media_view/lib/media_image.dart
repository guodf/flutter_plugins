import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MediaImage extends StatefulWidget {
  final Color backgroundColor;
  final Widget child;
  
  MediaImage(
      {Key key,this.child, this.backgroundColor = Colors.black})
      : super(key: key);

  @override
  _MediaImageState createState() => _MediaImageState();
}

class _MediaImageState extends State<MediaImage> with TickerProviderStateMixin {
  var _scale = 1.0;
  var _tmpScale = 1.0;
  var _point = Offset.zero;
  var _tmpPoint = Offset.zero;
  var _firstPoint = Offset.zero;
  var _rotation = 0.0;
  var _tmpRotation = 0.0;
  AnimationController _rotationController;
  AnimationController _resetScaleController;
  CurvedAnimation _rotationAnmimation;
  Animation _rotationTween;
  Animation _resetScaleTween;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {
          _rotation = _tmpRotation = _rotationTween.value;
        });
      });
    _resetScaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {
              print([_tmpPoint, _point, _tmpScale]);
              _scale = (_tmpScale - 1) * _resetScaleTween.value + 1;
              _point = _tmpPoint * _resetScaleTween.value;
            });
          });
    _rotationAnmimation = CurvedAnimation(
        parent: _rotationController, curve: Curves.easeInOutSine);
  }

  void _scaleAnimation() {
    if (!_resetScaleController.isAnimating) {
      _tmpPoint = _point;
      _tmpRotation = _tmpRotation;
      _tmpScale = _scale;
      _resetScaleController
        ..reset()
        ..forward();
    }
  }

  void _rotationAnimation() {
    if (!_rotationController.isAnimating) {
      _rotationController
        ..reset()
        ..forward();
    }
  }

  void _onScaleStart(ScaleStartDetails details) {
    _tmpPoint = _point;
    _firstPoint = details.focalPoint;
    _tmpScale = _scale;
    _tmpRotation = _rotation % (2 * pi);
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {

      _scale = _tmpScale * details.scale;
      _point = _tmpPoint + (details.focalPoint - _firstPoint) / _scale;
      _rotation = _tmpRotation + details.rotation;
    });
  }

  void _onScaleEnd(details) {
    var rotationAngle = _rotation % (2 * pi);
    var overAngle = ((_rotation % (2 * pi)) % (pi / 2));
    var rotationBack = overAngle > (pi / 4) ? (overAngle - pi / 2) : overAngle;
    var from = rotationAngle;
    var to = rotationAngle - rotationBack;
    _rotationTween =
        Tween<double>(begin: from, end: to).animate(_rotationAnmimation);
    _rotationAnimation();
  }

  void _onDoubleTap() {
    _resetScaleTween =
        Tween<double>(begin: 1.0, end: 0.0).animate(_resetScaleController);
    _scaleAnimation();
  }

  @override
  Widget build(BuildContext context) {
    Matrix4 matrix4 = Matrix4.identity()
      ..scale(_scale, _scale)
      ..translate(_point.dx, _point.dy)
      ..rotateZ(_rotation);
    return GestureDetector(
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        onScaleEnd: _onScaleEnd,
        onDoubleTap: _onDoubleTap,
        child: Container(
          alignment: Alignment.center,
          color: widget.backgroundColor,
          child: Transform(
              alignment: FractionalOffset.center,
              child: widget.child,
              transform: matrix4),
        ));
  }
}
