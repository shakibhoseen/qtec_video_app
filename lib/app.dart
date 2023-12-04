import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_video_app/app_view.dart';
import 'package:qtec_video_app/bloc/bloc/videos_bloc_bloc.dart';
import 'package:qtec_video_app/repository/trending_repogitory.dart';
import 'package:qtec_video_app/view/home_screen.dart';

class MyApp extends StatelessWidget {
  final TrendingRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideosBlocBloc(repository: repository),
      child: const MyAppView(),
    );
  }
}