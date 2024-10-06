import 'package:foundational_learning_platform/core/utils/index.dart';

class TranslateOnHover extends StatelessWidget {
  final Widget child;

   TranslateOnHover({super.key, required this.child});

  final defaultTranslate = Matrix4.identity();

  final onHoverTranslate = Matrix4.identity()
    ..translate(0, -5, 0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HoverBloc, HoverState>(
      builder: (context, state) {
        // TODO: implement listener
        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          transform: state is OnHover ? onHoverTranslate : defaultTranslate ,
          child: child,
        ).onHoverEvent(context);
      },

    );
  }
}
