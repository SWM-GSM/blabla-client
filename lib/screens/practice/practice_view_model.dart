import 'package:blabla/models/content.dart';
import 'package:blabla/models/content_feedback.dart';
import 'package:blabla/models/video.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum ContentLangType {
  ko("Korean"),
  en("English");

  const ContentLangType(this.fullKey);
  final String fullKey;
}

class PracticeViewModel with ChangeNotifier {
  final api = API();
  static const storage = FlutterSecureStorage();

  /* 컨텐츠 리스트 */
  ContentLangType _contentLangType = ContentLangType.ko;
  ContentLangType get contentLangType => _contentLangType;

  List<Content> _contentList = [];
  List<Content> get contentList => _contentList;

  int _contentIdx = 0;
  int get contentIdx => _contentIdx;

  /* 영상 리스트 */
  ContentDetail? _videoList;
  ContentDetail? get videoList => _videoList;

  /* 컨텐츠 진입 후 */
  int _videoId = 0;
  VideoDetail? _video;
  ContentFeedback? _feedback;

  VideoDetail? get video => _video;
  ContentFeedback? get feedback => _feedback;

  /* 스피킹 */
  final List<String> _recordPathes = List.generate(3, (idx) => "");
  List<String> get recordPathes => _recordPathes;

  PracticeViewModel() {
    getContentList();
  }

  void changeContentLangType(bool isLeft) {
    if (isLeft) {
      if (_contentLangType.index != 0) {
        _contentLangType = ContentLangType.values[_contentLangType.index - 1];
        _contentList.clear();
        _contentIdx = 0;
        getContentList();
      }
    } else {
      if (_contentLangType.index < (ContentLangType.values.length - 1)) {
        _contentLangType = ContentLangType.values[_contentLangType.index + 1];
        _contentList.clear();
        _contentIdx = 0;
        getContentList();
      }
    }

    notifyListeners();
  }

  void getContentList() async {
    _contentList = await api.getContentList(_contentLangType);
    notifyListeners();
  }

  void setContentIdx(int idx) {
    _contentIdx = idx;
    notifyListeners();
  }

  void initVideoList() {
    _videoList = null;
    notifyListeners();
  }

  void getVideoList(int id) async {
    _videoList = await api.getVideoList(id);
    notifyListeners();
  }

  void initVideo() async {
    _videoId = 0;
    _video = null;
    notifyListeners();
  }

  void getVideo(int id) async {
    _videoId = id;
    _video = await api.getVideo(id);
    notifyListeners();
  }

  Future<void> getFeedback(String userAnswer) async {
    _feedback = await api.postContentFeedback(_videoId, userAnswer);
    notifyListeners();
  }

  void setRecordPath(int idx, String path) {
    _recordPathes[idx] = path;
    notifyListeners();
  }

  Future<bool> uploadRecords() async {
    final result = await api.uploadRecords(_videoId, _recordPathes);
    return result;
  }
}
