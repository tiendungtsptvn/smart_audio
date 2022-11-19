import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_audio/theme/colors.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';

class GPLoadMoreDelegate extends LoadMoreDelegate {
  // the loadMore height. default is 80.0
  @override
  double widgetHeight(LoadMoreStatus status) => 50;

  @override
  Widget buildChild(LoadMoreStatus status,
      {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.chinese}) {
    if (status == LoadMoreStatus.loading) {
      return GetPlatform.isAndroid
          ? const SizedBox(
              height: 50,
              child: Center(
                child: CircularProgressIndicator(color: GPColor.workPrimary),
              ),
            )
          : const CupertinoActivityIndicator();
    }

    return const SizedBox();
  }
}
