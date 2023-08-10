import 'package:blabla/models/content_feedback.dart';
import 'package:blabla/screens/my_space/widgets/mys_content_record_widget.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';

class MysViewModel with ChangeNotifier {
  final api = API();

  int _contentId = 0;
  ContentFeedback? _feedback;

  ContentFeedback? get feedback => _feedback;

  /* 스피킹 */
  List<String> _recordPathes = List.generate(3, (idx) => "");
  List<String> get recordPathes => _recordPathes;


  MysViewModel() {}

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
}
