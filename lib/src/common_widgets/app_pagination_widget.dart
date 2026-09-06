import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/theme/app_colors.dart';

import 'fade_circle_loading_indicator.dart';

class AppPaginationWidget extends StatefulWidget {
  const AppPaginationWidget({
    super.key,
    required this.child,
    required this.onLoading,
    this.enableLoadingOnScrollStart = false,
    this.enablePullDown = false,
    this.onRefresh,
    this.physics,
  });
  final Widget child;
  final Future<bool> Function(int page) onLoading;
  final Future<bool> Function()? onRefresh;

  final bool enableLoadingOnScrollStart;
  final bool enablePullDown;
  final ScrollPhysics? physics;

  @override
  State<AppPaginationWidget> createState() => _AppPaginationWidgetState();
}

class _AppPaginationWidgetState extends State<AppPaginationWidget> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int _page = 1;

  Future<void> _onLoading() async {
    _page++;
    if (await widget.onLoading(_page)) {
      debugPrint("loading Another Page complete: page $_page");
      _refreshController.loadComplete();
    } else {
      debugPrint("loading Another Page No DATA");

      _refreshController.loadNoData();
    }
  }

  Future<void> _onRefresh() async {
    _page = 1;
    if (widget.onRefresh != null && await widget.onRefresh!()) {
      _refreshController.refreshCompleted();
      _refreshController.resetNoData();
    } else {
      _refreshController.refreshFailed();
    }
  }
    @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
// Widget _buildPlatformHeader(BuildContext context) {
//     final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

//     if (isIOS) {
//       // Native iOS Spinner (CupertinoActivityIndicator)
//       return CustomHeader(
//         refreshStyle: RefreshStyle.Follow,
//         builder: (context, mode) {
//           return const SizedBox(
//             height: 55.0,
//             child: Center(
//               child: CupertinoActivityIndicator(radius: 12),
//             ),
//           );
//         },
//       );
//     } else {
//       // Native Android Floating Material Indicator
//       return MaterialClassicHeader(
//         color: Theme.of(context).colorScheme.secondary,
//         backgroundColor: Colors.white,
//       );
//     }
//   }
  Widget _buildPlatformHeader(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      // Floating Android-style bubble on iOS containing the Native Cupertino Spinner
      return ClassicHeader(
        refreshStyle: RefreshStyle.Front, // Floats on top, prevents list bouncing
        idleText: '',
        releaseText: '',
        refreshingText: '',
        completeText: '',
        failedText: '',
        spacing: 0,
        completeIcon: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: const CupertinoActivityIndicator(radius: 11),
        ),
        failedIcon: null,
        releaseIcon: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: const CupertinoActivityIndicator(radius: 11),
        ),
        idleIcon: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: const CupertinoActivityIndicator(radius: 11),
        ),
        refreshingIcon: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: const CupertinoActivityIndicator(radius: 11),
        ),
      );
    } else {
      // Native Android Floating Material Indicator
      return MaterialClassicHeader(
        color: AppColors.primary,
        backgroundColor: Colors.white,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollStartNotification>(
      onNotification: widget.enableLoadingOnScrollStart
          ? (notification) {
              if (notification.metrics.axisDirection == AxisDirection.down) {
                _onLoading();
                return true;
              }
              return false;
            }
          : null,
      child: SmartRefresher(
        physics: widget.physics ?? const ClampingScrollPhysics(),
        enablePullDown: widget.enablePullDown,
        enablePullUp: true,
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            if (mode == LoadStatus.loading) {
              return const SizedBox(
                height: 55,
                child: Center(
                  child: FadeCircleLoadingIndicator(),
                ),
              );
            } else if (mode == LoadStatus.noMore) {
              return SizedBox(
                height: 55,
                child: Center(child: Text(S.of(context).no_more_data)),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        header: _buildPlatformHeader(context),
        // BezierHeader(

        //   // idleIcon: FadeCircleLoadingIndicator(),
        //   // refresh: FadeCircleLoadingIndicator(),
        //   // complete: FadeCircleLoadingIndicator(),

        //   bezierColor: Colors.white,
        //   // idleIcon: FadeCircleLoadingIndicator(),
        //   // releaseIcon: FadeCircleLoadingIndicator(),
        //   // refreshingIcon: FadeCircleLoadingIndicator(),
        //   child: FadeCircleLoadingIndicator(),
        //   // color: Theme.of(context).colorScheme.secondary,
        //   // backgroundColor: Colors.white,
        // ),
        controller: _refreshController,
        onLoading: widget.enableLoadingOnScrollStart ? null : _onLoading,
        onRefresh: widget.enablePullDown ? _onRefresh : null,
        primary: false,
        child: widget.child,
      ),
    );
  }
}
