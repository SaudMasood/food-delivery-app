import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delevery_app/features/splash/presentation/pages/splash_page.dart';

import 'core/constants/mainscreen.dart';
import 'features/profile/data/datasources/profile_local_data_source.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/usecases/add_address.dart';
import 'features/profile/domain/usecases/get_addresses.dart';
import 'features/profile/domain/usecases/get_profile.dart';
import 'features/profile/domain/usecases/update_profile.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/profile/presentation/bloc/profile_event.dart';

void main() {
  final dataSource = ProfileLocalDataSource();

  final repository = ProfileRepositoryImpl(
    dataSource: dataSource,
  );

  runApp(
    BlocProvider(
      create: (_) => ProfileBloc(
        getProfile: GetProfile(
          repository: repository,
        ),
        updateProfile: UpdateProfile(
          repository: repository,
        ),
        getAddresses: GetAddresses(
          repository: repository,
        ),
        addAddress: AddAddress(
          repository: repository,
        ),
      )..add(LoadProfile()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}