import 'package:blabla/models/crew.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';

class CrewViewModel with ChangeNotifier {
  final api = API();

  bool _isLoading = true;
  List<Crew> _crewList = [];
  int _crewId = 0;
  CrewDetail? _crew;

  bool get isLoading => _isLoading;
  List<Crew> get crewList => _crewList;
  int get crewId => _crewId;
  CrewDetail? get crew => _crew;

  CrewViewModel() {
    init();
  }

  void init() async {
    await Future.wait([
      getCrews(),
    ]);
    _isLoading = false;
  }

  Future<void> getCrews() async {
    _crewList = await api.getCrews();
    notifyListeners();
  }

  Future<void> getCrewDetail(int crewId) async {
    _crewId = crewId;
    _crew = await api.getCrewDetail(crewId);
    notifyListeners();
  }

  Future<bool> joinCrew(bool autoApproval, {String msg = ""}) async {
    return await api.joinCrew(crewId, autoApproval, msg: msg);
  }
}
