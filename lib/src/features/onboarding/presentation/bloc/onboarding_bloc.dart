import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingButtonClickedNavigateEvent>(onboardingButtonClickedNavigateEvent);
  }

  FutureOr<void> onboardingButtonClickedNavigateEvent(OnboardingButtonClickedNavigateEvent event, Emitter<OnboardingState> emit) {
    print('OnBoarding Event Trigerred');
    emit(OnboardingClickedButtoNavigateActionState());
  }
}
