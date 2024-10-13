import 'package:foundational_learning_platform/core/utils/index.dart';

class RoundedShadowContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final Color? color;
  final AlignmentGeometry? alignment;
  final Gradient? gradient;
  final bool useAnimation;
  final bool useGradient;

  const RoundedShadowContainer({
    super.key,
    this.height,
    this.width,
    required this.child,
    this.alignment,
    this.color,
    this.gradient,
    this.useAnimation = false,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;

    return BlocProvider(
      create: (context) => HoverBloc(),
      child: BlocBuilder<HoverBloc, HoverState>(
        builder: (context, state) {
          final bool isHovering = state is OnHover;


          final containerColor = isHovering
              ? colorsTheme.primaryColor
              : color ?? colorsTheme.white;

          return useAnimation
              ? Animate(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: height ?? 500,
                    width: width ?? 750,
                    alignment: alignment ?? Alignment.center,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: AppDimensions.borderRadiusAll,
                      boxShadow: [
                        BoxShadow(
                          color: colorsTheme.inactiveColor.withOpacity(0.5),
                          blurRadius: 4,
                          blurStyle: BlurStyle.normal,
                          offset: const Offset(0, 5),
                        ),
                        BoxShadow(
                          color: colorsTheme
                              .copyWith(
                                  backgroundColor: const Color(0XFF9EB8D9))
                              .backgroundColor,
                          blurRadius: 4,
                          blurStyle: BlurStyle.normal,
                          offset: const Offset(-5, 0),
                        ),
                      ],
                      gradient: useGradient
                          ? gradient ??
                              FlutterGradients.februaryInk(
                                type: GradientType.linear,
                                center: Alignment.bottomRight,
                                radius: 5,
                              )
                          : null,
                    ),
                    child: child,
                  ),
                ).animate().fadeIn()
              : Container(
                  height: height ?? 500,
                  width: width ?? 750,
                  alignment: alignment ?? Alignment.center,
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: AppDimensions.borderRadiusAll,
                    boxShadow: [
                      BoxShadow(
                        color: colorsTheme.inactiveColor.withOpacity(0.5),
                        blurRadius: 4,
                        blurStyle: BlurStyle.normal,
                        offset: const Offset(0, 5),
                      ),
                      BoxShadow(
                        color: colorsTheme
                            .copyWith(backgroundColor: const Color(0XFF9EB8D9))
                            .backgroundColor,
                        blurRadius: 4,
                        blurStyle: BlurStyle.normal,
                        offset: const Offset(-5, 0),
                      ),
                    ],
                    gradient: useGradient
                        ? gradient ??
                            FlutterGradients.februaryInk(
                              type: GradientType.linear,
                              center: Alignment.bottomRight,
                              radius: 5,
                            )
                        : null,
                  ),
                  child: child,
                );
        },
      ),
    );
  }
}
