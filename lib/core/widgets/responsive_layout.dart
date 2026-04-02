import 'package:flutter/material.dart';

/// Breakpoints for responsive layout decisions.
class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1000;

  /// Max width for reading content (text, cards, quiz).
  static const double maxContentWidth = 800;

  /// Max width for interactive tools (wider widgets).
  static const double maxToolWidth = 1000;

  /// Returns true if the viewport is mobile-sized.
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobile;

  /// Returns true if the viewport is tablet-sized.
  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= mobile && w < tablet;
  }

  /// Returns true if the viewport is desktop-sized.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tablet;

  /// Returns true if the viewport is wide enough for a 2-column module grid.
  static bool useWideGrid(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= desktop;
}

/// Centers its child within a max-width constraint.
///
/// On mobile (<600px) the child fills the full width.
/// On wider viewports the child is constrained to [maxWidth] and centered.
///
/// The background color of the parent extends full-width; only the content
/// is constrained.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = ResponsiveBreakpoints.maxContentWidth,
    this.padding,
  });

  /// The content to constrain and center.
  final Widget child;

  /// Maximum width of the content area.
  final double maxWidth;

  /// Optional padding applied inside the constraint.
  /// If null, no extra padding is added.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    Widget content = child;
    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: content,
      ),
    );
  }
}

/// A sliver variant of [ResponsiveCenter] for use inside [CustomScrollView].
///
/// Wraps a [SliverToBoxAdapter] child in centered, width-constrained layout.
class SliverResponsiveCenter extends StatelessWidget {
  const SliverResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = ResponsiveBreakpoints.maxContentWidth,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}

/// Wraps a [Scaffold] body to center its content on desktop.
///
/// Use this to wrap the body of any Scaffold-based screen that should
/// have centered content on wide viewports.
class ResponsiveBody extends StatelessWidget {
  const ResponsiveBody({
    super.key,
    required this.child,
    this.maxWidth = ResponsiveBreakpoints.maxContentWidth,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
