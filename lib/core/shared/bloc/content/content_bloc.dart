import 'package:foundational_learning_platform/core/utils/index.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentBloc() : super(ContentInitial()) {
    on<UpdateContent>((event, emit) {
      emit(UpdatedContent(currentContent: event.newContent));
    });

    on<BackToHome>((event, emit) {
      emit(UpdatedContent(currentContent: const HomeContentWidget()));
    });
  }
}
