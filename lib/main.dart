import 'package:flutter/material.dart';
import 'package:qtec_video_app/app.dart';
import 'package:qtec_video_app/repository/trending_repogitory.dart';

void main() {
  runApp(MyApp(repository: TrendingRepository()));
}
