import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qtec_video_app/model/trending_model.dart';
import 'package:qtec_video_app/model/trending_model.dart';
import 'package:qtec_video_app/repository/trending_repogitory.dart';

part 'videos_bloc_event.dart';
part 'videos_bloc_state.dart';

class VideosBlocBloc extends Bloc<VideosBlocEvent, VideosBlocState> {
  final TrendingRepository _repository;

  int currentPage =
      0; // the track of the data from the loaded api page to prevent duplicate data inside videoResult;
  int callPage =
      0; // prevent duplicate call for the same page like user scroll simultaneously ups down its will be;

  VideosBlocBloc({required TrendingRepository repository})
      : _repository = repository,
        super(VideosBlocInitial()) {
    on<LoadVideosEvent>((event, emit) async {
      if (callPage == event.page) return;
      if (currentPage >= event.page) {
        return;
      }
      callPage = event.page;

      emit(VideoLoadingState());
      try {
        TrendingModel model = await _repository.getVideos(event.page);
        if (currentPage < model.page) {

          if(model.links.next!=null){
            currentPage = model.page;
          }
          // Append the new video results to the existing list
          emit(VideoCompleteState(model, model.results));
        }
      } catch (e) {
        emit(VideoErrorState(e.toString()));
      }
    });
  }
}
