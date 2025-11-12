import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/user_provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/goal_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final transactionProvider = context.watch<TransactionProvider>();
    final goalProvider = context.watch<GoalProvider>();
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      backgroundColor: context.theme.colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${userProvider.userName} 👋',
                style: context.theme.typography.xl3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.theme.colors.foreground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Kelola keuangan Anda dengan mudah',
                style: context.theme.typography.sm.copyWith(
                  color: context.theme.colors.mutedForeground,
                ),
              ),
              const SizedBox(height: 24),
              
              FCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Saldo',
                        style: context.theme.typography.sm.copyWith(
                          color: context.theme.colors.mutedForeground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currencyFormat.format(transactionProvider.totalBalance),
                        style: context.theme.typography.xl4.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.theme.colors.foreground,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_downward,
                                      size: 16,
                                      color: context.theme.colors.mutedForeground,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Pemasukan',
                                      style: context.theme.typography.xs.copyWith(
                                        color: context.theme.colors.mutedForeground,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  currencyFormat.format(transactionProvider.monthlyIncome),
                                  style: context.theme.typography.lg.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.colors.foreground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      size: 16,
                                      color: context.theme.colors.mutedForeground,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Pengeluaran',
                                      style: context.theme.typography.xs.copyWith(
                                        color: context.theme.colors.mutedForeground,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  currencyFormat.format(transactionProvider.monthlyExpense),
                                  style: context.theme.typography.lg.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.colors.foreground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              Text(
                'Statistik Bulan Ini',
                style: context.theme.typography.lg.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.colors.foreground,
                ),
              ),
              const SizedBox(height: 12),
              
              FCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 200,
                    child: transactionProvider.expenseByCategory.isEmpty
                        ? Center(
                            child: Text(
                              'Belum ada data pengeluaran',
                              style: context.theme.typography.sm.copyWith(
                                color: context.theme.colors.mutedForeground,
                              ),
                            ),
                          )
                        : PieChart(
                            PieChartData(
                              sections: _buildPieChartSections(
                                transactionProvider.expenseByCategory,
                                context,
                              ),
                              sectionsSpace: 2,
                              centerSpaceRadius: 40,
                              borderData: FlBorderData(show: false),
                            ),
                          ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              Text(
                'Target Tabungan',
                style: context.theme.typography.lg.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.colors.foreground,
                ),
              ),
              const SizedBox(height: 12),
              
              if (goalProvider.activeGoals.isEmpty)
                FCard(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'Belum ada target tabungan',
                        style: context.theme.typography.sm.copyWith(
                          color: context.theme.colors.mutedForeground,
                        ),
                      ),
                    ),
                  ),
                )
              else
                ...goalProvider.activeGoals.take(3).map((goal) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: FCard(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  goal.name,
                                  style: context.theme.typography.base.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.colors.foreground,
                                  ),
                                ),
                                Text(
                                  '${(goal.progress * 100).toStringAsFixed(0)}%',
                                  style: context.theme.typography.sm.copyWith(
                                    color: context.theme.colors.mutedForeground,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: goal.progress,
                                backgroundColor: context.theme.colors.muted,
                                valueColor: AlwaysStoppedAnimation(
                                  context.theme.colors.primary,
                                ),
                                minHeight: 8,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  currencyFormat.format(goal.currentAmount),
                                  style: context.theme.typography.sm.copyWith(
                                    color: context.theme.colors.foreground,
                                  ),
                                ),
                                Text(
                                  currencyFormat.format(goal.targetAmount),
                                  style: context.theme.typography.sm.copyWith(
                                    color: context.theme.colors.mutedForeground,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
    Map<dynamic, double> data,
    BuildContext context,
  ) {
    final total = data.values.fold<double>(0, (sum, value) => sum + value);
    final colors = _generateGrayscaleColors(data.length);
    
    int index = 0;
    return data.entries.map((entry) {
      final percentage = (entry.value / total * 100).toStringAsFixed(0);
      final color = colors[index % colors.length];
      index++;
      
      return PieChartSectionData(
        value: entry.value,
        title: '$percentage%',
        color: color,
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
        ),
      );
    }).toList();
  }

  List<Color> _generateGrayscaleColors(int count) {
    return List.generate(count, (index) {
      final brightness = 0.2 + (0.6 * index / count);
      return Color.lerp(Colors.black, Colors.white, brightness)!;
    });
  }
}
