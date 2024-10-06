import 'package:foundational_learning_platform/core/error/noConnectionPage.dart';
import 'package:foundational_learning_platform/core/utils/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;
    final screenSize = MediaQuery.of(context).size;

    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) {
        late Widget content;
        content = (state is UpdatedContent)
            ? state.currentContent
            : const HomeContentWidget();
        return Scaffold(
          backgroundColor: colorsTheme.backgroundColor,
          body: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: content
              ),
              SideBarWidget(parentHeight: screenSize.height / 1.02),
            ],
          ),
        );
      },
    );
  }
}
