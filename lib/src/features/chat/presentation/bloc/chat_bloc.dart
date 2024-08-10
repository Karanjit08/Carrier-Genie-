import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatNavBarButtonClickedEvent>(chatNavBarButtonClickedEvent);
  }

  FutureOr<void> chatNavBarButtonClickedEvent(ChatNavBarButtonClickedEvent event, Emitter<ChatState> emit) {
    print('Chat Event Triggered');
    emit(ChatNavBarButtonClickedActionState());
  }
}
