import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/tracking_model.dart';
import 'tracking_event.dart';
import 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  TrackingBloc() : super(TrackingInitial()) {
    on<LoadTracking>((event, emit) {
      emit(TrackingLoading());

      const order = TrackingModel(
        restaurant: 'Uttora Coffee House',
        orderTime: 'Ordered At 06 Sept, 10:00pm',
        items: '2x Burger\n4x Sandwich', deliveryTime: '', deliveryMan: '',
      );

      emit(
        TrackingLoaded(
          order: order,
          showDetails: false,
        ),
      );
    });

    on<ShowTrackingDetails>((event, emit) {
      if (state is TrackingLoaded) {
        final current = state as TrackingLoaded;

        emit(
          TrackingLoaded(
            order: current.order,
            showDetails: true,
          ),
        );
      }
    });

    on<HideTrackingDetails>((event, emit) {
      if (state is TrackingLoaded) {
        final current = state as TrackingLoaded;

        emit(
          TrackingLoaded(
            order: current.order,
            showDetails: false,
          ),
        );
      }
    });
  }
}