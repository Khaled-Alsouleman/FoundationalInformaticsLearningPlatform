import 'package:foundational_learning_platform/core/utils/index.dart';

class TMPage extends StatefulWidget {
  const TMPage({super.key});

  @override
  State<TMPage> createState() => _TMPageState();
}

class _TMPageState extends State<TMPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TuringMachineBloc>().add(ResetEvent());
    context.read<StepProgressBloc>().add(InitializeStepper(numberOfSteps: 4));
    context.read<TuringMachineBloc>().add(LoadLocalTMs(context: context));
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<TuringMachineBloc, TuringMachineState>(
      builder: (context, tMState) {


        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: AppDimensions.paddingMedium),
            RoundedShadowContainer(
              alignment: Alignment.center,
              height: screenSize.height / 2,
              width: screenSize.width / 1.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Wie möchten Sie lernen?",
                    style: textTheme.headlineSmall!.copyWith(
                      color: colorsTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingLarge * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyCard(
                        width: 250,
                        height: 75,
                        title: 'Tutor-Modus',
                        useAnimation: true,
                        onTap: () {},
                        isActive: false,
                      ),
                      const SizedBox(width: AppDimensions.paddingLarge * 3),
                      MyCard(
                        width: 250,
                        height: 75,
                        title: 'Mit dem Simulator lernen',
                        useAnimation: true,
                        onTap: () {
                          context.read<SingleSelectionBloc<LocalTMList>>().add(ResetSelectionEvent<LocalTMList>());
                          context.read<ContentBloc>().add(UpdateContent(
                            context: context,
                            newContent: const TMStartOptionPage(),
                          ));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
