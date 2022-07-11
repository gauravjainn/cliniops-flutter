import 'package:clini_app/data/constants/constants.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ConsentStudyScreen extends StatefulWidget {
  final String? url;
  final String? studyName;
  const ConsentStudyScreen({this.url, this.studyName});

  @override
  _ConsentStudyScreenState createState() => _ConsentStudyScreenState();
}

class _ConsentStudyScreenState extends State<ConsentStudyScreen> {
  late final VideoPlayerController videoController;
  bool isPlay = true;
  bool isBuffering = true;
  bool muted = false;
  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.network(widget.url!);
    videoController.initialize().then((_) => videoController.play());
  
    videoController.addListener(() {
      isPlay = videoController.value.isPlaying;
      isBuffering = videoController.value.isBuffering;
      if (mounted) {
        setState(() {});
      }
    });
    Future.delayed(const Duration(seconds: 2)).then((value) => {
isBuffering = true,
        setState((){})
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBoxWithHeight(32),
            Text('Study Name', style: AppText.text22w700Black),
            sizedBoxWithHeight(8),
            Text('${widget.studyName}', style: AppText.text16w400Grey),
            sizedBoxWithHeight(16),
            SizedBox(
              height: 280.h,
              child: Stack(
                children: [
                  VideoPlayer(videoController),
                  Center(
                    child: isBuffering
                        ? CircularProgressIndicator(
                            color: AppColors.appPrimary,
                            strokeWidth: 2.w,
                          )
                        : Container(),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 30.h,
                      color: AppColors.greyPrimary.withOpacity(0.4),
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () => {
                                    isPlay
                                        ? videoController.pause()
                                        : videoController.play(),
                                  },
                              iconSize: 18.r,
                              icon: isPlay
                                  ? const Icon(Icons.pause, color: Colors.white,)
                                  : const Icon(Icons.play_arrow, color: Colors.white)),
                          // IconButton(
                          //     onPressed: () => {
                          //           muted
                          //               ? videoController.setVolume(0)
                          //               : videoController.setVolume(1),
                          //           setState(() {
                          //             muted = !muted;
                          //           }),
                          //         },
                          //     iconSize: 18.r,
                          //     icon: !muted
                          //         ? const Icon(Icons.volume_up_rounded)
                          //         : const Icon(Icons.volume_off_rounded))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }
}
