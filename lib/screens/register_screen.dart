import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/repository/otp_code_repository.dart';
import 'package:flutter_chabhuoy/screens/get_otp_screen.dart';
import 'package:flutter_chabhuoy/widgets/custom_button_widget.dart';
import 'package:flutter_chabhuoy/widgets/custom_textfield_widget.dart';
import 'package:flutter_chabhuoy/widgets/logo_image_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final App myApp = App();
  final OtpCodeRepository otpCodeRepository = OtpCodeRepository();

  TextEditingController fullNameTextEditController = TextEditingController();
  TextEditingController phoneTextEditController = TextEditingController();
  TextEditingController passwordTextEditController = TextEditingController();
  TextEditingController cfPasswordTextEditController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
        title: Text('Sign Up', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: LogoImageWidget()),
              SizedBox(
                height: 10,
              ),
              CustomTextFieldWidget(
                title: AppLocalizations.of(context).name,
                iconData: Icons.person,
                obscureText: false,
                numberOnly: false,
                textEditingController: fullNameTextEditController,
              ),
              CustomTextFieldWidget(
                title: AppLocalizations.of(context).phone,
                iconData: Icons.phone_android,
                obscureText: false,
                numberOnly: true,
                textEditingController: phoneTextEditController,
              ),
              CustomTextFieldWidget(
                title: AppLocalizations.of(context).password,
                iconData: Icons.lock,
                obscureText: true,
                numberOnly: false,
                textEditingController: passwordTextEditController,
              ),
              CustomTextFieldWidget(
                title: AppLocalizations.of(context).cfPassword,
                iconData: Icons.lock,
                obscureText: true,
                numberOnly: false,
                textEditingController: cfPasswordTextEditController,
              ),
              CustomButtonWidget(
                  title: AppLocalizations.of(context).signUp,
                  function: () => {
                        if (fullNameTextEditController.text == '' ||
                            fullNameTextEditController.text.length < 3)
                          {
                            myApp.showMessageDialog(
                                context: context,
                                message: 'Please enter your name')
                          }
                        else if (phoneTextEditController.text == '' ||
                            phoneTextEditController.text.length < 7)
                          {
                            myApp.showMessageDialog(
                                context: context,
                                message: 'Invalid Phone number')
                          }
                        else if (passwordTextEditController.text == '' ||
                            passwordTextEditController.text !=
                                cfPasswordTextEditController.text)
                          {
                            myApp.showMessageDialog(
                                context: context,
                                message:
                                    'Password is incorrect. Please check again!')
                          }
                        else
                          {
                            myApp.showLoading(context),
                            otpCodeRepository
                                .getOtpCode(phone: phoneTextEditController.text)
                                .then((response) => {
                                      if (!response.status)
                                        {
                                          Navigator.pop(context),
                                          myApp.showMessageDialog(
                                              context: context,
                                              message: response.msg,
                                              icon: Icons.warning)
                                        }
                                      else
                                        {
                                          Navigator.pop(context),
                                          Navigator.pop(context),
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => OTPScreen(
                                                      phone:
                                                          phoneTextEditController
                                                              .text,
                                                      fullName:
                                                          fullNameTextEditController
                                                              .text,
                                                      password:
                                                          passwordTextEditController
                                                              .text,
                                                      requestId:
                                                          response.data)))
                                        }
                                    })
                          }
                      })
            ],
          ),
        ),
      ),
    );
  }
}
