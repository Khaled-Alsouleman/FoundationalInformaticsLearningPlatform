import 'package:foundational_learning_platform/core/utils/index.dart';

class SingleExpansionPanel extends StatelessWidget {
  final int index;
  final String title;
  final bool isExpanded;
  final Widget child;
  final Function(int index, bool isExpanded) onExpansionChanged;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;

  const SingleExpansionPanel({
    Key? key,
    required this.index,
    required this.title,
    required this.isExpanded,
    required this.child,
    required this.onExpansionChanged,
    this.borderRadius,
    this.borderSide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<AppColorsTheme>();
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      decoration: BoxDecoration(
        color: colorTheme!.white,
        borderRadius: borderRadius ?? AppDimensions.borderRadiusAll,
        border: Border.fromBorderSide(borderSide ?? BorderSide.none),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? AppDimensions.borderRadiusAll,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                onExpansionChanged(index, isExpanded);
              },
              child: Container(
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: isExpanded ? colorTheme.primaryColor : colorTheme.white,
                    borderRadius: isExpanded
                      ? BorderRadius.only(
                    topLeft: borderRadius?.topLeft ?? const Radius.circular(15),
                    topRight: borderRadius?.topRight ?? const Radius.circular(15),
                  )
                      : borderRadius ?? AppDimensions.borderRadiusAll,
                ),
                padding: const EdgeInsets.all(AppDimensions.paddingSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: textTheme.labelLarge!.copyWith(
                          color: isExpanded ? colorTheme.white : colorTheme.primaryColor,
                        ),
                      ),
                    ),
                    Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: isExpanded ? colorTheme.white : colorTheme.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingSmall),
                child: child,
              ),
          ],
        ),
      ),
    );
  }
}
