import 'package:foundational_learning_platform/core/utils/index.dart';

class MyTypeWriter extends StatelessWidget {
  final String input;
  final TextStyle? textStyle;
  final int? forwardAnimationSpeed;
  final TextAlign? textAlign;
  const MyTypeWriter({super.key, required this.input, this.textStyle, this.forwardAnimationSpeed, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return TypewriteText(
      linesOfText: [input],
      textAlign: textAlign?? TextAlign.start,
      forwardAnimationDuration:  Duration(milliseconds: forwardAnimationSpeed ?? 20),
      reverseAnimationDuration: const Duration(minutes: 30),
      textStyle: textStyle?? const TextStyle(color: Colors.black, fontSize: 18),
      cursorSymbol: '|',
    );
  }
}
