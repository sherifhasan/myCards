import 'package:flutter/material.dart';
import 'dart:async';

class AwesomeTopSnackBar extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final TextStyle textStyle;
  final VoidCallback? onCloseClick;
  final Icon? icon;
  final BoxDecoration? iconWithDecoration;
  final bool isExpanded;

  const AwesomeTopSnackBar({
    Key? key,
    required this.message,
    this.onCloseClick,
    this.isExpanded = false,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.white,
    ),
    this.icon,
    this.iconWithDecoration,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  AwesomeTopSnackBarState createState() => AwesomeTopSnackBarState();
}

class AwesomeTopSnackBarState extends State<AwesomeTopSnackBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
      ),
      width: widget.isExpanded ? MediaQuery.of(context).size.width : 320,
      child: Row(
        children: [
          Visibility(
            visible: widget.icon == null ? false : true,
            child: GestureDetector(
              onTap: widget.onCloseClick,
              child: Container(
                height: 24,
                width: 24,
                margin: const EdgeInsets.all(10),
                decoration: widget.iconWithDecoration,
                child: widget.icon,
              ),
            ),
          ),
          widget.isExpanded
              ? Expanded(
                  child: Text(widget.message,
                      style:
                          theme.textTheme.bodyMedium?.merge(widget.textStyle),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                )
              : Text(widget.message,
                  style: theme.textTheme.bodyMedium?.merge(widget.textStyle),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2),
        ],
      ),
    );
  }
}

typedef ControllerCallback = void Function(AnimationController);

enum DismissType { onSwipe, none }

OverlayEntry? _previousEntry;

void mySnackBar(
  OverlayState overlayState,
  Widget child, {
  Duration animationDuration = const Duration(milliseconds: 1200),
  Duration reverseAnimationDuration = const Duration(milliseconds: 550),
  Duration displayDuration = const Duration(milliseconds: 3000),
  VoidCallback? onTap,
  bool isExpanded = false,
  bool persistent = false,
  ControllerCallback? onAnimationControllerInit,
  EdgeInsets padding = const EdgeInsets.all(16),
  Curve curve = Curves.elasticOut,
  Curve reverseCurve = Curves.linearToEaseOut,
  DismissType dismissType = DismissType.onSwipe,
  List<DismissDirection> dismissDirection = const [DismissDirection.up],
}) {
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (_) {
      return _TopSnackBar(
        onDismissed: () {
          overlayEntry.remove();
          _previousEntry = null;
        },
        isExpanded: isExpanded,
        animationDuration: animationDuration,
        reverseAnimationDuration: reverseAnimationDuration,
        displayDuration: displayDuration,
        onTap: onTap,
        persistent: persistent,
        onAnimationControllerInit: onAnimationControllerInit,
        padding: padding,
        curve: curve,
        reverseCurve: reverseCurve,
        dismissType: dismissType,
        dismissDirections: dismissDirection,
        child: child,
      );
    },
  );

  if (_previousEntry != null && _previousEntry!.mounted) {
    _previousEntry?.remove();
  }

  overlayState.insert(overlayEntry);
  _previousEntry = overlayEntry;
}

class _TopSnackBar extends StatefulWidget {
  const _TopSnackBar({
    Key? key,
    required this.child,
    required this.onDismissed,
    required this.animationDuration,
    required this.reverseAnimationDuration,
    required this.displayDuration,
    required this.padding,
    required this.curve,
    this.isExpanded = false,
    required this.reverseCurve,
    required this.dismissDirections,
    this.onTap,
    this.persistent = false,
    this.onAnimationControllerInit,
    this.dismissType = DismissType.onSwipe,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onDismissed;
  final Duration animationDuration;
  final Duration reverseAnimationDuration;
  final Duration displayDuration;
  final VoidCallback? onTap;
  final ControllerCallback? onAnimationControllerInit;
  final bool persistent;
  final bool isExpanded;
  final EdgeInsets padding;
  final Curve curve;
  final Curve reverseCurve;
  final DismissType dismissType;
  final List<DismissDirection> dismissDirections;

  @override
  _TopSnackBarState createState() => _TopSnackBarState();
}

class _TopSnackBarState extends State<_TopSnackBar>
    with SingleTickerProviderStateMixin {
  late final Animation<Offset> _offsetAnimation;
  late final AnimationController _animationController;

  Timer? _timer;

  final _offsetTween = Tween(begin: const Offset(0, -1), end: Offset.zero);

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      reverseDuration: widget.reverseAnimationDuration,
    );
    _animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed && !widget.persistent) {
          _timer = Timer(widget.displayDuration, () {
            if (mounted) {
              _animationController.reverse();
            }
          });
        }
        if (status == AnimationStatus.dismissed) {
          _timer?.cancel();
          widget.onDismissed.call();
        }
      },
    );

    widget.onAnimationControllerInit?.call(_animationController);

    _offsetAnimation = _offsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve,
      ),
    );
    if (mounted) {
      _animationController.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.padding.top,
      right: widget.padding.right,
      left: widget.isExpanded ? widget.padding.left : null,
      child: SlideTransition(
        position: _offsetAnimation,
        child: SafeArea(
          child: _buildDismissibleChild(),
        ),
      ),
    );
  }

  Widget _buildDismissibleChild() {
    switch (widget.dismissType) {
      case DismissType.onSwipe:
        var childWidget = widget.child;
        for (final direction in widget.dismissDirections) {
          childWidget = Dismissible(
            direction: direction,
            key: UniqueKey(),
            dismissThresholds: const {DismissDirection.up: 0.2},
            confirmDismiss: (direction) async {
              if (!widget.persistent && mounted) {
                if (direction == DismissDirection.down) {
                  await _animationController.reverse();
                } else {
                  _animationController.reset();
                }
              }
              return false;
            },
            child: childWidget,
          );
        }
        return childWidget;
      case DismissType.none:
        return widget.child;
    }
  }
}

void awesomeTopSnackBar(BuildContext context, String message,
    {BoxDecoration? iconWithDecoration,
    EdgeInsets? contentPadding,
    Color? backgroundColor,
    Icon? icon,
    bool isExpanded = false,
    TextStyle? textStyle}) {
  AnimationController? localAnimationController;

  mySnackBar(
    animationDuration: const Duration(milliseconds: 1000),
    reverseAnimationDuration: const Duration(milliseconds: 350),
    displayDuration: const Duration(milliseconds: 2000),
    onAnimationControllerInit: (controller) =>
        localAnimationController = controller,
    dismissType: DismissType.onSwipe,
    isExpanded: isExpanded,
    dismissDirection: [
      DismissDirection.horizontal,
      DismissDirection.vertical,
      DismissDirection.endToStart,
      DismissDirection.up,
      DismissDirection.startToEnd
    ],
    Overlay.of(context),
    AwesomeTopSnackBar(
      onCloseClick: () {
        localAnimationController?.reverse();
      },
      icon: icon,
      isExpanded: isExpanded,
      iconWithDecoration: iconWithDecoration,
      message: message,
      textStyle: textStyle ??
          Theme.of(context).textTheme.bodyMedium!.merge(const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              )),
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
    ),
  );
}
