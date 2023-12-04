import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qtec_video_app/model/trending_model.dart';
import 'package:qtec_video_app/utils/custom_date.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.model.manifest));
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
        title: const Text('Fetails'),
      ),
      body: Column(
        children: <Widget>[
          AspectRatio(
              aspectRatio: 1.8,
              child: Container(
                  color: Colors.black,
                  child: Chewie(controller: _chewieController))),
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
                            'MASHA Allah (12k)'),
                        buttonCustom(Icons.thumb_up, 'like (10k)'),
                        buttonCustom(Icons.share_sharp, 'like (10k)'),
                        buttonCustom(Icons.flag, 'like (10k)'),
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
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      height: 50,
                      width: 50,
                      child: Image.network(widget.model.channelImage),
                    ),
                    addHorizontalSpace(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.model.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          addVerticalSpace(2),
                          Text(
                            "${widget.model.channelSubscriber} Subscribers",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
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
                 Divider(),
                addVerticalSpace(6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Comments 7.5k', style: GoogleFonts.poppins(fontSize: 12,),),
                    Icon(Icons.double_arrow_sharp),
                  ],
                ),

            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter your text',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey, // Set the border color
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                suffixIcon: Icon(Icons.search), // Trailing icon
              ),
                
              ],
            ),
          ),
        ],
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
          padding: EdgeInsets.all(6),
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
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    ),
  );
}
