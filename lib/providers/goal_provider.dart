import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../services/storage_service.dart';

class GoalProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  List<Goal> _goals = [];
  bool _isLoading = false;

  List<Goal> get goals => _goals;
  bool get isLoading => _isLoading;

  List<Goal> get activeGoals => _goals.where((g) => !g.isCompleted).toList();
  List<Goal> get completedGoals => _goals.where((g) => g.isCompleted).toList();

  double get totalTargetAmount => _goals.fold(0, (sum, g) => sum + g.targetAmount);
  double get totalSavedAmount => _goals.fold(0, (sum, g) => sum + g.currentAmount);

  Future<void> loadGoals() async {
    _isLoading = true;
    notifyListeners();
    
    _goals = await _storageService.getGoals();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addGoal(Goal goal) async {
    await _storageService.saveGoal(goal);
    _goals.add(goal);
    _goals.sort((a, b) => a.deadline.compareTo(b.deadline));
    notifyListeners();
  }

  Future<void> updateGoal(Goal goal) async {
    await _storageService.saveGoal(goal);
    final index = _goals.indexWhere((g) => g.id == goal.id);
    if (index != -1) {
      _goals[index] = goal;
      _goals.sort((a, b) => a.deadline.compareTo(b.deadline));
      notifyListeners();
    }
  }

  Future<void> deleteGoal(String id) async {
    await _storageService.deleteGoal(id);
    _goals.removeWhere((g) => g.id == id);
    notifyListeners();
  }

  Future<void> addAmountToGoal(String id, double amount) async {
    final index = _goals.indexWhere((g) => g.id == id);
    if (index != -1) {
      final goal = _goals[index];
      final updatedGoal = goal.copyWith(
        currentAmount: goal.currentAmount + amount,
      );
      await updateGoal(updatedGoal);
    }
  }
}
