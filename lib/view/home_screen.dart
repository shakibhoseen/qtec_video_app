import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qtec_video_app/bloc/bloc/videos_bloc_bloc.dart';
import 'package:qtec_video_app/model/trending_model.dart';
import 'package:qtec_video_app/utils/custom_date.dart';
import 'package:qtec_video_app/utils/helper_widget.dart';
import 'package:qtec_video_app/utils/route/routes_name.dart';
import 'package:qtec_video_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Result> allVideoInfo = [];
  final  hasPageEnd = [false];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Load the initial page
    BlocProvider.of<VideosBlocBloc>(context).add(LoadVideosEvent(page: 1));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (hasPageEnd[0]) {
        Utils.showToastMessage('you reached the end of pages');
        return;
      }
      BlocProvider.of<VideosBlocBloc>(context).add(LoadVideosEvent(
          page: BlocProvider.of<VideosBlocBloc>(context).currentPage + 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<VideosBlocBloc, VideosBlocState>(
        builder: (context, state) {
          if (state is VideoCompleteState) {
            if (state.trendingModel.links.next == null) {
              hasPageEnd[0] = true;
            }

            allVideoInfo.addAll(state.videosInfo);
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(10),
                Text(
                  'Trending Videos',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                addVerticalSpace(16),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: allVideoInfo.length,
                    itemBuilder: (context, index) {
                      final item = allVideoInfo[index];
                      return GestureDetector(
                        onTap: () {
                          Utils.showToastMessage('tap');
                          Navigator.pushNamed(context, RoutesName.detailsScreen, arguments: item);
                        },
                        child: videoItemDesign(item),
                      );
                    },
                  ),
                ),
                state is VideoLoadingState
                    ? const Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                                             ),
                       ],
                     )
                    : Container(),
              ],
            ),
          );
        },
      ),
    ));
  }
}

Widget videoItemDesign(Result videoModel) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2),
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.8,
              child: Image.network(
                videoModel.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      videoModel.duration,
                      style: const TextStyle(color: Colors.white),
                    ))),
          ],
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 16.0, bottom: 16, left: 16, right: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                height: 50,
                width: 50,
                child: Image.network(videoModel.channelImage),
              ),
              addHorizontalSpace(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      videoModel.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    addVerticalSpace(2),
                    Row(
                      children: [
                        Text(
                          "${videoModel.viewers} views .",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          CustomDate.convertDate(videoModel.dateAndTime),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
