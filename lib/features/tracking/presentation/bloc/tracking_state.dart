import '../../data/models/tracking_model.dart';

abstract class TrackingState {}

class TrackingInitial extends TrackingState {}

class TrackingLoaded extends TrackingState {
  final TrackingModel order;
  final bool showDetails;

  TrackingLoaded({
    required this.order,
    required this.showDetails,
  });
}