import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme/ThemeController.dart';

class Blankscreen extends StatelessWidget {
  const Blankscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

    return Obx(() {
      theme.updateSystemUI();

      return Scaffold(
        backgroundColor: theme.background,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Blank Screen",
                  style: TextStyle(fontSize: 20, color: theme.textColorPrimary),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dark Mode",
                    style: TextStyle(color: theme.textColorPrimary, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Switch(
                    value: theme.isDark.value,
                    onChanged: (val) {
                      theme.toggleTheme();
                    },
                    activeColor: theme.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
