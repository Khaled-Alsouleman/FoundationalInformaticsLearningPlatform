import 'package:foundational_learning_platform/core/utils/index.dart';

class MyGlobalObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    if (bloc.runtimeType != HoverBloc && bloc.runtimeType != SidebarBloc) {
      debugPrint('${bloc.runtimeType} $event');
    }
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (bloc.runtimeType != HoverBloc && bloc.runtimeType != SidebarBloc) {
      debugPrint('${bloc.runtimeType} $transition');
    }
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (bloc.runtimeType != HoverBloc && bloc.runtimeType != SidebarBloc) {
      debugPrint('${bloc.runtimeType} $change');
    }
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (bloc.runtimeType != HoverBloc && bloc.runtimeType != SidebarBloc) {
      debugPrint('${bloc.runtimeType} $error $stackTrace');
    }
    super.onError(bloc, error, stackTrace);
  }
}
