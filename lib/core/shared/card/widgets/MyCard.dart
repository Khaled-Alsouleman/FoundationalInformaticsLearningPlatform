import 'package:foundational_learning_platform/core/utils/index.dart';

class MyCard extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final Color? backgroundColor;
  final Color? defaultBorderColor;
  final double? fontSize;
  final BoxBorder? containerBorder;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  final Curve? curve;
  final bool useAnimation;
  final bool useShadow;
  final BorderRadiusGeometry? borderRadius;
  final bool? isActive;

  const MyCard({
    super.key,
    this.width,
    this.height,
    required this.title,
    this.fontWeight,
    this.fontColor,
    this.backgroundColor,
    this.defaultBorderColor,
    this.fontSize,
    this.containerBorder,
    required this.onTap,
    this.textStyle,
    this.curve,
    this.useAnimation = false,
    this.useShadow = true,
    this.borderRadius,
    this.isActive = true
  });

  @override
  Widget build(BuildContext context) {
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => HoverBloc(),
      child: BlocBuilder<HoverBloc, HoverState>(
        builder: (context, state) {
          bool isHovered = state is OnHover;
          var isActiveUseAnimation = useAnimation;
          if(isActive == false) isActiveUseAnimation = false;
          final container = isActiveUseAnimation
              ? AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: curve ?? Curves.easeInOut,
            height: height,
            width: width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isHovered ? colorsTheme.white : colorsTheme.primaryColor,
              borderRadius: borderRadius ?? AppDimensions.borderRadiusAll,
              border: containerBorder ?? Border.all(color: defaultBorderColor ?? colorsTheme.primaryColor, width: 1),
              boxShadow: useShadow ? [
                BoxShadow(
                  color: colorsTheme.inactiveColor.withOpacity(0.5),
                  blurRadius: 4,
                  blurStyle: BlurStyle.normal,
                  offset: const Offset(0, 5),
                ),
                BoxShadow(
                  color: colorsTheme.copyWith(backgroundColor: const Color(0XFF9EB8D9)).backgroundColor,
                  blurRadius: 4,
                  blurStyle: BlurStyle.normal,
                  offset: const Offset(-5, 0),
                ),
              ] : [],
            ),
            child: Text(
              title,
              style: textStyle ?? textTheme.labelLarge!.copyWith(
                color: isHovered ? colorsTheme.primaryColor : colorsTheme.white,
              ),
            ),
          )
              : Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isActive! ? colorsTheme.primaryColor : colorsTheme.primaryColor.withOpacity(0.1),
              borderRadius:  borderRadius ?? AppDimensions.borderRadiusAll,
              border: containerBorder ?? Border.all(color: isActive! ? defaultBorderColor ??  colorsTheme.primaryColor : colorsTheme.primaryColor.withOpacity(0.5) , width: 1),
              boxShadow: useShadow ? [
                BoxShadow(
                  color: colorsTheme.inactiveColor.withOpacity(0.5),
                  blurRadius: 4,
                  blurStyle: BlurStyle.normal,
                  offset: const Offset(0, 5),
                ),
                BoxShadow(
                  color: colorsTheme.copyWith(backgroundColor: const Color(0XFF9EB8D9)).backgroundColor,
                  blurRadius: 4,
                  blurStyle: BlurStyle.normal,
                  offset: const Offset(-5, 0),
                ),
              ] : [],
            ),
            child: Text(
              title,
              style: textStyle ?? textTheme.labelLarge!.copyWith(
                color: isActive! ? colorsTheme.white : colorsTheme.white.withOpacity(0.5) ,
              ),
            ),
          );

          return GestureDetector(
            onTap: isActive! ? onTap : (){} ,
            child: isActive! ? container.onHoverEvent(context).showCursorOnHover: container,
          );
        },
      ),
    );
  }
}
