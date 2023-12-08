class IdeaInfo {
  /// PK
  int? id;

  /// 아이디어 제목
  String title;

  /// 아이디어 작성 동기
  String motive;

  /// 아이디어 내용
  String content;

  /// 아이디어 중요도 점수
  int importance;

  /// 유저 피드백
  String feedback;

  /// 아이디어 작성 일자
  int createDatetime;

  IdeaInfo({
    this.id,
    required this.title,
    required this.motive,
    required this.content,
    required this.importance,
    required this.feedback,
    required this.createDatetime,
  });

  /// Mapped IdeaInfo Instances
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "motive": motive,
      "content": content,
      "importance": importance,
      "feedback": feedback,
      "createDatetime": createDatetime,
    };
  }

  /// Make Instances Cluster
  factory IdeaInfo.fromJson(Map<String, dynamic> data) {
    return IdeaInfo(
      id: data["id"],
      title: data["title"],
      motive: data["motive"],
      content: data["content"],
      importance: data["importance"],
      feedback: data["feedback"],
      createDatetime: data["createDatetime"],
    );
  }
}
