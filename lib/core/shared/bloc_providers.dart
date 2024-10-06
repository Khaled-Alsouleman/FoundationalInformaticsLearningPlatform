import 'package:foundational_learning_platform/core/utils/index.dart';

class AppBlocProviders {
  static Future<List<BlocProvider>> getProviders() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final turingMachineLocalDataSource = TuringMachineLocalDataSource(
      sharedPreferences: sharedPreferences,
    );

    final turingMachineRepository = TuringMachineRepositoryImpl(
      localDataSource: turingMachineLocalDataSource,
    );

    return [
      BlocProvider<SidebarBloc>(create: (_) => SidebarBloc()),
      BlocProvider<QuizBloc>(create: (_) => QuizBloc()),
      BlocProvider<StepProgressBloc>(create: (_) => StepProgressBloc()),
      BlocProvider<AnimationBloc>(create: (_) => AnimationBloc()),
      BlocProvider<DynamicBandBloc>(create: (_) => DynamicBandBloc()),
      BlocProvider<ContentBloc>(create: (_) => ContentBloc()),
      BlocProvider<TuringMachineBloc>(create: (_) => TuringMachineBloc(repository: turingMachineRepository),),
      BlocProvider<TMListSelectableBloc>(create: (_) => TMListSelectableBloc()),
      BlocProvider<HoverBloc>(create: (_) => HoverBloc()),
      BlocProvider<ReportBloc>(create: (_) => ReportBloc()),
      BlocProvider<SingleSelectionBloc<LocalTMList>>(create: (_) => SingleSelectionBloc<LocalTMList>()),
    ];
  }
}
