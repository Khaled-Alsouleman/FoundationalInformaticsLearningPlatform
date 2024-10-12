import 'package:foundational_learning_platform/core/utils/index.dart';


class BuildInputSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final Function(String value) onChanged;
  final TuringMachineBloc tmBloc;
  final DynamicBandBloc bandBloc;
  final ReportBloc reportBloc;
  final TuringMachine tm;

  const BuildInputSection({
    Key? key,
    required this.formKey,
    required this.controller,
    required this.validator,
    required this.onChanged,
    required this.tmBloc,
    required this.bandBloc,
    required this.reportBloc,
    required this.tm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildInputField(
          formKey: formKey,
          controller: controller,
          label: '',
          hintText: 'Geben Sie etwas ein',
          validator: validator,
          onChanged: onChanged,
        ),
        SizedBox(
          width: 100,
          height: 50,
          child: CustomButton(
            onPressed: () {
              if (formKey.currentState?.validate() == true) {
                reportBloc.add(ResetReport());
                tmBloc.add(UpdateTMState(executionState: ApprovalState.indexed));
                bandBloc.add(UpdateInput(
                  numberOfBlankSymbol: 20,
                  newInput: controller.text,
                  startState: tm.initialState,
                ));
              }
            },
            borderRadius: AppDimensions.borderRadiusRight,
            child: const Text('Laden'),
          ),
        ),
      ],
    );
  }
}
