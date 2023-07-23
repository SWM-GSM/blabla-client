import 'package:blabla/models/crew.dart';
import 'package:blabla/services/apis/api.dart';
import 'package:flutter/material.dart';

class CrewViewModel with ChangeNotifier {
  final api = API();

  bool _isLoading = true;
  List<Crew> _crewList =[];

  bool get isLoading => _isLoading;
  List<Crew> get crewList => _crewList; 

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
}