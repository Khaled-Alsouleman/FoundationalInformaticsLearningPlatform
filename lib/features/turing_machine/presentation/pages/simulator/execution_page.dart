import 'package:foundational_learning_platform/core/utils/index.dart';
import 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/BuildSpeedControls.dart';


class ExecutionPage extends StatefulWidget {
  final TuringMachine tm;
  final String input;

  const ExecutionPage({Key? key, required this.tm, required this.input}) : super(key: key);

  @override
  _ExecutionPageState createState() => _ExecutionPageState();
}

class _ExecutionPageState extends State<ExecutionPage> {
  Timer? _timer;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  List<TMTransitionFunction> executedTransitions = [];
  int currentStep = -1;
  bool isAutoPlay = false;
  int expandedPanel = 0;

  late final InitializeTuringMachineUseCase initializeTuringMachineUseCase;
  late final ExecuteTransitionUseCase executeTransitionUseCase;
  late final ControlExecutionUseCase controlExecutionUseCase;

  @override
  void initState() {
    super.initState();
    initializeTuringMachineUseCase = InitializeTuringMachineUseCase(
      turingMachineBloc: context.read<TuringMachineBloc>(),
    );

    executeTransitionUseCase = ExecuteTransitionUseCase(
      turingMachineBloc: context.read<TuringMachineBloc>(),
      dynamicBandBloc: context.read<DynamicBandBloc>(),
    );

    controlExecutionUseCase = ControlExecutionUseCase();


    _initializeTuringMachine();
  }

  @override
  void dispose() {
    controlExecutionUseCase.stopTimer();
    super.dispose();
  }

  void _initializeTuringMachine() {
    initializeTuringMachineUseCase.call(widget.input, widget.tm);
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TuringMachineBloc, TuringMachineState>(
      builder: (context, state) {
        if (state is TuringMachineLoaded) {
          if (state.executionState == ApprovalState.rejected) {

          }
          if (state.executionState == ApprovalState.accepted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                showResultDialog(context: context, isAccepted: true);
              }
            });
          }
        }
        return BlocBuilder<DynamicBandBloc, DynamicBandState>(
          builder: (context, bandState) {
            if (bandState is DynamicBandInitial) {
              _initializeBand(context);
            } else if (bandState is DynamicBandLoaded) {
              if (kDebugMode) {
                print('Band last transition : ');
                print(bandState.lastTransition);
              }
              _handleAutoPlay(bandState);
              return _buildLoadedUI(context, bandState);
            }
            return const CircularProgressIndicator();
          },
        );
      },
    );
  }


  void _initializeBand(BuildContext context) {
    context.read<DynamicBandBloc>().add(
      InitializeBand(
        headLocation: 1,
        numberOfBlankSymbol: 25,
        currentState: widget.tm.initialState,
      ),
    );
  }

  void _handleAutoPlay(DynamicBandLoaded bandState) {
    if (bandState.executionState == ExecutionState.paused) {
      controlExecutionUseCase.stopTimer();
    } else if (bandState.executionState == ExecutionState.running && bandState.autoPlay) {
      _startTimer(context, bandState.autoSpeed);
    }
  }

  void _startTimer(BuildContext context, int delay) {
    controlExecutionUseCase.startTimer(context, delay, context.read<TuringMachineBloc>(), widget.tm);
  }

  void _stopTimer() {
    controlExecutionUseCase.stopTimer();
  }

  void _executeTransition(BuildContext context, TMTransitionFunction? transition, {bool back = false, bool isAutoPlay = false}) {
    if (transition != null) {
      executeTransitionUseCase.call(transition, back: back);
    }
  }

  Widget _buildLoadedUI(BuildContext context, DynamicBandLoaded bandState) {
    final screenSize = MediaQuery.of(context).size;

    return RoundedShadowContainer(
      height: screenSize.height - 40,
      width: screenSize.width - 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: _buildDynamicBand(),
          ),
          const Expanded(
            child: ReportWidget(),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildControlPanels(context, bandState),
        ],
      ),
    );
  }

  Widget _buildControlPanels(BuildContext context, DynamicBandLoaded bandState) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.paddingMedium, bottom: AppDimensions.paddingMedium),
      child: SizedBox(
        width: 1000,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleExpansionPanel(
              index: 0,
              title: "Input und Geschwindigkeit",
              isExpanded: expandedPanel == 0,
              onExpansionChanged: (index, isExpanded) {
                setState(() {
                  expandedPanel = expandedPanel == index ? -1 : index;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInputSection(context),
                  const SizedBox(width: AppDimensions.paddingMedium),
                  const BuildSpeedControls(),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            SingleExpansionPanel(
              index: 1,
              title: "Steuerungen",
              isExpanded: expandedPanel == 1,
              onExpansionChanged: (index, isExpanded) {
                setState(() {
                  expandedPanel = expandedPanel == index ? -1 : index;
                });
              },
              child: _buildControlButtons(context, bandState),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicBand() {
    return DynamicBand(
      startState: widget.tm.initialState,
      numberOfBlankSymbol: 25,
    );
  }

  Widget _buildControlButtons(BuildContext context, DynamicBandLoaded bandState) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildControlButton('Reset', () => _resetBand(context, bandState)),
          _buildControlButton('Back', () => _goBack(context, bandState)),
          _buildControlButton('Next', () => _goNext(context, bandState)),
          _buildControlButton(bandState.executionState == ExecutionState.running ? 'Stop' : 'Play',
                  () => _togglePlayPause(context, bandState)),
        ],
      ),
    );
  }

  Widget _buildControlButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 100,
        child: CustomButton(
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }

  void _resetBand(BuildContext context, DynamicBandLoaded bandState) {
    if (!bandState.isInitBand) {
      setState(() {
        currentStep = -1;
      });
      context.read<ReportBloc>().add(ResetReportEvent());
      context.read<DynamicBandBloc>().add(ResetBand(initialState: widget.tm.initialState));
    }
  }

  void _goBack(BuildContext context, DynamicBandLoaded bandState) {
    final lastTrans = bandState.lastTransition?.peek();
    if (!bandState.isInitBand && lastTrans != null) {
      context.read<ReportBloc>().add(ScrollToStepEvent(currentStep));
      _executeTransition(context, lastTrans, back: true);
    }
  }

  void _goNext(BuildContext context, DynamicBandLoaded bandState) {
    final currentTransition = TuringMachineUtils.getNextTransition(bandState, widget.tm.transitions);

    if (currentTransition == null) {
      context.read<TuringMachineBloc>().add(UpdateTMState(executionState: ApprovalState.rejected));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          showResultDialog(context: context, isAccepted: false);
        }
      });
    } else {
      setState(() {
        currentStep += 1;
      });
      context.read<ReportBloc>().add(AddTransitionEvent(currentTransition));
      context.read<ReportBloc>().add(ScrollToStepEvent(currentStep));
      _executeTransition(context, currentTransition, isAutoPlay: false);
    }
  }


  void _togglePlayPause(BuildContext context, DynamicBandLoaded bandState) {
    final currentTransition = TuringMachineUtils.getNextTransition(bandState, widget.tm.transitions);

    if (currentTransition == null  ) {
      context.read<TuringMachineBloc>().add(UpdateTMState(executionState: ApprovalState.rejected));
      context.read<DynamicBandBloc>().add(ControlEvent(action: ControlAction.stop));
      _stopTimer();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          showResultDialog(context: context, isAccepted: false);
        }
      });

    } else {
      if (bandState.executionState == ExecutionState.paused) {
        setState(() {
          isAutoPlay = true;
        });
        _executePlay(context, bandState);
      } else {
        setState(() {
          isAutoPlay = false;
        });

        context.read<DynamicBandBloc>().add(ControlEvent(action: ControlAction.stop));
        _stopTimer();
      }
    }


  }

  void _executePlay(BuildContext context, DynamicBandLoaded bandState) {
    final nextTransition = TuringMachineUtils.getNextTransition(bandState, widget.tm.transitions);

    if (nextTransition != null) {
      _startTimer(context, bandState.autoSpeed);
      context.read<DynamicBandBloc>().add(ControlEvent(action: ControlAction.play, transitionFunction: nextTransition));
    }
  }

  Widget _buildInputSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(),
        _buildLoadButton(context),
      ],
    );
  }

  Widget _buildInputField() {
    return SizedBox(
      width: 300,
      child: MyTextField(
        globalKey: key,
        controller: controller,
        label: const Text(''),
        validator: (value) => TuringMachineUtils.validateInput(value, widget.tm.alphabet),
      ),
    );
  }

  Widget _buildLoadButton(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: CustomButton(
        onPressed: () {
          if (key.currentState?.validate() == true) {
            _loadInput(context);
          }
        },
        borderRadius: AppDimensions.borderRadiusRight,
        child: const Text('Laden'),
      ),
    );
  }

  void _loadInput(BuildContext context) {
    final value = controller.text;
    context.read<DynamicBandBloc>().add(
      UpdateInput(numberOfBlankSymbol: 20, newInput: value, startState: widget.tm.initialState),
    );
  }


}
