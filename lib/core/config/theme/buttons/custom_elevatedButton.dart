import 'package:foundational_learning_platform/core/utils/index.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final BorderRadius? borderRadius;
  final bool? isActive;

  const CustomButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.borderRadius,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => HoverBloc(),
      child: BlocBuilder<HoverBloc, HoverState>(
        builder: (context, state) {
          final isHovered = state is HoverInitial;
          final backgroundColor = isHovered
              ? colorsTheme.primaryColor
              : colorsTheme.white;
          final textColor = isHovered
              ? colorsTheme.white
              : colorsTheme.primaryColor;

          return ElevatedButton(
            onPressed: isActive! ? onPressed : (){},
            style: ElevatedButton.styleFrom(
              backgroundColor: isActive! ? backgroundColor : colorsTheme.primaryColor.withOpacity(0.3),
              minimumSize: const Size(200, 50),
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? AppDimensions.borderRadiusAll,
                side: BorderSide(
                  width: 1.5,
                  color: isHovered
                      ? colorsTheme.transparent
                      : colorsTheme.primaryColor,
                ),
              ),
            ),
            child: DefaultTextStyle.merge(
              style: textTheme.labelMedium!.copyWith(color: textColor),
              child: child,
            ),
          ).onHoverEvent(context);
        },
      ),
    );
  }
}
