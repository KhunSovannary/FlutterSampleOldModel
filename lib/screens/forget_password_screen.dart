import 'package:flutter/material.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/repository/otp_code_repository.dart';
import 'package:flutter_chabhuoy/screens/get_otp_screen.dart';
import 'package:flutter_chabhuoy/widgets/custom_button_widget.dart';
import 'package:flutter_chabhuoy/widgets/custom_textfield_widget.dart';
import 'package:flutter_chabhuoy/widgets/logo_image_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final App myApp = App();
  final OtpCodeRepository optCodeRepository = OtpCodeRepository();

  final TextEditingController textEditingControllerPhone =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingControllerPhone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: IconThemeData(
          color: Colors.orange, //change your color here
        ),
        title: Text(AppLocalizations.of(context).forgetPassword, style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: LogoImageWidget()),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Forgot your password?',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Center(
                      child: Text(
                          'Enter your phone number to reset your password')),
                ),
                CustomTextFieldWidget(
                    title: 'Phone',
                    iconData: Icons.lock,
                    obscureText: false,
                    numberOnly: true,
                    onChanged: null,
                    textEditingController: textEditingControllerPhone),
                Container(
                  margin: const EdgeInsets.only(bottom: 200),
                  child: CustomButtonWidget(
                      title: 'Reset Password',
                      function: () => {
                            myApp.showLoading(context),
                            optCodeRepository
                                .getOtpForgetPassword(
                                    phone: textEditingControllerPhone.text)
                                .then((response) => {
                                      Navigator.pop(context),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OTPScreen(
                                                  phone:
                                                      textEditingControllerPhone
                                                          .text,
                                                  requestId: response.data,
                                                )),
                                      )
//                      if (!response.status) {
//                        myApp.showMessageDialog(context: context, title: 'Oop', message: response.msg)
//                      } else {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context) => OTPScreen()),
//                        )
//                      }
                                    })
                          }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
