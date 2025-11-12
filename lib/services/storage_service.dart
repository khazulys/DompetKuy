import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';
import '../models/goal.dart';

class StorageService {
  static const String _transactionsKey = 'transactions';
  static const String _goalsKey = 'goals';

  Future<List<Transaction>> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_transactionsKey);
    
    if (jsonString == null) return [];
    
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Transaction.fromJson(json)).toList();
  }

  Future<void> saveTransaction(Transaction transaction) async {
    final transactions = await getTransactions();
    final index = transactions.indexWhere((t) => t.id == transaction.id);
    
    if (index != -1) {
      transactions[index] = transaction;
    } else {
      transactions.add(transaction);
    }
    
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(transactions.map((t) => t.toJson()).toList());
    await prefs.setString(_transactionsKey, jsonString);
  }

  Future<void> deleteTransaction(String id) async {
    final transactions = await getTransactions();
    transactions.removeWhere((t) => t.id == id);
    
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(transactions.map((t) => t.toJson()).toList());
    await prefs.setString(_transactionsKey, jsonString);
  }

  Future<List<Goal>> getGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_goalsKey);
    
    if (jsonString == null) return [];
    
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Goal.fromJson(json)).toList();
  }

  Future<void> saveGoal(Goal goal) async {
    final goals = await getGoals();
    final index = goals.indexWhere((g) => g.id == goal.id);
    
    if (index != -1) {
      goals[index] = goal;
    } else {
      goals.add(goal);
    }
    
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(goals.map((g) => g.toJson()).toList());
    await prefs.setString(_goalsKey, jsonString);
  }

  Future<void> deleteGoal(String id) async {
    final goals = await getGoals();
    goals.removeWhere((g) => g.id == id);
    
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(goals.map((g) => g.toJson()).toList());
    await prefs.setString(_goalsKey, jsonString);
  }
}
