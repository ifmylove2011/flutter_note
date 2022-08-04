import 'dart:math';

import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final ArrowDirection direction;
  final Widget child;
  final EdgeInsets? padding;
  final Radius? borderRadius;

  final Color? backgroundColor;

  const ChatBubble({
    Key? key,
    required this.direction,
    this.borderRadius,
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.all(15.0),
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ClipPath(
        clipper: _ChatBubbleClipper(direction: direction),
        child: Container(
          color: backgroundColor,
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

///方向
enum ArrowDirection { left, right, top, bottom, none }

///路径剪切，用于三角形箭头和矩形拼接，这里三角形均为等腰三角，以顶角所在的点为路径起始点
class _ChatBubbleClipper extends CustomClipper<Path> {
  //三角形箭头的方向
  final ArrowDirection direction;
  //矩形圆角半径
  final Radius radius;
  //三角形的宽与空间窄边长度的比例
  final double weight;
  //三角形与矩形邻边端点（左、上）的偏移量，大于1或小于0时为真实偏移，否则为比例偏移
  final double offset;
  //三角形宽高比
  final double ratio;

  const _ChatBubbleClipper(
      {required this.direction,
      this.radius = const Radius.circular(15.0),
      this.weight = 0.1,
      this.ratio = 1,
      this.offset = 0.5});

  @override
  Path getClip(Size size) {
    print("w=${size.width},h=${size.height}");

    final pathTriangle = Path();
    final pathRect = Path();

    //垂直方向时的基点，可得出路径起始点为(0,basisPointV)
    final basisPointVer = (size.height / 2);
    //水平方向时的基点，可得出路径起始点为(basisPointH,0)
    final basisPointHor = (size.width / 2);
    print("basisPointH=$basisPointHor,basisPointV=$basisPointVer");

    //三角形宽高以空间窄边为基准，避免空间矩形长宽比例较大时难以赋值
    final arrowWidth = min(size.height, size.width) * weight;
    final arrowHeight = arrowWidth * ratio;

    switch (direction) {
      case ArrowDirection.left:
        //绘制位于左边的三角形箭头，画一个中线为水平方向，顶角朝左的等腰三角形
        pathTriangle.moveTo(0, basisPointVer);
        pathTriangle.lineTo(arrowHeight, basisPointVer - arrowWidth / 2);
        pathTriangle.lineTo(arrowHeight, basisPointVer + arrowWidth / 2);
        pathTriangle.close();
        //绘制位于右方的矩形
        pathRect.addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(
                arrowHeight, 0, (size.width - arrowHeight), size.height),
            radius));
        break;
      case ArrowDirection.right:
        //绘制位于右边的三角形箭头，画一个中线为水平方向，顶角朝右的等腰三角形
        pathTriangle.moveTo(size.width, basisPointVer);
        pathTriangle.lineTo(
            size.width - arrowHeight, basisPointVer - arrowWidth / 2);
        pathTriangle.lineTo(
            size.width - arrowHeight, basisPointVer + arrowWidth / 2);
        pathTriangle.close();
        //绘制位于左边的矩形
        pathRect.addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, (size.width - arrowHeight), size.height),
            radius));
        break;
      case ArrowDirection.top:
        //绘制位于顶部的三角形箭头，画一个中线为垂直方向，顶角朝上的等腰三角形
        pathTriangle.moveTo(basisPointHor, 0);
        pathTriangle.lineTo(basisPointHor + arrowWidth / 2, arrowHeight);
        pathTriangle.lineTo(basisPointHor - arrowWidth / 2, arrowHeight);
        pathTriangle.close();
        //绘制位于下边的矩形
        pathRect.addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(0, arrowHeight, size.width, size.height), radius));
        break;
      case ArrowDirection.bottom:
        //绘制位于底部的三角形箭头，画一个中线为垂直方向，顶角朝下的等腰三角形
        pathTriangle.moveTo(basisPointHor, size.height);
        pathTriangle.lineTo(
            basisPointHor - arrowWidth / 2, size.height - arrowHeight);
        pathTriangle.lineTo(
            basisPointHor + arrowWidth / 2, size.height - arrowHeight);
        pathTriangle.close();
        // 绘制位于下边的矩形
        pathRect.addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height - arrowHeight),
            radius));
        break;
      default:
    }
    //TODO 贝塞尔曲线尝试一下
    //合并
    pathTriangle.addPath(pathRect, const Offset(0, 0));
    return pathTriangle;
  }

  drawTriangleAndRect(Path pathTriangle, Path pathRect) {}

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
