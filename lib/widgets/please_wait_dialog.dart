import 'package:flutter/material.dart';
import 'package:hungry_hub/utils/constant/string_constants.dart';
import 'package:hungry_hub/widgets/sized_boxes.dart';

class PleaseWaitWidget extends StatelessWidget {
  final Widget child;
  final bool? isProgressRunning;
  final String progressText;

  const PleaseWaitWidget({
    super.key,
    required this.child,
    required this.isProgressRunning,
    this.progressText = StringConstants.pleaseWait,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: isProgressRunning == true,
          child: Container(
            color: Colors.grey.withOpacity(0.7),
            child: ProgressWidget(progressText),
          ),
        ),
      ],
    );
  }
}

class ProgressWidget extends StatelessWidget {
  final String progressText;

  const ProgressWidget(this.progressText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              gapW20,
              Text(progressText),
            ],
          ),
        ),
      ),
    );
  }
}
