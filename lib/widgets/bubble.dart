import 'dart:math';

import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final ArrowDirection direction;
  final Widget child;
  EdgeInsets? padding;
  final Radius borderRadius;

  final Color backgroundColor;

  double arrowWidth;
  double weight;
  double arrowBasisOffset;
  double arrowPeakOffset;
  double ratioHW;
  double conicWeight;

  ChatBubble(
      {Key? key,
      required this.direction,
      this.borderRadius = const Radius.circular(15.0),
      this.backgroundColor = Colors.transparent,
      this.padding = const EdgeInsets.all(10.0),
      required this.child,
      this.arrowWidth = 0,
      this.weight = 0.2,
      this.ratioHW = 1,
      this.arrowBasisOffset = 0,
      this.arrowPeakOffset = 0,
      this.conicWeight = 20.0})
      : assert(weight < 1 && weight > 0),
        assert(ratioHW > 0),
        super(key: key);

  _padding(ArrowDirection direction, double height) {
    switch (direction) {
      case ArrowDirection.bottom:
        return EdgeInsets.only(bottom: height).add(padding!);
      case ArrowDirection.left:
        return EdgeInsets.only(left: height).add(padding!);
      case ArrowDirection.right:
        return EdgeInsets.only(right: height).add(padding!);
      case ArrowDirection.top:
        return EdgeInsets.only(top: height).add(padding!);
      case ArrowDirection.none:
        return padding;
    }
  }

  @override
  Widget build(BuildContext context) {
    //提前算出padding，避免三角形切割到child
    padding = _padding(direction, arrowWidth * ratioHW);

    return Container(
      color: Colors.transparent,
      child: ClipPath(
        clipper: _ChatBubbleClipper(
          direction: direction,
          arrowWidth: arrowWidth,
          weight: weight,
          radius: borderRadius,
          ratio: ratioHW,
          arrowBasisOffset: arrowBasisOffset,
          arrowPeakOffset: arrowPeakOffset,
          conicWeight: conicWeight,
        ),
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
  ///三角形箭头的方向
  final ArrowDirection direction;

  ///矩形圆角半径
  final Radius radius;

  ///三角形的宽，即与矩形相邻的底边长度
  final double arrowWidth;

  ///三角形的宽与空间窄边长度的比例，如果指定了[arrowWidth]则无效
  final double weight;

  ///三角形底边中心点相对矩形邻边中心点的偏移量，值为[-1,1]时为比例偏移(以矩形邻边长度为基准)，否则为真实偏移；
  ///如0.5代表三角形底边中心位于邻边中心，箭头则位于矩形某一边的中部
  final double arrowBasisOffset;

  ///三角形顶角顶点相对于三角形底边中心点的偏移量，为比例偏移(以底边长度为基准);
  ///如为0时则为等腰三角形，即中线与底边垂直，为0.5或-0.5时为直角三角形，否则为普通斜三角
  final double arrowPeakOffset;

  ///三角形高：宽比
  final double ratio;

  ///圆锥曲线权重，权重越小，箭头越扁越平滑些，越大越尖锐更接近三角形
  final double conicWeight;

  _ChatBubbleClipper(
      {required this.direction,
      required this.radius,
      this.arrowWidth = 0,
      this.weight = 0.2,
      required this.ratio,
      required this.arrowBasisOffset,
      required this.arrowPeakOffset,
      required this.conicWeight});

  @override
  Path getClip(Size size) {
    print("w=${size.width},h=${size.height}");

    final pathTriangle = Path();
    final pathRect = Path();

    //三角形宽高以空间窄边为基准，避免空间矩形长宽比例较大时难以赋值
    final arrowW =
        arrowWidth == 0 ? min(size.height, size.width) * weight : arrowWidth;
    final arrowH = arrowW * ratio;

    print("arrowW=$arrowW,arrowH=$arrowH");

    //箭头为水平方向（左右）时，三角形底边中心的纵坐标
    final basisPointY = arrowBasisOffset < -1 || arrowBasisOffset > 1
        ? size.height / 2 + arrowBasisOffset
        : size.height / 2 * (1 + arrowBasisOffset);
    //箭头为水平方向（左右）时，三角形顶角顶点的纵坐标
    final peakPointY = basisPointY + arrowW * arrowPeakOffset;

    print("b=$arrowBasisOffset,p=$arrowPeakOffset");
    //箭头为垂直方向（上下）时，三角形底边中心的横坐标
    final basisPointX = arrowBasisOffset < -1 || arrowBasisOffset > 1
        ? size.width / 2 + arrowBasisOffset
        : size.width / 2 * (1 + arrowBasisOffset);
    //箭头为垂直方向（上下）时，三角形顶角顶点的横坐标
    final peakPointX = basisPointX + arrowW * arrowPeakOffset;
    print("peakX=$peakPointX,basisX=$basisPointX");

    switch (direction) {
      case ArrowDirection.left:
        //绘制位于左边的三角形箭头，即画一个顶角朝左的三角形
        drawArrow(pathTriangle, arrowH, basisPointY + arrowW / 2, 0, peakPointY,
            arrowH, basisPointY - arrowW / 2, conicWeight);
        //绘制位于右方的矩形
        pathRect.addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(arrowH, 0, (size.width - arrowH), size.height),
            radius));
        break;
      case ArrowDirection.right:
        //绘制位于右边的三角形箭头，画一个顶角朝右的三角形
        drawArrow(
            pathTriangle,
            size.width - arrowH,
            basisPointY - arrowW / 2,
            size.width,
            peakPointY,
            size.width - arrowH,
            basisPointY + arrowW / 2,
            conicWeight);
        //绘制位于左边的矩形
        pathRect.addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, (size.width - arrowH), size.height), radius));
        break;
      case ArrowDirection.top:
        //绘制位于顶部的三角形箭头，画一个顶角朝上的三角形
        drawArrow(pathTriangle, basisPointX - arrowW / 2, arrowH, peakPointX, 0,
            basisPointX + arrowW / 2, arrowH, conicWeight);
        //绘制位于下边的矩形
        pathRect.addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(0, arrowH, size.width, size.height - arrowH),
            radius));
        break;
      case ArrowDirection.bottom:
        //绘制位于底部的三角形箭头，画一个顶角朝下的三角形
        drawArrow(
            pathTriangle,
            basisPointX + arrowW / 2,
            size.height - arrowH,
            peakPointX,
            size.height,
            basisPointX - arrowW / 2,
            size.height - arrowH,
            conicWeight);
        // 绘制位于下边的矩形
        pathRect.addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height - arrowH), radius));
        break;
      default:
        pathRect.addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height), radius));
        break;
    }
    //合并
    pathTriangle.addPath(pathRect, const Offset(0, 0));
    return pathTriangle;
  }

  ///根据三点坐标与权重画圆锥三角形
  drawArrow(Path pathTriangle, double startX, double startY, double peakX,
      double peakY, double endX, double endY, double weight) {
    pathTriangle.moveTo(startX, startY);
    pathTriangle.conicTo(peakX, peakY, endX, endY, weight);
    pathTriangle.close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
