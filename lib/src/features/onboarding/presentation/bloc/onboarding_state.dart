part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingState {}

abstract class OnboardingActionState extends OnboardingState{}

class OnboardingInitial extends OnboardingState {}



class OnboardingClickedButtoNavigateActionState extends OnboardingActionState{

}


