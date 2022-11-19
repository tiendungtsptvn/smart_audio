import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

import '../../widgets/gp_load_more_delegate.dart';

/// Base Smart Refresher for quickly init a SmartRefresher
/// SmartRefresher is a library which provided to the flutter scroll component drop-down refresh
///  and pull up load, support both android and ios.
class BaseSmartRefresher extends StatelessWidget {
  const BaseSmartRefresher({
    required this.child,
    required this.onReload,
    this.isFinish,
    this.loadMoreDelegate,
    this.onLoadMore,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Future<dynamic> Function() onReload;
  final Future<dynamic>? Function()? onLoadMore;
  final bool? isFinish;
  final LoadMoreDelegate? loadMoreDelegate;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onReload,
      child: LoadMore(
        isFinish: isFinish ?? true,
        onLoadMore: () async {
          await onLoadMore?.call();
          return true;
        },
        delegate: loadMoreDelegate ?? GPLoadMoreDelegate(),
        child: child,
      ),
    );
  }
}
