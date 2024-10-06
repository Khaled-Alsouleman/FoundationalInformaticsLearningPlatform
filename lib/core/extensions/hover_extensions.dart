import 'dart:html' as html;
import 'package:foundational_learning_platform/core/utils/index.dart';

extension HoverExtensions on Widget {
  static final appContainer = html.window.document.getElementById('app-container');


  Widget get showCursorOnHover {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: this,
    );
  }


  Widget get upMovingEffect {
    return TranslateOnHover(child: this);
  }

  Widget onHoverEvent(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => context.read<HoverBloc>().add(OnHoverEnter()),
      onExit: (_) => context.read<HoverBloc>().add(OnHoverExit()),
      child: this,
    );
  }


  Widget textSizeIncreaseOnHover(BuildContext context, double baseFontSize) {
    return BlocBuilder<HoverBloc, HoverState>(
      builder: (context, state) {
        final isHovering = state is OnHover;
        final fontSize = isHovering ? baseFontSize + 2 : baseFontSize;

        if (this is Text) {
          final textWidget = this as Text;
          return AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 100),
            style: textWidget.style?.copyWith(fontSize: fontSize) ?? TextStyle(fontSize: fontSize),
            child: Text(textWidget.data ?? ''),
          );
        }

        return this;
      },
    );
  }



  Widget increaseSizeOnHover(BuildContext context, double currentWidth, double currentHeight) {
    return BlocBuilder<HoverBloc, HoverState>(
      builder: (context, state) {
        final isHovering = state is OnHover;
        final double width = isHovering ? currentWidth + 4 : currentWidth;
        final double height = isHovering ? currentHeight + 4 : currentHeight;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: width,
          height: height,
          child: this, // The widget that is wrapped
        );
      },
    );
  }
}
