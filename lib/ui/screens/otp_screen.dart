import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_flutter/global_components/styles/text_styles.dart';
import 'package:login_flutter/global_components/themes/themes.dart';
import 'package:login_flutter/global_components/widgets/widgets.dart';
import 'package:login_flutter/ui/screens/landing_screen.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

@override
class _OTPScreenState extends State<OTPScreen> {
  var h, w;
  var dialCode, mobile, otp, otpError = false;

  late Timer _timer;
  late Timer t;
  int _start = 60;

  final CustomWidgets _widgets = CustomWidgets();

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    mobile = '9988771234';
    setState(() {});
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(
            () {
              _start--;
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    t.cancel();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(left: w * 0.02, right: w * 0.02, top: h * 0.02),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: CustomThemes.colorGrey, width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: IconButton(
                        iconSize: 16,
                        icon: const Padding(
                          padding: EdgeInsets.only(left: 2),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: CustomThemes.colorBlack,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: h * 0.14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Authenticating..',
                      style: CustomTextStyles.headText
                          .copyWith(color: CustomThemes.colorRed)),
                ],
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Text(
                'Please key in activation code sent to\n$mobile',
                style: CustomTextStyles.normalText,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: h * 0.04,
              ),
              SizedBox(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OTPTextField(
                      length: 6,
                      width: w * 0.9,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: w * 0.12,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 12,
                      style: CustomTextStyles.normalText,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        otp = value;
                        setState(() {});
                      },
                      onCompleted: (value) {
                        otp = value;
                        otpError = false;
                        setState(
                          () {
                            startTimer();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              otpError
                  ? SizedBox(
                      height: 12,
                    )
                  : Container(),
              otpError
                  ? _widgets.errorWidget(text: 'Please enter a valid OTP')
                  : Container(),
              SizedBox(
                height: h * 0.05,
              ),
              if (_start != 0 && otp != null && _start != 61)
                Text(
                  'Resend a new Code in 0:$_start\nif you didn\'t receive your activation code',
                  style: CustomTextStyles.normalText,
                  textAlign: TextAlign.center,
                )
              else
                Container(),
              _start == 0
                  ? SizedBox(
                      height: h * 0.02,
                    )
                  : Container(),
              _start == 0
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          otp = '';
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Resend Code',
                            style: CustomTextStyles.normalText,
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          const Icon(
                            Icons.send,
                            size: 16,
                          ),
                        ],
                      ),
                    )
                  : Container(),
              ////////
              SizedBox(
                height: h * 0.16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _widgets.button(
                    h: h,
                    w: w,
                    isActive:
                        otp == null || otp.toString().length < 6 ? false : true,
                    onTap: () {
                      if (otp == null || otp.toString().length < 6) {
                        otpError = true;
                      }
                      setState(() {});
                      if (otpError == false) {
                        _widgets.snackBar(
                            context: context,
                            isError: false,
                            text: 'OTP verification success',
                        duration: 1);
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LandingScreen()),
                          );
                        });
                      } else if (otp.toString().length < 6 && otp != null) {
                        _widgets.snackBar(
                            context: context,
                            isError: true,
                            text: 'Invalid OTP');
                      }
                    },
                    title: 'Continue',
                  ),
                ],
              ),
              SizedBox(height: h * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  bool showTimerCount() {
    if (_start < 55) {}
    return true;
  }
}
