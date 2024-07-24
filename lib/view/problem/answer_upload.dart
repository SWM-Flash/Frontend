import 'dart:html' as html; // dart:html 패키지 임포트
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart' as dios;

class AnswerUpload extends StatefulWidget {
  final String id, imageUrl;
  const AnswerUpload({
    super.key,
    required this.id,
    required this.imageUrl,
  });

  @override
  State<AnswerUpload> createState() => _AnswerUploadState();
}

class _AnswerUploadState extends State<AnswerUpload> {
  VideoPlayerController? videoController;
  Uint8List? _videoBytes; // File 대신 Uint8List 사용
  String nickName = 'Flash',
      instaId = 'climbing_answer',
      oneLinePyeong = '다른 풀이가 있으면 제보해주세요!';
  final TextEditingController nicCon = TextEditingController();
  final TextEditingController inCon = TextEditingController();
  final TextEditingController oneCon = TextEditingController();
  Color uplod200 = Colors.grey;

  @override
  void initState() {
    super.initState();
    nicCon.text = 'Flash';
    inCon.text = 'climbing_answer';
    oneCon.text = '다른 풀이가 있으면 제보해주세요!';
    nicCon.addListener(() {
      setState(() {
        nickName = nicCon.text;
      });
    });
    inCon.addListener(() {
      setState(() {
        instaId = inCon.text;
      });
    });
    oneCon.addListener(() {
      setState(() {
        oneLinePyeong = oneCon.text;
      });
    });
  }

  Future<void> _pickVideo() async {
    try {
      // HTML input element를 사용하여 파일 선택 다이얼로그 열기
      html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.accept = 'video/*';
      uploadInput.click();

      uploadInput.onChange.listen((e) {
        final files = uploadInput.files;
        if (files!.isEmpty) return;
        final reader = html.FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            _videoBytes = reader.result as Uint8List;
            final blob = html.Blob([_videoBytes!]);
            final url = html.Url.createObjectUrlFromBlob(blob);

            videoController = VideoPlayerController.network(url)
              ..initialize().then((_) {
                setState(() {});
                videoController!.play();
              });
          });
        });
        reader.readAsArrayBuffer(files[0]);
      });
    } catch (e) {
      print("비디오 선택 오류 $e");
    }
  }

  Future<void> _uploadVideo() async {
    setState(() {
      uplod200 = const Color.fromARGB(255, 255, 149, 0);
    });

    if (_videoBytes == null) return;
    try {
      final presignedUrlResponse = await Dio().get(
        'https://1rpjfkrhnj.execute-api.ap-northeast-2.amazonaws.com/dev/solutions/presigned-url',
      );
      final presignedUrlData = presignedUrlResponse.data;
      final uploadUrl = presignedUrlData['body']['upload_url'];
      final fileName = presignedUrlData['body']['file_name'];

      final uploadResponse = await Dio().put(
        uploadUrl,
        data: Stream.fromIterable(_videoBytes!.map((e) => [e])), // Uint8List 사용
        options: Options(
          headers: {
            'Content-Type': 'video/*',
          },
        ),
      );

      if (uploadResponse.statusCode == 200) {
        final apiResponse = await Dio().post(
          'https://1rpjfkrhnj.execute-api.ap-northeast-2.amazonaws.com/dev/solutions',
          data: {
            'problem_id': widget.id,
            'video_name': fileName,
            'uploader': nickName,
            'review': oneLinePyeong,
            'instagram_id': instaId,
          },
        );
        if (apiResponse.statusCode == 200) {
          setState(() {
            uplod200 = const Color.fromARGB(255, 0, 255, 8);
          });
        }
      }
    } catch (e) {
      setState(() {
        uplod200 = Colors.red;
      });

      print('영상 업로드 오류 $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.id} 업로드"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                videoController != null
                    ? SizedBox(
                        width: 200,
                        child: AspectRatio(
                          aspectRatio: videoController!.value.aspectRatio,
                          child: VideoPlayer(videoController!),
                        ),
                      )
                    : const SizedBox(
                        width: 200,
                        child: Text('비디오를 선택해주세요'),
                      ),
                SizedBox(
                  child: Image.network(
                    widget.imageUrl,
                    width: 200,
                  ),
                ),
              ],
            ),
            ElevatedButton(onPressed: _pickVideo, child: const Text('비디오 선택')),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: nicCon,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '닉네임',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: inCon,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '인스타 아이디',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: oneCon,
              maxLines: 6,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '한줄평',
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _uploadVideo,
                  child: const Text('업로드'),
                ),
                Icon(
                  Icons.upload,
                  color: uplod200,
                  size: 100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
