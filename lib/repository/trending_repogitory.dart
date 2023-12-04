// video_repository.dart



import 'package:qtec_video_app/data/network/base_api_services.dart';
import 'package:qtec_video_app/data/network/network_api_services.dart';
import 'package:qtec_video_app/model/trending_model.dart';

class TrendingRepository {
  final BaseApiServices _repository = NetworkAPiServices();

  Future<TrendingModel> getVideos(int page) async {
    try {
       final response = await _repository.getApiResponse('https://test-ximit.mahfil.net/api/trending-video/1?page=$page');
       return TrendingModel.fromJson(response);
    } catch (error) {
      rethrow;
    }
   
  }
}
