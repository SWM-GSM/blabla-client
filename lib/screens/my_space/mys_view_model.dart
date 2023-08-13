import 'package:blabla/models/content_category.dart';
import 'package:blabla/models/content_feedback.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';

class MysViewModel with ChangeNotifier {
  final api = API();

  List<ContentCategory> _categoryList = [];
  List<ContentCategory> get categoryList => _categoryList;

  /* 컨텐츠 진입 후 */
  int _contentId = 0;
  ContentFeedback? _feedback;

  ContentFeedback? get feedback => _feedback;

  /* 스피킹 */
  final List<String> _recordPathes = List.generate(3, (idx) => "");
  List<String> get recordPathes => _recordPathes;


  MysViewModel() {
    getCategoryList();
  }

  void getCategoryList() async{
    _categoryList = await api.getContentList();
    notifyListeners();
  }


  void setContentId(int id) {
    _contentId = id;
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
