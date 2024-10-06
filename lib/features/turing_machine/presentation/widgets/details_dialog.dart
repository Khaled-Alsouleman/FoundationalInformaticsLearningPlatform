import 'package:foundational_learning_platform/core/utils/index.dart';
import 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/custom_table_widget.dart';

class MachineDetailsDialog extends StatelessWidget {
  final TuringMachine machine;

  const MachineDetailsDialog({
    Key? key,
    required this.machine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<AppColorsTheme>();
    final textTheme = Theme.of(context).textTheme;
    final screenSize= MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 1.1,
      width: screenSize.width * 1.1,
      decoration: BoxDecoration(
        color: colorTheme!.transparent,
        borderRadius: BorderRadius.circular(AppDimensions.paddingSmall),
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                machine.name?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                machine.description??'',
                style: textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingSmall),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: DynamicTuringMachineTable(
                  states: machine.states,
                  input : machine.alphabet,
                  transitions: machine.transitions,),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
