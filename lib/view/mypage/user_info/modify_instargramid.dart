import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/mypage_modify_controller.dart';
import 'package:flash/controller/user_onboarding_controlle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModifyInstargramid extends StatelessWidget {
  ModifyInstargramid({super.key});
  final mypageModifyController = Get.put(MypageModifyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Text(
                  '인스타그램id 변경',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(33, 33, 33, 1),
                  ),
                ),
                SizedBox(width: 40),
              ],
            ),
          ),
        ),
        backgroundColor: ColorGroup.appbarBGC,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: mypageModifyController.modifyText,
              style: TextStyle(fontSize: 24),
              maxLines: null,
              decoration: InputDecoration(
                hintText: mypageModifyController.rxUserModel.instagramId.value,
                hintStyle: TextStyle(fontSize: 24),
                border: InputBorder.none,
              ),
              onChanged: (value) {},
            ),
            Obx(
              () {
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: mypageModifyController.isEmpty.value
                          ? ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(250, 60),
                                foregroundColor: ColorGroup.selectBtnFGC,
                                backgroundColor:
                                    Color.fromRGBO(213, 213, 213, 1),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                "변경하기",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                mypageModifyController
                                        .rxUserModel.instagramId.value =
                                    mypageModifyController.modifyText.text;
                                print(
                                  mypageModifyController
                                          .rxUserModel.instagramId.value +
                                      '변경',
                                );
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(250, 60),
                                foregroundColor: ColorGroup.selectBtnFGC,
                                backgroundColor: ColorGroup.selectBtnBGC,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                "변경하기",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
