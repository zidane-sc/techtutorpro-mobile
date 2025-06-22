part of 'purchased_course_bloc.dart';

abstract class PurchasedCourseState extends Equatable {
  final List<PurchasedCourseEntity> courses;

  const PurchasedCourseState({this.courses = const []});

  @override
  List<Object> get props => [courses];
}

class PurchasedCourseInitial extends PurchasedCourseState {}

class PurchasedCourseLoading extends PurchasedCourseState {
  const PurchasedCourseLoading({super.courses});
}

class PurchasedCourseLoaded extends PurchasedCourseState {
  const PurchasedCourseLoaded({required super.courses});
}

class PurchasedCourseError extends PurchasedCourseState {
  final String message;

  const PurchasedCourseError({required this.message, super.courses});

  @override
  List<Object> get props => [message, courses];
}
