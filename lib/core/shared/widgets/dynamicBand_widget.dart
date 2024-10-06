import 'package:foundational_learning_platform/core/utils/index.dart';

class DynamicBand extends StatelessWidget {
  final String startState;
  final int numberOfBlankSymbol;

  const DynamicBand({super.key, required this.startState, required this.numberOfBlankSymbol});

  @override
  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<AppColorsTheme>();

    return BlocListener<DynamicBandBloc, DynamicBandState>(
      listener: (context, state) {
        if (state is DynamicBandLoaded) {
          if (kDebugMode) {
            print('Listener - headLocation: ${state.headLocation}');
          }
        }
      },
      child: BlocBuilder<DynamicBandBloc, DynamicBandState>(
        builder: (context, state) {
          if (state is DynamicBandInitial) {
            context.read<DynamicBandBloc>().add(InitializeBand(numberOfBlankSymbol: numberOfBlankSymbol, currentState: startState, headLocation: 1));
            return const CircularProgressIndicator();
          }

          if (state is DynamicBandLoaded) {
            if (kDebugMode) {
              print('BlocBuilder - headLocation: ${state.headLocation}');
              print('currentState: ${state.currentState}');
            }

            return _buildBand(context, state.tape, state.headLocation, state.currentState);
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }


  Widget _buildBand(BuildContext context, Map<int, String> tape, int headLocation, String currentState) {
    final colorTheme = Theme.of(context).extension<AppColorsTheme>();
    return Column(
      children: [
        SizedBox(
          width: 45.0 * tape.length,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: tape.entries.map((e) {
              return e.key == headLocation
                  ? Stack(
                key: ValueKey('head_${e.key}'),
                children: [
                  Positioned(
                    child: SvgPicture.asset(
                      "images/head.svg",
                      width: 40,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 26,
                    child: Center(
                      child: Text(
                        currentState,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 18,
                            color: colorTheme!.primaryColor),
                      ),
                    ),
                  ),
                ],
              )
                  : Container();
            }).toList(),
          ),
        ),
        SizedBox(
          width: 45.0 * tape.length,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: tape.entries.map((e) {
                return e.key == headLocation
                    ? Animate(
                  child: Container(
                    key: ValueKey('tape_${e.key}'),
                    height: 54,
                    width: 45,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.8),
                      color: colorTheme!.primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        e.value,
                        style: TextStyle(
                          fontSize: 20,
                          decoration: TextDecoration.none,
                          color: colorTheme.white,
                        ),
                      ),
                    ),
                  ),
                ).animate().shimmer()
                    : Container(
                  key: ValueKey('tape_${e.key}'),
                  height: 54,
                  width: 45,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: colorTheme!.white),
                    color: colorTheme.secondaryColor,
                  ),
                  child: Center(
                    child: Text(
                      e.value,
                      style: TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        color: colorTheme.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

}
