import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_flutter/global_components/styles/text_styles.dart';
import 'package:login_flutter/global_components/themes/themes.dart';

class CustomWidgets {
  Widget errorWidget({text}) {
    return Text(
      '$text',
      style: CustomTextStyles.normalText.copyWith(color: CustomThemes.colorRed),
    );
  }

  Widget button({
    h,
    w,
    onTap,
    title,
    required isActive,
  }) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 46,
          width: w * 0.8,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive == true
                ? CustomThemes.colorRed
                : CustomThemes.colorGrey,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(50),
              right: Radius.circular(50),
            ),
          ),
          child: Text(title,
              style: CustomTextStyles.subHeadText
                  .copyWith(color: CustomThemes.colorWhite)),
        ),
      ),
    );
  }

  snackBar({@required context, text, @required isError, duration}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor:
      isError ?  CustomThemes.colorRed
      : CustomThemes.colorGreen,
      content: Text('$text'),
      duration: Duration(seconds:  duration ?? 2),
    ));
  }
}
