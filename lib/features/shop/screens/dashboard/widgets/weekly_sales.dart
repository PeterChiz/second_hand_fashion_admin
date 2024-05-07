
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';

class SHFWeeklySalesGraph extends StatelessWidget {
  const SHFWeeklySalesGraph({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return SHFRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Weekly Sales', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: SHFSizes.spaceBtwSections),

          // Graph
          Obx(
            () => controller.weeklySales.isNotEmpty
                ? SizedBox(
                    height: 400,
                    child: BarChart(
                      BarChartData(
                        titlesData: buildFlTitlesData(),
                        borderData: FlBorderData(
                          show: true,
                          border: const Border(
                            top: BorderSide.none, // Remove top border
                            right: BorderSide.none, // Remove right border
                          ),
                        ),
                        gridData: const FlGridData(
                          show: true,
                          drawHorizontalLine: true,
                          drawVerticalLine: false, // Remove vertical lines
                          horizontalInterval: 200, // Set your desired interval
                        ),
                        barGroups: controller.weeklySales
                            .asMap()
                            .entries
                            .map(
                              (entry) => BarChartGroupData(
                                x: entry.key,
                                barRods: [
                                  BarChartRodData(
                                      width: 30, toY: entry.value, color: SHFColors.primary, borderRadius: BorderRadius.circular(SHFSizes.sm)),
                                ],
                              ),
                            )
                            .toList(),
                        groupsSpace: SHFSizes.spaceBtwItems,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(getTooltipColor: (_) => SHFColors.secondary),
                          touchCallback: SHFDeviceUtils.isDesktopScreen(context) ? (barTouchEvent, barTouchResponse) {} : null,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(height: 400, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [SHFLoaderAnimation()])),
          ),
        ],
      ),
    );
  }

  FlTitlesData buildFlTitlesData() {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            // Map index to the desired day of the week
            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

            // Calculate the index and ensure it wraps around for the correct day
            final index = value.toInt() % days.length;

            // Get the day corresponding to the calculated index
            final day = days[index];

            // Return a custom widget with the full day name
            return SideTitleWidget(
              space: 0,
              axisSide: AxisSide.bottom,
              child: Text(day),
            );
          },
        ),
      ),
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, interval: 200, reservedSize: 50)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
