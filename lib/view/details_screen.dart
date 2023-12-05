import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qtec_video_app/model/trending_model.dart';
import 'package:qtec_video_app/utils/custom_date.dart';
import 'package:qtec_video_app/utils/route/routes_name.dart';
import 'package:qtec_video_app/utils/utils.dart';
import 'package:video_player/video_player.dart';

import '../utils/helper_widget.dart';

class DetailsScreen extends StatefulWidget {
  final Result model;

  const DetailsScreen({super.key, required this.model});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool isVideoInitialized = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.model.manifest))
          ..initialize().then((value) {
            setState(() {
              isVideoInitialized = true;
              setCrewController();
            });
          });
  }

  void setCrewController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true, // Set to true if you want the video to loop
      aspectRatio:
          16 / 9, // Set the aspect ratio based on your video's dimensions
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AspectRatio(
                  aspectRatio: 1.8,
                  child: Stack(
                    children: [
                      !isVideoInitialized
                          ?
                          // Show thumbnail image while the video is initializing
                          GestureDetector(
                              onTap: () {
                                Utils.showFlashBarMessage('Please wait video loading..', FlashType.success , context);
                              },
                              child: Image.network(
                                widget.model.thumbnail,
                                fit: BoxFit.cover,
                                // width: double.infinity,
                                // height: double.infinity,
                              ),
                            )
                          : Container(
                              child: Chewie(controller: _chewieController)),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.model.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    addVerticalSpace(2),
                    Row(
                      children: [
                        Text(
                          "${widget.model.viewers} views .",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          CustomDate.convertDate(widget.model.dateAndTime),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    //like love buttons
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            buttonCustom(Icons.favorite_outline_outlined,
                                'MASHA ALLAH (12k)'),
                            buttonCustom(Icons.thumb_up, 'LIKE (10k)'),
                            buttonCustom(Icons.share_sharp, 'SHARE'),
                            buttonCustom(Icons.flag, 'REPORT'),
                          ],
                        ),
                      ),
                    ),

                    addVerticalSpace(8),
                    // channel image, button
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          height: 50,
                          width: 50,
                          child: Image.network(
                            widget.model.channelImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        addHorizontalSpace(8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.model.channelName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              addVerticalSpace(2),
                              Text(
                                "${widget.model.channelSubscriber} Subscribers",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RoutesName.emptyScreen);
                          },
                          style: ElevatedButton.styleFrom(
                             padding: EdgeInsets.symmetric(horizontal: 14),
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              )),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              addHorizontalSpace(4),
                              Text(
                                'Subscribe',
                                style: GoogleFonts.inter(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    //divider and comments
                    addVerticalSpace(12),
                    const Divider(),
                    addVerticalSpace(2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Comments 7.5k',
                            style: GoogleFonts.poppins(
                                fontSize: 13, color: Colors.grey),
                          ),
                        ),
                        IconButton(icon: const Icon(Icons.expand_circle_down_outlined, color: Colors.grey,), onPressed: (){
                                Navigator.pushNamed(context, RoutesName.emptyScreen);
                        },),
                      ],
                    ),
                    addVerticalSpace(4),

                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Add Comments',
                        hintStyle: GoogleFonts.poppins(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey, // Set the border color
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.blue, // Set the border color
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 16.0,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.grey,
                          ), onPressed: () {
                          Navigator.pushNamed(context, RoutesName.emptyScreen);

                        },
                        ), // Trailing icon
                      ),
                    ),
                    addVerticalSpace(12),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(6),
                          clipBehavior: Clip.antiAlias,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          height: 35,
                          width: 35,
                          child: Image.network(
                            widget.model.thumbnail,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              addVerticalSpace(4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Fahmida khanom',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  addHorizontalSpace(6),
                                  Text('2 days ago',
                                      style: GoogleFonts.poppins(fontSize: 10)),
                                ],
                              ),
                              Text(
                                'হুজুরের বক্তব্য গুলো ইংরেজি তে অনুবাদ করে সারা পৃথিবীর মানুষদের কে শুনিয়ে দিতে হবে। কথা গুলো খুব দামি',
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buttonCustom(IconData icon, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(6),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          )),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Icon(icon, color: Colors.grey),
            Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            )
          ],
        ),
      ),
    ),
  );
}
