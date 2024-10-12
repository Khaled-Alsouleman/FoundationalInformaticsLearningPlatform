import 'package:foundational_learning_platform/core/utils/index.dart';

class TMConfiguration extends StatefulWidget {
  const TMConfiguration({super.key});

  @override
  _TMConfigurationState createState() => _TMConfigurationState();
}

class _TMConfigurationState extends State<TMConfiguration> {
  final TextEditingController statesController = TextEditingController();
  final TextEditingController alphabetController = TextEditingController();
  final TextEditingController turingSymbolController = TextEditingController();
  final GlobalKey<FormState> statesKey = GlobalKey<FormState>();
  final GlobalKey<FormState> alphabetKey = GlobalKey<FormState>();

  int currentNumberOfStep = 0;

  @override
  void dispose() {
    statesController.dispose();
    alphabetController.dispose();
    turingSymbolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: _buildMobileLayout(context),
      desktopBody: _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>();

    return Material(
      color: colorsTheme!.backgroundColor,
      child: BlocBuilder<TuringMachineBloc, TuringMachineState>(
        builder: (context, tmConfigurationState) {
          if (tmConfigurationState is TuringMachineLoaded || tmConfigurationState is TuringMachineCreated) {
            return BlocListener<StepProgressBloc, StepProgressState>(
              listener: (context, stepperState) {
                if (stepperState is StepperLoaded) {
                  setState(() {
                    currentNumberOfStep = stepperState.currentStep;
                  });

                  if (stepperState.stepperState == StepperState.complete) {
                    if (tmConfigurationState is TuringMachineCreated) {
                      context.read<ContentBloc>().add(
                        UpdateContent(
                          context: context,
                          newContent: ExecutionPage(
                            tm: tmConfigurationState.turingMachine,
                            input: '',
                          ),
                        ),
                      );
                    }
                  }
                }
              },
              child: Column(
                crossAxisAlignment: currentNumberOfStep != 0
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                mainAxisAlignment: currentNumberOfStep != 0
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  currentNumberOfStep != 0
                      ? const SizedBox(height: 7)
                      : Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                    child: CustomBackButton(
                      onPressed: () {
                        context.read<ContentBloc>().add(
                          UpdateContent(
                            context: context,
                            newContent: const TMStartOptionPage(),
                          ),
                        );
                      },
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildStepperWidget(context),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>();

    return Material(
      color: colorsTheme!.backgroundColor,
      child: BlocBuilder<TuringMachineBloc, TuringMachineState>(
        builder: (context, tmConfigurationState) {
          if (tmConfigurationState is TuringMachineLoaded || tmConfigurationState is TuringMachineCreated) {
            return BlocListener<StepProgressBloc, StepProgressState>(
              listener: (context, stepperState) {
                if (stepperState is StepperLoaded) {
                  setState(() {
                    currentNumberOfStep = stepperState.currentStep;
                  });

                  if (stepperState.stepperState == StepperState.complete) {
                    if (tmConfigurationState is TuringMachineCreated) {
                      context.read<ContentBloc>().add(
                        UpdateContent(
                          context: context,
                          newContent: ExecutionPage(
                            tm: tmConfigurationState.turingMachine,
                            input: '',
                          ),
                        ),
                      );
                    }
                  }
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  currentNumberOfStep != 0
                      ? const SizedBox(height: 7)
                      : Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                    child: CustomBackButton(
                      onPressed: () {
                        context.read<ContentBloc>().add(
                          UpdateContent(
                            context: context,
                            newContent: const TMStartOptionPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  // Desktop spezifisches Layout
                  Align(
                    child: RoundedShadowContainer(
                      height: screenSize.height / 1.3,
                      width: screenSize.width / 1.5,
                      child: _buildStepperWidget(context),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildStepperWidget(BuildContext context) {
    return BuildStepperWidget(
      statesController: statesController,
      alphabetController: alphabetController,
      turingSymbolController: turingSymbolController,
      statesKey: statesKey,
      alphabetKey: alphabetKey,
    );
  }
}
