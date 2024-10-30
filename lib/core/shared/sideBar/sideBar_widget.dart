import 'package:foundational_learning_platform/core/utils/index.dart';

import '../../../features/dfa/presentation/widges/AutomatonPainterWidget.dart';

class SideBarWidget extends StatelessWidget {
  final double? parentHeight;

  const SideBarWidget({super.key, this.parentHeight});

  @override
  Widget build(BuildContext context) {
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<SidebarBloc, SidebarState>(
      builder: (context, state) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: 0,
          bottom: 0,
          left: state is SidebarClosed ? -300 : 0,
          child: Row(
            children: [
              Container(
                width: 300,
                height: parentHeight,
                decoration: BoxDecoration(
                  color: colorsTheme
                      .primaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        context.read<ContentBloc>().add(BackToHome());
                      },
                      child: Text(
                        'Grundlagen Information',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: colorsTheme.white,
                              decoration: TextDecoration.none,
                              fontSize: 22,
                            ),
                      ).showCursorOnHover,
                    ),
                    const SizedBox(height: 15),
                    Divider(
                      color: colorsTheme.white,
                      endIndent: 18,
                      indent: 18,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildItems(
                                context: context,
                                title: "Turing-Machine",
                                content: const TMPage()
                            ),
                            _buildItems(
                                context: context,
                                title: "Endliche Automaten",
                                content: CustomPaint(
                                  size: Size(300, 300), // Beispielgröße für die Zeichenfläche
                                  painter: AutomatonPainter(), // Verwende deinen CustomPainter hier
                                ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Trigger the toggle event
                  context.read<SidebarBloc>().add(ToggleSidebar());
                },
                child: BlocProvider(
                  create: (context) => HoverBloc(),
                  child: BlocBuilder<HoverBloc, HoverState>(
                    builder: (context, hState) {
                      return BlocBuilder<SidebarBloc, SidebarState>(
                        builder: (context, sState) {
                          final isHovering = hState is OnHover;
                          final sidebarClosed = sState is SidebarClosed;

                          final width =
                              (sidebarClosed && isHovering) ? 50.0 : 25.0;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: width,
                            height: 110,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: colorsTheme.primaryColor,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                            child: Icon(
                              sState is SidebarOpened
                                  ? Icons.arrow_back_ios
                                  : Icons.arrow_forward_ios,
                              color: colorsTheme.white,
                            ),
                          ).showCursorOnHover.onHoverEvent(context);
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildItems({required BuildContext context, required String title, required Widget content}) {
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top:AppDimensions.paddingMedium),
      child: MyCard(
          height: 35,
          width: 260,
          useAnimation: true,
          useShadow: false,
          borderRadius: AppDimensions.borderRadiusAll.copyWith(
              topRight: const Radius.circular(5),
              bottomLeft: const Radius.circular(5)),
          title: title,
          fontWeight: FontWeight.bold,
          fontSize: textTheme.labelLarge!.fontSize,
          defaultBorderColor: colorsTheme.white,
          onTap: () {
            context
                .read<ContentBloc>()
                .add(UpdateContent(context: context, newContent: content));
            context
                .read<SidebarBloc>()
                .add(ToggleSidebar());
          }),
    );
  }
}
