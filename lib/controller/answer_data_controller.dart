import 'package:flash/model/problem_detail_model.dart';
import 'package:flash/model/solution_model.dart';
import 'package:flash/view/answers/answer_card.dart';
import 'package:flash/view/answers/problem_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;
import 'package:video_player/video_player.dart';
import 'dio_singletone.dart';

class AnswerDataController extends GetxController {
  var answerList = <Widget>[].obs;
  void fetchData(String problemId) async {
    dios.Response response;
    answerList.clear();
    try {
      //문제 디테일 페이지 정보 요청
      response = await DioClient().dio.get(
            "/problems/$problemId",
          );
      Map<String, dynamic> resMap = Map<String, dynamic>.from(response.data);
      ProblemDetailModel detailInfo = ProblemDetailModel.fromJson(resMap);
      answerList.add(
        ProblemDetailCard(
          sector: detailInfo.sector!,
          difficulty: detailInfo.difficulty!,
          settingDate: detailInfo.settingDate!,
          removalDate: detailInfo.removalDate!,
          imgUrl: detailInfo.imageUrl!,
          hasSolution: detailInfo.hasSolution!,
        ),
      );
      //answerList.add(const AnswerCard());
    } catch (e) {
      print('디테일 문제 로딩 실패$e');
    }
    try {
      response = await DioClient().dio.get(
            "/problems/$problemId/solutions",
          );
      List<Map<String, dynamic>> resMapList =
          List<Map<String, dynamic>>.from(response.data["solutions"]);
      List<SolutionModel> sm =
          resMapList.map((e) => SolutionModel.fromJson(e)).toList();
      List<Widget> solutionVideoList = sm.map(
        (sM) {
          VideoPlayerController videoController = VideoPlayerController.network(
            sM.videoUrl!,

            // 비디오 URL
          );

          return AnswerCard(
            videoController: videoController,
            uploader: sM.uploader!,
            review: sM.review!,
            instagramId: sM.instagramId!,
            videoUrl: sM.videoUrl!,
          );
        },
      ).toList();
      answerList.addAll(solutionVideoList);
    } catch (e) {
      print('해설 영상 로딩 실패$e');
    }
  }
}
