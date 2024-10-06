import 'package:foundational_learning_platform/core/utils/index.dart';

class BuildStateSelection extends StatelessWidget {
  final String title;
  final List<String> states;
  final bool isStartState;
  final Function(int index) onItemSelected;
  final int initialSelectedIndex;

  const BuildStateSelection({
    super.key,
    required this.title,
    required this.isStartState,
    required this.onItemSelected,
    required this.states,
    this.initialSelectedIndex = -1,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
      child: Column(
        children: [
          Column(
            children: [
              Text(
                title,
                style: textTheme.bodyLarge?.copyWith(color: colorsTheme.primaryColor),
              ),
              const SizedBox(height: AppDimensions.paddingSmall),
              BlocBuilder<TMListSelectableBloc, TMListSelectableState>(
                builder: (context, state) {
                  if (kDebugMode) {
                    print('TMListSelectableState: $state');
                  }
                  if (state is TMListSelectableUpdated) {
                    return ListSelectable(
                      items: states,
                      selectedIndices: isStartState
                          ? state.startStateIndices
                          : state.endStateIndices,
                      onItemSelected: onItemSelected,
                      initialSelectedIndex: initialSelectedIndex,
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
