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


                  print('currentNumberOfStep');
                  print(currentNumberOfStep);

                  if (stepperState.stepperState == StepperState.complete) {
                    if (tmConfigurationState is TuringMachineCreated) {
                      print('tmConfigurationState.turingMachine');
                      print(tmConfigurationState.turingMachine);
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
                crossAxisAlignment:  currentNumberOfStep != 0 ?  CrossAxisAlignment.center : CrossAxisAlignment.start ,
                mainAxisAlignment:   currentNumberOfStep != 0 ?  MainAxisAlignment.center  :  MainAxisAlignment.start,
                children: [
                  currentNumberOfStep != 0
                      ? const SizedBox(height: 7,)
                      : Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingMedium,),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        child: RoundedShadowContainer(
                          height: screenSize.height / 1.3,
                          width: screenSize.width / 1.5,
                          child: BuildStepperWidget(
                            statesController: statesController,
                            alphabetController: alphabetController,
                            turingSymbolController: turingSymbolController,
                            statesKey: statesKey,
                            alphabetKey: alphabetKey,
                          ), // _buildStepper(context, tmConfigurationState),
                        ),
                      ),
                    ],
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
}
