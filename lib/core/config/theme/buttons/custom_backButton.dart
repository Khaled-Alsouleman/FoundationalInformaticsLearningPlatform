import 'package:foundational_learning_platform/core/utils/index.dart';

class CustomBackButton extends StatelessWidget {

  final void Function() onPressed;
  const CustomBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => HoverBloc(),
      child: BlocBuilder<HoverBloc, HoverState>(
        builder: (context, state) {
          final isHovered = state is OnHover;

          return InkWell(
            onTap: onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              height: 40,
              width:  40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isHovered ? colorsTheme.white : colorsTheme.primaryColor,
                borderRadius:  AppDimensions.borderRadiusAll,
                border:  Border.all(color:  colorsTheme.primaryColor, width: 1),
                boxShadow:  [
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
                ],
              ),
              child:Icon(Icons.arrow_back_outlined, color: isHovered ? colorsTheme.primaryColor : colorsTheme.white,),
            ).onHoverEvent(context),
          );


        },
      ),
    );
  }
}
