import 'package:foundational_learning_platform/core/utils/index.dart';

class ExecutionPage extends StatefulWidget {
  final TuringMachine tm;
  final String input;

  const ExecutionPage({Key? key, required this.tm, required this.input}) : super(key: key);

  @override
  _ExecutionPageState createState() => _ExecutionPageState();
}

class _ExecutionPageState extends State<ExecutionPage> {

  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  List<TMTransitionFunction> executedTransitions = [];
  int currentStep = -1;
  bool isAutoPlay = false;
  int expandedPanel = 0;
  bool _dialogShown = false;

  late final InitializeTuringMachineUseCase initializeTuringMachineUseCase;
  late final ExecuteTransitionUseCase executeTransitionUseCase;
  late final TuringMachineBloc tmBloc;
  late final DynamicBandBloc bandBloc;
  late final ReportBloc reportBloc;
  late final ContentBloc contentBloc;

  @override
  void initState() {
    super.initState();
    initializeTuringMachineUseCase = InitializeTuringMachineUseCase(
      turingMachineBloc: context.read<TuringMachineBloc>(),
    );

    initializeTuringMachineUseCase.call(widget.input, widget.tm);

    //Initialize Blocs
    tmBloc = context.read<TuringMachineBloc>();
    bandBloc = context.read<DynamicBandBloc>();
    reportBloc = context.read<ReportBloc>();
    contentBloc = context.read<ContentBloc>();

    executeTransitionUseCase = ExecuteTransitionUseCase(
        turingMachineBloc: tmBloc,
        dynamicBandBloc: bandBloc,
        reportBloc: reportBloc
    );

    context.read<DynamicBandBloc>().add(
      InitializeBand(
        headLocation: 1,
        numberOfBlankSymbol: 25,
        currentState: widget.tm.initialState,
      ),
    );


  }

  @override
  void dispose() {
    executeTransitionUseCase.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TuringMachineBloc, TuringMachineState>(
      builder: (context, state) {
        if(reportBloc.state is ReportInitial){
          reportBloc.add(InitializeReport());
        }
        if (state is TuringMachineLoaded) {
        if(state.executionState == ApprovalState.accepted){
          _showResultDialog(isAccepted: true);
        }else if(state.executionState == ApprovalState.rejected){
          _showResultDialog(isAccepted: false);
        }
        }
        return BlocBuilder<DynamicBandBloc, DynamicBandState>(
          builder: (context, bandState) {
          if (bandState is DynamicBandLoaded) {
              return _buildLoadedUI(context, bandState);
            }
            return const CircularProgressIndicator();
          },
        );
      },
    );
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
            child: DynamicBand(
              startState: widget.tm.initialState,
              numberOfBlankSymbol: 25,
            ),
          ),
          Expanded(
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

  Widget _buildInputSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildInputField(
          formKey: key,
          controller: controller,
          label: '',
          hintText: '',
          validator: (value) => TuringMachineUtils.validateInput(value, widget.tm.alphabet),
          onChanged: (value) {},
        ),

        _buildLoadButton(context),
      ],
    );
  }

  Widget _buildControlButtons(BuildContext context, DynamicBandLoaded bandState) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildControlButton('Neuer TM?', () => _newTM()),
          _buildControlButton('Zurücksetzen', () => _resetBand()),
          _buildControlButton('Zurück', () => _goBack(context, bandState)),
          _buildControlButton('Nächst', () => _goNext(context, bandState)),
          _buildControlButton(bandState.executionState == ExecutionState.running ? 'Anhalten' : 'Auto',
                  () => _toggleAutoPlay(bandState)),
        ],
      ),
    );
  }

  void _handleAutoPlay(DynamicBandLoaded bandState) {
    if (bandState.executionState == ExecutionState.paused) {
      executeTransitionUseCase.stopTimer();
    } else if (bandState.executionState == ExecutionState.running && bandState.autoPlay) {
      executeTransitionUseCase.startTimer();
    }
  }

  Widget _buildControlButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 130,
        child: CustomButton(
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }

  void _newTM(){
    reportBloc.add(ResetReport());
    bandBloc.add(ResetBand(initialState: widget.tm.initialState));
    tmBloc.add(ResetEvent());
    tmBloc.add(LoadLocalTMs(context: context));
    contentBloc.add(UpdateContent(context: context, newContent: const  TMStartOptionPage()));
  }
  void _resetBand() {
    final bandState = bandBloc.state;
    if (bandState is DynamicBandLoaded && !bandState.isInitBand) {
      reportBloc.add(ResetReport());
      bandBloc.add(ResetBand(initialState: widget.tm.initialState));
      tmBloc.add(UpdateTMState(executionState: ApprovalState.indexed));
     setState(() {
       _dialogShown = false;
     });
    }
  }

  void _goBack(BuildContext context, DynamicBandLoaded bandState) {

    if (!bandState.isInitBand) {
      executeTransitionUseCase.call(back: true);
    }
  }

  void _goNext(BuildContext context, DynamicBandLoaded bandState) {
    final tmState = tmBloc.state;
    if (tmState is TuringMachineLoaded &&
        tmState.executionState != ApprovalState.accepted &&
        tmState.executionState != ApprovalState.rejected) {
      executeTransitionUseCase.call(back: false);
    }
  }

  void _toggleAutoPlay(DynamicBandLoaded bandState) {
    final tmState = tmBloc.state;
    if(tmState is TuringMachineLoaded && tmState.executionState == ApprovalState.indexed){
      if (bandState.executionState == ExecutionState.running) {

        executeTransitionUseCase.stopTimer();
        bandBloc.add(UpdateAutoPlay(isAutoPlay: false));
        bandBloc.add(ControlEvent(action: ControlAction.stop, transitionFunction: null));
      } else {

        executeTransitionUseCase.startTimer();
        bandBloc.add(UpdateAutoPlay(isAutoPlay: true));
      }
    }

  }


  Widget _buildLoadButton(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: CustomButton(
        onPressed: () {
          context.read<DynamicBandBloc>().add(
            UpdateInput(
                numberOfBlankSymbol: 20,
                newInput: controller.text,
                startState: widget.tm.initialState),
          );
          _resetBand();
        },
        borderRadius: AppDimensions.borderRadiusRight,
        child: const Text('Laden'),
      ),
    );
  }

  void _showResultDialog({required bool isAccepted}) {
    if (!_dialogShown) {
      // Schedule the dialog to show after the current build process is completed
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _dialogShown = true;
        });
        showResultDialog(context: context, isAccepted: isAccepted);
      });
    }
  }


}
