import 'dart:async';

import 'package:esmabatu/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({super.key});

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  final controller = Get.find<MainController>();

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(milliseconds: 1000),
      (Timer t) => controller.calculateRemainingTime(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CountdownCard(label: 'Gün', value: controller.remTimeDays),
        CountdownCard(label: 'Saat', value: controller.remTimeHours),
        CountdownCard(label: 'Dakika', value: controller.remTimeMinutes),
        CountdownCard(label: 'Saniye', value: controller.remTimeSeconds),
      ],
    );
  }
}

class CountdownCard extends StatelessWidget {
  final String label;
  final RxInt value;

  const CountdownCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Text(
                value.value.toString(),
                style: TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.w500,
                  // color: Colors.black87,
                  color: Colors.blueGrey[900],
                ),
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              label,
              style: GoogleFonts.quicksand(
                fontSize: 16.0,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
