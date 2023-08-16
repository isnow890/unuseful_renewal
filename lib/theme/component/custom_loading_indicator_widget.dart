import 'package:flutter/material.dart';

import 'custom_circular_progress_indicator.dart';

class CustomLoadingIndicatorWidget extends StatelessWidget {
  const CustomLoadingIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: CustomCircularProgressIndicator(),
        ),
      ],
    );
  }
}
