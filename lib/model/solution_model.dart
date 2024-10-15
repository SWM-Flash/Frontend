class SolutionModel {
  int? id;
  String? uploader;
  String? review;
  String? instagramId;
  String? videoUrl;
  String? uploaderId;
  bool? isUploader;
  String? profileImageUrl;
  int? commentCount;

  SolutionModel({
    this.id,
    this.uploader,
    this.review,
    this.instagramId,
    this.videoUrl,
    this.uploaderId,
    this.isUploader,
    this.profileImageUrl,
    this.commentCount,
  });

  SolutionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploader = json['uploader'];
    review = json['review'];
    instagramId = json['instagramId'];
    videoUrl = json['videoUrl'];
    uploaderId = json['uploaderId'];
    isUploader = json['isUploader'];
    profileImageUrl = json['profileImageUrl'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uploader'] = this.uploader;
    data['review'] = this.review;
    data['instagramId'] = this.instagramId;
    data['videoUrl'] = this.videoUrl;
    data['uploaderId'] = this.uploaderId;
    data['isUploader'] = this.isUploader;
    data['profileImageUrl'] = this.profileImageUrl;
    data['commentCount'] = this.commentCount;
    return data;
  }
}
