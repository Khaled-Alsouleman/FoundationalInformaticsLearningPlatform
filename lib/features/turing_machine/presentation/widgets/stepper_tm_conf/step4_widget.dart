import 'package:foundational_learning_platform/core/utils/index.dart';

class CompletionStep extends StatelessWidget {
  const CompletionStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<AppColorsTheme>();
    return BlocBuilder<TuringMachineBloc, TuringMachineState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            color: colorTheme!.transparent,
            width: MediaQuery.of(context).size.width / 1.2,
            child: Column(
              children: [
                const SizedBox(height: 5),
                const Text('Konfiguration abgeschlossen.'),
                state is TuringMachineCreated
                    ? MachineDetailsDialog(machine: state.turingMachine)
                    : Container(),

              ],
            ),
          ),
        );
      },
    );
  }
}
