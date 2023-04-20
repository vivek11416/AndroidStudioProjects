import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ShowWaitingDialog extends StatelessWidget {
  const ShowWaitingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
      child: Container(
        child: Center(
          child: LoadingAnimationWidget.halfTriangleDot(
              color: Theme.of(context).secondaryHeaderColor, size: 80),
        ),
        decoration:
            new BoxDecoration(color: Colors.grey.shade200.withOpacity(0.2)),
      ),
    );
  }
}
