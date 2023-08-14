import 'package:blabla/models/content.dart';
import 'package:blabla/models/content_category.dart';
import 'package:blabla/models/content_feedback.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';

enum ContentLangType {
  kor("한국어"),
  eng("영어");

  const ContentLangType(this.korName);
  final String korName;
}

class MysViewModel with ChangeNotifier {
  final api = API();

  ContentLangType _contentLangType = ContentLangType.kor;
  ContentLangType get contentLangType => _contentLangType;
  List<ContentCategory> _categoryList = [];
  List<ContentCategory> get categoryList => _categoryList;

  /* 컨텐츠 진입 후 */
  int _contentId = 0;
  ContentDetail? _content;
  ContentFeedback? _feedback;

  ContentDetail? get content => _content;
  ContentFeedback? get feedback => _feedback;

  /* 스피킹 */
  final List<String> _recordPathes = List.generate(3, (idx) => "");
  List<String> get recordPathes => _recordPathes;

  MysViewModel() {
    getCategoryList();
  }

  void changeContentLangType(bool isLeft) {
    if (isLeft) {
      if (_contentLangType.index != 0) {
        _contentLangType = ContentLangType.values[_contentLangType.index - 1];
      }
    } else {
      if (_contentLangType.index < (ContentLangType.values.length - 1)) {
        _contentLangType = ContentLangType.values[_contentLangType.index + 1];
      }
    }
    _categoryList = [];
    getCategoryList();
    notifyListeners();
  }

  Future<void> getCategoryList() async {
    _categoryList = await api.getContentList(contentLangType);
    notifyListeners();
  }

  void setContentId(int id) async {
    _contentId = id;
    if (id == 0) {
      _content = null;
    } else {
      _content = await api.getContent(id);
    }
    notifyListeners();
  }

  Future<void> getFeedback(String userAnswer) async {
    _feedback = await api.getContentFeedback(_contentId, userAnswer);
    notifyListeners();
  }

  void setRecordPath(int idx, String path) {
    _recordPathes[idx] = path;
    notifyListeners();
  }

  Future<bool> uploadRecords() async {
    final result = await api.uploadRecords(_contentId, _recordPathes);
    return result;
  }
}
