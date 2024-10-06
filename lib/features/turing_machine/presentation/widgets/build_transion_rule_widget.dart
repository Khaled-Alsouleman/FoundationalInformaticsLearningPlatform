import 'package:foundational_learning_platform/core/utils/index.dart';

class TransitionRuleWidget extends StatelessWidget {
  final int index;
  final TMTransitionFunction rule;
  final List<String> states;
  final List<String> dropdownItems;

  const TransitionRuleWidget({
    required this.index,
    required this.rule,
    required this.states,
    required this.dropdownItems,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<AppColorsTheme>();
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<TuringMachineBloc, TuringMachineState>(
      builder: (context, state) {
        EditingState ruleStatus = EditingState.editing;
        if (state is TuringMachineLoaded) {
          if (index < state.transitionStatuses.length) {
            ruleStatus = state.transitionStatuses[index];
          }
        }


        final circleAvatarColor = GetCircleAvatarColorUseCase().call(ruleStatus);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingSmall),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: CircleAvatar(
                  backgroundColor: circleAvatarColor,
                  child: Text(
                    '${index + 1}',
                    style: textTheme.labelLarge!.copyWith(color: colorTheme!.primaryColor),
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.paddingMedium),
              MyDropdownMenu(
                items: states,
                initialValue: rule.currentState,
                label: "Aktueller Zustand",
                onChanged: (value) {
                  _updateTransitionRule(context, rule.copyWith(currentState: value!));
                },
              ),
              const SizedBox(width: AppDimensions.paddingMedium),
              MyDropdownMenu(
                items: dropdownItems,
                initialValue: rule.readSymbol,
                label: "Lesen",
                onChanged: (value) {
                  _updateTransitionRule(context, rule.copyWith(readSymbol: value!));
                },
              ),
              const SizedBox(width: AppDimensions.paddingMedium),
              MyDropdownMenu(
                items: dropdownItems,
                initialValue: rule.writtenSymbol,
                label: "Schreiben",
                onChanged: (value) {
                  _updateTransitionRule(context, rule.copyWith(writtenSymbol: value!));
                },
              ),
              const SizedBox(width: AppDimensions.paddingMedium),
              MyDropdownMenu(
                items: [MovementDirection.links.name, MovementDirection.rechts.name, MovementDirection.bleiben.name],
                initialValue: rule.movementDirection.name,
                label: "Bewegung",
                onChanged: (value) {
                  _updateTransitionRule(context, rule.copyWith(movementDirection: MovementDirection.values.byName(value!)));
                },
              ),
              const SizedBox(width: AppDimensions.paddingMedium),
              MyDropdownMenu(
                items: states,
                initialValue: rule.nextState,
                label: "Neuer Zustand",
                onChanged: (value) {
                  _updateTransitionRule(context, rule.copyWith(nextState: value!));
                },
              ),
              const SizedBox(width: AppDimensions.paddingMedium),
              IconButton(
                icon: Icon(Icons.delete, color: colorTheme.errorLow),
                onPressed: () => context.read<TuringMachineBloc>().add(RemoveTransitionRuleEvent(index: index)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateTransitionRule(BuildContext context, TMTransitionFunction updatedRule) {

    UpdateTransitionRuleUseCase().call(
      context: context,
      updatedRule: updatedRule,
      index: index,
    );
  }
}

