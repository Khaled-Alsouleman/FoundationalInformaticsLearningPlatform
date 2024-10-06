import 'package:foundational_learning_platform/core/utils/index.dart';

class ReportWidget extends StatelessWidget {
  const ReportWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>();
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        if (state is ReportLoaded) {
          print("state.currentStep");
          print(state.currentStep);
          return Container(
            width: screenWidth * 0.7,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: const BoxDecoration(
              borderRadius: AppDimensions.borderRadiusAll,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHeaderCell("Schritt", textTheme),
                          _buildHeaderCell("Zustand", textTheme),
                          _buildHeaderCell("Lesen", textTheme),
                          _buildHeaderCell("Schreiben", textTheme),
                          _buildHeaderCell("Neuer Zustand", textTheme),
                          _buildHeaderCell("Kopfbewegung", textTheme),
                        ],
                      ),
                      Divider(color: colorsTheme!.secondaryColor),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: ScrollController(),
                    itemCount: state.transitions.length,
                    itemBuilder: (context, index) {
                      final transition = state.transitions[index];
                      final isHighlighted = state.currentStep == index;

                      // Nur die Card hervorheben, deren Index dem currentStep entspricht
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: getColorState(context, isHighlighted), // Hervorhebung nur, wenn currentStep == index
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildDataCell(context, "${index + 1}", isHighlighted),
                              _buildDataCell(context, transition.currentState, isHighlighted),
                              _buildDataCell(context, transition.readSymbol, isHighlighted),
                              _buildDataCell(context, transition.writtenSymbol, isHighlighted),
                              _buildDataCell(context, transition.nextState, isHighlighted),
                              _buildDataCell(context, transition.movementDirection.name, isHighlighted),
                            ],
                          ),
                        ),
                      );
                    },

                  ),
                ),
              ],
            ),
          );
        } else {
          return LottieBuilder.asset(
            'animation/typing.json',
            height: MediaQuery.of(context).size.height /6,
            width: MediaQuery.of(context).size.width /5,
            fit: BoxFit.fill,
          );
        }
      },
    );
  }

  Widget _buildHeaderCell(String label, TextTheme textTheme) {
    return Expanded(
      child: Center(
        child: Text(label, style: textTheme.labelLarge),
      ),
    );
  }

  Widget _buildDataCell( BuildContext context  ,String value, bool isHighlighted) {
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>();
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Center(
        child: Text(
          value,
          style: textTheme.labelLarge!.copyWith(
            color: !isHighlighted ? colorsTheme!.primaryColor : colorsTheme!.white ,
          ),
        ),
      ),
    );
  }

  Color getColorState(BuildContext context, bool isHighlighted) {
    final tmState = context.read<TuringMachineBloc>().state;
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>();
    var currentColor = colorsTheme!.white;
    if (tmState is TuringMachineLoaded) {
      if (tmState.executionState == ApprovalState.rejected) {
        currentColor = colorsTheme.errorHeight;
        if (kDebugMode) {
          print('getColorState: Execution state is rejected, using error color.');
        }
      } else if (tmState.executionState == ApprovalState.accepted) {
        currentColor = colorsTheme.green;
        if (kDebugMode) {
          print('getColorState: Execution state is accepted, using green color.');
        }
      } else {

        if(isHighlighted){ currentColor = colorsTheme.primaryColor;}
        if (kDebugMode) {
          print('getColorState: Execution state loaded, using default color.');
        }
      }
    } else {
      if (kDebugMode) {
        print('getColorState: State is not TuringMachineLoaded, using default color.');
      }
    }
    if (kDebugMode) {
      print('getColorState: Returning color: $currentColor');
    }
    return currentColor;
  }

}
