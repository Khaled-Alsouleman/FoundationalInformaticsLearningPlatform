import 'package:foundational_learning_platform/core/utils/index.dart';
class CustomStepper extends StatefulWidget {
  final int numberOfSteps;
  final List<Widget> steps;
  final VoidCallback? onStepContinue;

  const CustomStepper({
    super.key,
    required this.numberOfSteps,
    required this.steps,
    this.onStepContinue,
  });

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  late StepProgressBloc stepperBloc;

  @override
  void initState() {
    super.initState();
    stepperBloc = context.read<StepProgressBloc>();
    stepperBloc.add(InitializeStepper(numberOfSteps: widget.numberOfSteps));
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<AppColorsTheme>();
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;

    return BlocBuilder<StepProgressBloc, StepProgressState>(
      builder: (context, state) {
        if (state is! StepperLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.steps.length, (index) {
                  return Row(
                    children: [
                      CircleContainer(
                        index: index,
                        currentStep: state.currentStep,
                        hasError: state.stepperState == StepperState.error,
                      ),
                      if (index != widget.steps.length - 1)
                        Container(
                          width: screenSize.width / widget.numberOfSteps / 1.5,
                          height: 2,
                          color: index < state.currentStep
                              ? colorTheme!.primaryColor
                              : colorTheme!.inactiveColor,
                        ),
                    ],
                  );
                }),
              ),
            ),

            state.currentStep < widget.steps.length && widget.steps.isNotEmpty
                ? SizedBox(
              height: screenSize.height / 1.75,
              child: widget.steps[state.currentStep],
            )
                : const Text("Ungültiger Schritt oder keine Schritte verfügbar."),

            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingSmall),
              child: SizedBox(
                width: screenSize.width / 1.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.currentStep > 0)
                      _buildNavigationButton(
                        label: state.currentStep < widget.steps.length - 1 ? 'Zurück' : 'TM bearbeiten',
                        onPressed: () {
                          stepperBloc.add(LastStep());
                          stepperBloc.add(UpdateStepperState(stepperState: StepperState.indexed));
                        },
                      ),
                    const SizedBox(width: 20),
                    _buildNavigationButton(
                      label: state.currentStep < widget.steps.length - 1 ? 'Weiter' : 'TM Laden',
                      onPressed: () {
                        if (widget.onStepContinue != null) {
                          widget.onStepContinue!();
                        } else {
                          if (state.currentStep < widget.steps.length - 1) {
                            stepperBloc.add(NextStep());
                            stepperBloc.add(UpdateStepperState(stepperState: StepperState.indexed));
                          } else {
                            stepperBloc.add(UpdateStepperState(stepperState: StepperState.complete));
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNavigationButton({required String label, required VoidCallback onPressed}) {
    return BlocProvider(
      create: (_) => HoverBloc(),
      child: BlocBuilder<HoverBloc, HoverState>(
        builder: (context, hoverState) {
          return CustomButton(
            onPressed: onPressed,
            child: Text(label),
          ).onHoverEvent(context);
        },
      ),
    );
  }
}
