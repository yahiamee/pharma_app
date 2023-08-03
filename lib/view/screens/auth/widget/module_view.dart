import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
class ModuleViewWidget extends StatelessWidget {
  const ModuleViewWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      List<int> _moduleIndexList = [];
      if(splashController.moduleList != null) {
        for(int index=0; index < splashController.moduleList.length; index++) {
          if(splashController.moduleList[index].moduleType != 'parcel') {
            _moduleIndexList.add(index);
          }
        }
      }
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        Text(
          'select_module'.tr,
          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

        splashController.moduleList != null ? Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 2, blurRadius: 5, offset: Offset(0, 5))],
          ),
          child: DropdownButton<int>(
            value: splashController.selectedModuleIndex,
            items: _moduleIndexList.map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(splashController.moduleList[value].moduleName),
              );
            }).toList(),
            onChanged: (value) {
              splashController.selectModuleIndex(value);
            },
            isExpanded: true,
            underline: SizedBox(),
          ),
        ) : Center(child: Text('not_available_module'.tr)),
      ]);
    });
  }
}