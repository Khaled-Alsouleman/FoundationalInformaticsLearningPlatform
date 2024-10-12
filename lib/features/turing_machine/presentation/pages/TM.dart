import 'package:foundational_learning_platform/core/utils/index.dart';

class TMPage extends StatefulWidget {
  const TMPage({super.key});

  @override
  State<TMPage> createState() => _TMPageState();
}

class _TMPageState extends State<TMPage> {
  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
    }

    context.read<TuringMachineBloc>().add(ResetEvent());
    context.read<ReportBloc>().add(ResetReport());
    context.read<StepProgressBloc>().add(InitializeStepper(numberOfSteps: 4));
    context.read<TuringMachineBloc>().add(LoadLocalTMs(context: context));
  }

  @override
  void dispose() {

    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }

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
    final textTheme = Theme.of(context).textTheme;
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;
    if (kDebugMode) {
      print("Mobile layout");
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: AppDimensions.paddingMedium),
        Text(
          "Wie möchten Sie lernen?",
          style: textTheme.headlineSmall!.copyWith(
            color: colorsTheme.primaryColor,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge * 2),
        _buildLearningOptionsMobile(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;
    final textTheme = Theme.of(context).textTheme;
    if (kDebugMode) {
      print("Desktop layout");
    }
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
              _buildLearningOptions(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLearningOptions(BuildContext context) {
    return Row(
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
    );
  }

  Widget _buildLearningOptionsMobile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyCard(
          width: 150,
          height: 50,
          title: 'Tutor-Modus',
          fontSize: 12,
          useAnimation: true,
          onTap: () {},
          isActive: false,
        ),
        const SizedBox(width: AppDimensions.paddingLarge * 3),
        MyCard(
          width: 150,
          height: 50,
          title: 'Mit dem Simulator lernen',
          fontSize: 12,
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
    );
  }
}
