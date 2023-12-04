part of 'videos_bloc_bloc.dart';

@immutable
sealed class VideosBlocEvent {}


class LoadVideosEvent extends VideosBlocEvent {
  final int page;

  LoadVideosEvent({required this.page});
}