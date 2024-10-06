import 'package:flutter_bloc/flutter_bloc.dart';
import 'sidebar_event.dart';
import 'sidebar_state.dart';

class SidebarBloc extends Bloc<SidebarEvent, SidebarState> {
  SidebarBloc() : super(SidebarClosed()) {
    on<ToggleSidebar>((event, emit) {
      if (state is SidebarOpened) {
        emit(SidebarClosed());
      } else {
        emit(SidebarOpened());
      }
    });
  }
}
