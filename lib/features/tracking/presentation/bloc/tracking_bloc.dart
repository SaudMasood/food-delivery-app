import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/tracking_model.dart';
import 'tracking_event.dart';
import 'tracking_state.dart';

class TrackingBloc
    extends Bloc<TrackingEvent, TrackingState> {
  final TrackingModel order =
  const TrackingModel(
    restaurant: 'Uttora Coffee House',
    orderTime: 'Ordered At 06 Sept, 10:00pm',
    items: '2x Burger\n4x Sandwich',
    deliveryTime: '20 min',
    deliveryMan: 'Robert Fox',
  );

  TrackingBloc()
      : super(TrackingInitial()) {
    on<LoadTracking>((event, emit) {
      emit(
        TrackingLoaded(
          order: order,
          showDetails: false,
        ),
      );
    });

    on<ShowTrackingDetails>((event, emit) {
      emit(
        TrackingLoaded(
          order: order,
          showDetails: true,
        ),
      );
    });
  }
}