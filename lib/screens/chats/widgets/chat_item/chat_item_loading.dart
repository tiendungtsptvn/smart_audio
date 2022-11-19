import 'package:flutter/cupertino.dart';

import '../../../../base/widgets/animated_shimmer.dart';

class ChatItemLoading extends StatelessWidget{
  const ChatItemLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //avatar
          const AnimatedShimmer(width: 64, height: 64, radius: 100),
          //content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AnimatedShimmer(width: 150, height: 12),
                  SizedBox(
                    height: 10,
                  ),
                  AnimatedShimmer(width: 250, height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}