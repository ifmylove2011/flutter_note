import 'package:flutter/material.dart';

class NNPopupRoute<T> extends PopupRoute<T> {
  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => Duration(seconds: 0);

  /// backgroudView Color
  final Color? backgroudViewColor;

  /// child'alignment, default value: [Alignment.center]
  final Alignment alignment;

  /// child
  final Widget child;

  /// backgroudView action
  final Function onClick;

  NNPopupRoute(
      {this.backgroudViewColor,
      this.alignment = Alignment.center,
      required this.onClick,
      required this.child});

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final screenSize = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        child: Stack(
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height,
              color: backgroudViewColor ?? Colors.black.withOpacity(0.3),
            ),
            SafeArea(
              child: Align(
                alignment: alignment,
                child: child,
              ),
            ),
          ],
        ),
        onTap: () {
          onClick();
        },
      ),
    );
  }
}

class NNAlertDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;

  final double marginHor;
  final List<Widget>? actions;
  final Widget? actionCancell;
  final Widget? actionConfirm;

  const NNAlertDialog({
    Key? key,
    this.title,
    this.content,
    this.marginHor = 15,
    this.actions,
    this.actionCancell,
    this.actionConfirm,
  })  : assert((title != null || content != null)),
        assert(marginHor >= 0),
        assert((actions != null ||
            actionCancell != null ||
            actionConfirm != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double spacingVer = 8;
    double spacingHor = 15;

    return Container(
      width: screenSize.width - marginHor * 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular((10.0)), // 圆角度
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Padding(
              padding: EdgeInsets.only(
                  top: spacingVer,
                  left: spacingHor,
                  bottom: spacingVer,
                  right: spacingHor),
              child: title,
            ),
          if (title != null)
            Padding(
              padding: EdgeInsets.only(
                  left: spacingHor, bottom: spacingVer, right: spacingHor),
              child: content,
            ),
          Container(
            height: 0.5,
            color: Colors.grey[400],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: actions != null
                ? actions!
                    .map(
                      (e) => Expanded(
                        child: e,
                      ),
                    )
                    .toList()
                : [
                    if (actionCancell != null)
                      Expanded(
                        child: actionCancell!,
                      ),
                    Container(
                        height: 55,
                        child: VerticalDivider(color: Colors.grey[400])),
                    if (actionConfirm != null)
                      Expanded(
                        child: actionConfirm!,
                      ),
                  ],
          ),
        ],
      ),
    );
  }
}

class PopupFreeWindow extends PopupRoute {
  final Widget child;

  final Duration duration;
  final EdgeInsets margin;
  final Alignment alignment;
  Color? outerBackgroudColor;

  double widthFactor;
  double heightFactor;

  PopupFreeWindow(
      {required this.child,
      this.duration = const Duration(milliseconds: 300),
      this.alignment = Alignment.bottomCenter,
      this.margin =
          const EdgeInsets.only(bottom: kBottomNavigationBarHeight * 1.5),
      this.widthFactor = 0.95,
      this.heightFactor = 0.3});

  @override
  Color? get barrierColor =>
      outerBackgroudColor ?? Colors.black.withOpacity(0.3);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return SafeArea(
        child: FractionallySizedBox(
            widthFactor: widthFactor,
            heightFactor: heightFactor,
            child: Container(
              child: child,
              margin: margin,
            ),
            alignment: alignment));
  }

  @override
  Duration get transitionDuration => duration;
}
