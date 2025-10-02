import 'package:assignment/localization/language_controller.dart';
import 'package:assignment/theme/ThemeController.dart';
import 'package:assignment/widgets/button/circular_back_button.dart';
import 'package:assignment/widgets/button/elevated_button.dart';
import 'package:assignment/widgets/container/country_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Languageselection extends GetView<LanguageController> {
  const Languageselection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

    return Obx(() {
      theme.updateSystemUI();

      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              SizedBox(
                child: CircularBackButton(onTap: (){
                  controller.navigateToLocation();

                }),
              ),



              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.02.sw),
                child: Text("mother_language".tr,style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.textColor

                ),),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 0.04.sw),
                child: Text("discover_podcast".tr,style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: theme.subTextColor

                ),),
              ),

              SizedBox(height: 0.03.sh),

              // Country List
              GetBuilder<LanguageController>(
                builder: (controller) {
                  return Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 0.04.sw),
                      children: controller.languages.map((language) {
                        final isSelected = controller.selectedLanguage == language["name"];
                        return CountryListItem(
                          flag: language["flag"]!,
                          countryName: language["name"]!,
                          isSelected: isSelected,
                          onTap: () {
                            controller.selectLanguage(language["name"]!);
                          },
                          selectedBackgroundColor: theme.background,
                          selectedBorderColor: theme.iconColor,
                          selectedButtonColor: theme.blue,
                          textColor: theme.textColor,
                          unselectedButtonColor: theme.greyWhite,
                          unselectedBorderColor: theme.subTextColor,
                        );
                      }).toList(),
                    ),
                  );
                },
              ),

              elevatedButton(text: "continue".tr, onTap: (){
                controller.navigateToHome();
              }),


            ],
          ),
        ),
      );
    });
  }



}
