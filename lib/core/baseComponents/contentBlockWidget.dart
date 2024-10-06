import 'package:foundational_learning_platform/core/utils/index.dart';

class ContentBlockWidget extends StatelessWidget {
  final Widget widget;
  final Color?  backgroundColor;
  final double screenHeight;
  const ContentBlockWidget({
    super.key,
    required this.widget,
    required this.screenHeight, this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor??Colors.white60,
      ),
      child: widget,
    );
  }
}
