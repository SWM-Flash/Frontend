import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';
import 'package:flash/model/user_model.dart';
import 'dio_singletone.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;

class MypageController extends GetxController {
  var userModel = UserModel(
    nickName: '',
    instagramId: '',
    height: 1,
    reach: 1,
    gender: '',
    profileImageUrl: '',
  );
  String nickSafetyCode = '';

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> nickNameOverlap(String nickName) async {
    dios.Response response;
    final token = await storage.read(key: ACCESS_TOKEN_KEY);
    DioClient().updateOptions(token: token.toString());
    bool isAvailable = false;
    try {
      print('닉네임 중복확인 get');
      response = await DioClient().dio.get(
        "/members/nickname",
        data: {
          "nickName": nickName,
        },
      );

      Map<String, dynamic> resMap = Map<String, dynamic>.from(response.data);
      isAvailable = resMap["isAvailable"];
      nickSafetyCode = '이미 사용중인 닉네임입니다';
    } catch (e) {
      isAvailable = false;
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
          nickSafetyCode = e.response?.data['nickName'];
        } else {
          print('Error: ${e.message}');
        }
      }
      print('아이디 중복 실패$e');
    }
    return isAvailable;
  }

  Future<void> fetchMemberData() async {
    dios.Response response;
    final token = await storage.read(key: ACCESS_TOKEN_KEY);
    DioClient().updateOptions(token: token.toString());
    try {
      print('유저 정보 get');
      response = await DioClient().dio.get(
            "/members",
          );

      Map<String, dynamic> resMap = Map<String, dynamic>.from(response.data);
      userModel = UserModel.fromJson(resMap);
      print(userModel.nickName);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
      print('유저 정보 받아오기 실패$e');
    }
  }

  void updateMemberInfo(
    String nickName,
    String instagramId,
    double height,
    double reach,
    String gender,
    String profileImg,
  ) async {
    final data = {
      "nickName": nickName,
      "instagramId": instagramId == '' ? null : instagramId,
      "height": height == 0 ? null : height,
      "gender": gender == '' ? null : gender,
      "reach": reach == 0 ? null : reach,
      "profileImageUrl": null,
    };

    try {
      // PATCH 요청
      print('유저 정보 Patch');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      final response = await DioClient().dio.patch('/members', data: data);

      if (response.statusCode == 200) {
        // 요청이 성공적으로 처리된 경우
        print('Member information updated successfully');
      } else {
        print('Failed to update member information: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }
}
