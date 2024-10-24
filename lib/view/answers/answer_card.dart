import 'package:flash/view/answers/answer_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AnswerCard extends StatelessWidget {
  final String uploader, review, instagramId, videoUrl;
  final VideoPlayerController videoController;
  const AnswerCard({
    super.key,
    required this.uploader,
    required this.review,
    required this.instagramId,
    required this.videoUrl,
    required this.videoController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnswerPlayer(
              videoController: videoController,
              useUri: videoUrl,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '제보자: $uploader',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text("@$instagramId"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '한줄평: $review',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
