import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
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
          Text('Doanh số hàng tuần',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: SHFSizes.spaceBtwSections),

          // Biểu đồ
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
                            top: BorderSide.none, // Loại bỏ đường viền trên
                            right:
                                BorderSide.none, // Loại bỏ đường viền bên phải
                          ),
                        ),
                        gridData: const FlGridData(
                          show: true,
                          drawHorizontalLine: true,
                          drawVerticalLine: false, // Loại bỏ đường dọc
                          horizontalInterval: 200, // Đặt khoảng cách mong muốn
                        ),
                        barGroups: List.generate(7, (index) {
                          final dayIndex = index % 7; // Đảm bảo chỉ mục vòng quanh cho ngày đúng
                          final value = controller.weeklySales[dayIndex]; // Lấy giá trị doanh số tương ứng

                          return BarChartGroupData(
                            x: dayIndex,
                            barRods: [
                              BarChartRodData(
                                width: 30,
                                toY: value,
                                color: SHFColors.primary,
                                borderRadius: BorderRadius.circular(SHFSizes.sm),
                              ),
                            ],
                          );
                        }),
                        groupsSpace: SHFSizes.spaceBtwItems,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                              getTooltipColor: (_) => SHFColors.secondary),
                          touchCallback: SHFDeviceUtils.isDesktopScreen(context)
                              ? (barTouchEvent, barTouchResponse) {}
                              : null,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 400,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [SHFLoaderAnimation()])),
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
            // Ánh xạ chỉ mục thành ngày trong tuần mong muốn
            final days = [
              'Thứ 2',
              'Thứ 3',
              'Thứ 4',
              'Thứ 5',
              'Thứ 6',
              'Thứ 7',
              'Chủ Nhật'
            ];

            // Tính chỉ mục và đảm bảo nó vòng quanh cho ngày đúng
            final index = value.toInt() % days.length;

            // Lấy ngày tương ứng với chỉ mục tính toán
            final day = days[index];

            // Trả về một widget tùy chỉnh với tên ngày đầy đủ
            return SideTitleWidget(
              space: 0,
              axisSide: AxisSide.bottom,
              child: Text(day),
            );
          },
        ),
      ),
      leftTitles: const AxisTitles(
          sideTitles:
              SideTitles(showTitles: true, interval: 200, reservedSize: 50)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
