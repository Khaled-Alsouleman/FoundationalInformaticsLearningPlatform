import 'package:foundational_learning_platform/core/utils/index.dart';
class MyCustomContainer extends StatelessWidget {
  final double width;
  final double height;
  final AlignmentGeometry? alignment;
  final Widget child;
  const MyCustomContainer({super.key, required this.child, required this.width, required this.height, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: alignment ?? alignment ,
      decoration:  BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: const [
                BoxShadow(
                    color: Colors.white10,
                    blurRadius: 8,
                    offset: Offset(-4, -4)
                ),
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(4, 4)
                ),
        ]
      ),
      child: child,
    );
  }
}
