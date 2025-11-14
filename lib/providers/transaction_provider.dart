import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/storage_service.dart';

class TransactionProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  List<Transaction> _transactions = [];
  bool _isLoading = false;

  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;

  double get totalBalance {
    double income = _transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0, (sum, t) => sum + t.amount);
    double expense = _transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0, (sum, t) => sum + t.amount);
    return income - expense;
  }

  double get monthlyIncome {
    final now = DateTime.now();
    return _transactions
        .where((t) =>
            t.type == TransactionType.income &&
            t.date.month == now.month &&
            t.date.year == now.year)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double get monthlyExpense {
    final now = DateTime.now();
    return _transactions
        .where((t) =>
            t.type == TransactionType.expense &&
            t.date.month == now.month &&
            t.date.year == now.year)
        .fold(0, (sum, t) => sum + t.amount);
  }

  Map<TransactionCategory, double> get expenseByCategory {
    final now = DateTime.now();
    final expenses = _transactions.where((t) => 
        t.type == TransactionType.expense &&
        t.date.month == now.month &&
        t.date.year == now.year);
    final Map<TransactionCategory, double> result = {};
    
    for (var transaction in expenses) {
      result[transaction.category] = 
          (result[transaction.category] ?? 0) + transaction.amount;
    }
    
    return result;
  }

  Map<TransactionCategory, double> get incomeByCategory {
    final now = DateTime.now();
    final incomes = _transactions.where((t) => 
        t.type == TransactionType.income &&
        t.date.month == now.month &&
        t.date.year == now.year);
    final Map<TransactionCategory, double> result = {};
    
    for (var transaction in incomes) {
      result[transaction.category] = 
          (result[transaction.category] ?? 0) + transaction.amount;
    }
    
    return result;
  }

  Future<void> loadTransactions() async {
    _isLoading = true;
    notifyListeners();
    
    _transactions = await _storageService.getTransactions();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await _storageService.saveTransaction(transaction);
    _transactions.add(transaction);
    _transactions.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _storageService.saveTransaction(transaction);
    final index = _transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      _transactions[index] = transaction;
      _transactions.sort((a, b) => b.date.compareTo(a.date));
      notifyListeners();
    }
  }

  Future<void> deleteTransaction(String id) async {
    await _storageService.deleteTransaction(id);
    _transactions.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  List<Transaction> getTransactionsByDateRange(DateTime start, DateTime end) {
    return _transactions
        .where((t) => t.date.isAfter(start) && t.date.isBefore(end))
        .toList();
  }

  List<Transaction> getTransactionsByCategory(TransactionCategory category) {
    return _transactions.where((t) => t.category == category).toList();
  }
}
