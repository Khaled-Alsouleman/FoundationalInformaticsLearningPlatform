import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'hover_event.dart';
part 'hover_state.dart';

class HoverBloc extends Bloc<HoverEvent, HoverState> {
  HoverBloc() : super(HoverInitial()) {
    on<OnHoverEnter>((event, emit) {
      emit(OnHover());
    });

    on<OnHoverExit>((event, emit) {
      emit(HoverInitial());
    });
  }
}
