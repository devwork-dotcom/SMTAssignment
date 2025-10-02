import 'package:assignment/app/modules/home/HomeController.dart';
import 'package:assignment/theme/ThemeController.dart';
import 'package:assignment/widgets/input/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Home extends GetView<HomeController> {
   Home({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

    return Obx(() {
      theme.updateSystemUI();

      return Scaffold(
        backgroundColor: theme.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: theme.background,
          elevation: 0,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              color: theme.offGreyWhite,
              height: 1.0,
            ),
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Home",
              style: TextStyle(
                fontSize: 20,
                color: theme.textColorPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            Row(
              children: [
                Switch(
                  value: theme.isDark.value,
                  onChanged: (val) => theme.toggleTheme(),
                  activeColor: theme.blue,
                ),
                SizedBox(width: 10.w),
                Icon(
                  theme.isDark.value ? Icons.nights_stay : Icons.wb_sunny,
                  color: theme.blue,
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(width: 20.w),
          ],
        ),
        body: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(color: theme.blue),
              );
            }

            if (controller.error.value.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${controller.error.value}',
                      style: TextStyle(
                        color: theme.textColorPrimary,
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: controller.refreshData,
                      style: ElevatedButton.styleFrom(backgroundColor: theme.blue),
                      child: Text('Retry', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                // Search Field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: CustomTextField(
                    controller: searchController,
                    title: "Search",
                    hint: "Search...",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) => controller.searchObjects(value),
                    onSubmitted: (value) => controller.searchObjects(value),

                  ),
                ),

                // All Objects List
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: controller.filteredObjects.length,
                    itemBuilder: (context, index) {
                      final obj = controller.filteredObjects[index];
                      final data = obj['data'];
                      final hasData = data != null && data is Map;
                      final dataCount = hasData ? data.keys.length : 0;

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5.h),
                        decoration: BoxDecoration(
                          color: theme.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: theme.offGreyWhite),
                        ),
                        child: ListTile(
                          title: Text(
                            obj['name'] ?? 'No Name',
                            style: TextStyle(
                              color: theme.textColorPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ID: ${obj['id']}',
                                style: TextStyle(color: theme.textColor),
                              ),
                              if (hasData && dataCount > 0) ...[
                                SizedBox(height: 4.h),
                                Text(
                                  'Data Fields: $dataCount',
                                  style: TextStyle(color: theme.blue, fontSize: 12.sp),
                                ),
                                ...data.entries.map((entry) => Text(
                                  ' ${entry.key}: ${entry.value}',
                                  style: TextStyle(color: theme.textColor, fontSize: 11.sp),
                                )),
                              ] else if (!hasData) ...[
                                SizedBox(height: 4.h),
                                Text(
                                  'No Data',
                                  style: TextStyle(
                                    color: theme.red,
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: theme.blue,
                            size: 16.w,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      );
    });
  }
}
