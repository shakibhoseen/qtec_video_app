part of 'videos_bloc_bloc.dart';

@immutable
sealed class VideosBlocState {
  const VideosBlocState();
}

final class VideosBlocInitial extends VideosBlocState {}

class VideoLoadingState extends VideosBlocState {}

class VideoCompleteState extends VideosBlocState {
  final TrendingModel trendingModel;
  final List<Result> videosInfo;
   const VideoCompleteState(this.trendingModel, this.videosInfo);

}

class VideoErrorState extends VideosBlocState {
  final String error;

  const VideoErrorState(this.error);
}
