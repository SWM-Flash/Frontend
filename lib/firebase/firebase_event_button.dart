import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future<void> screenView(String screenName, String gymId) async {
    //제보페이지 버튼
    await analytics.logScreenView(
      screenName: '(1.0)$screenName',
      parameters: <String, Object>{
        'gymId': gymId,
      },
    );
  }

  static Future<void> buttonClick(String buttonName, pageName, gymName) async {
    //버튼클릭 이벤트
    await analytics.logEvent(
      name: '(1.0)$buttonName',
      parameters: <String, Object>{
        'buttonName': buttonName,
        'pageName': pageName,
        'gymName': gymName,
      },
    );
  }

  static Future<void> problemClick(
    //문제 선택 이벤트
    String id,
    String difficulty,
    String sector,
    String hasSolution,
  ) async {
    await analytics.logEvent(
      name: '(1.0)문제 선택',
      parameters: <String, Object>{
        'id': id,
        'difficulty': difficulty,
        'sector': sector,
        'hasSolution': hasSolution,
      },
    );
  }

  static Future<void> sendVedioEvent(
    //비디오 플레이 이벤트
    String type,
    String useuri,
  ) async {
    await analytics.logEvent(
      name: '(1.0)video',
      parameters: <String, Object>{
        'type': type,
        'videoUrl': useuri,
      },
    );
  }

  static Future<void> modalClick(
    String buttonName,
    String gymName,
    String diffOption,
    String secOption,
    String nobodySol,
  ) async {
    //필터 모달 버튼
    await analytics.logEvent(
      name: '(1.0): $buttonName',
      parameters: <String, Object>{
        'gymName': diffOption,
        'diffOption': diffOption,
        'secOption': secOption,
        'nobodySol': nobodySol,
      },
    );
  }

  static Future<void> answerSlide(
    //비디오 플레이 이벤트
    String index,
    String id,
    String difficulty,
    String sector,
  ) async {
    await analytics.logEvent(
      name: '(1.0)풀이 슬라이드',
      parameters: <String, Object>{
        'index': index,
        'id': id,
        'difficulty': difficulty,
        'sector': sector,
      },
    );
  }
}
