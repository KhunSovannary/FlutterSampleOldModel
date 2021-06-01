import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chabhuoy/constants/app.dart';
import 'package:flutter_chabhuoy/repository/auth_repository.dart';
import 'package:flutter_chabhuoy/screens/forget_password_screen.dart';
import 'package:flutter_chabhuoy/screens/register_screen.dart';
import 'package:flutter_chabhuoy/services/notification_service.dart';
import 'package:flutter_chabhuoy/widgets/custom_button_widget.dart';
import 'package:flutter_chabhuoy/widgets/custom_textfield_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String fcmToken = '';
  String deviceType = Platform.isIOS ? 'ios' : 'android';

  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fcmToken = notificationService.getFCMToken;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authenticate = Provider.of<AuthRepository>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Image.asset('images/logo.png')),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.06,
              ),
              CustomTextFieldWidget(
                title: AppLocalizations.of(context).phone,
                iconData: Icons.phone_android,
                obscureText: false,
                numberOnly: true,
                textEditingController: _phoneController,
              ),
              CustomTextFieldWidget(
                title: AppLocalizations.of(context).password,
                iconData: Icons.lock,
                obscureText: true,
                numberOnly: false,
                textEditingController: _passwordController,
              ),
              CustomButtonWidget(
                  title: AppLocalizations.of(context).signIn,
                  function: () {
                    App().showLoading(context);
                    authenticate
                        .login(_phoneController.text, _passwordController.text,
                            fcmToken, deviceType)
                        .then((response) => {
                              Navigator.pop(context),
                              if (!response.status)
                                {
                                  App().showMessageDialog(
                                      context: context,
                                      title: 'Login Failed',
                                      message: response.msg,
                                      icon: Icons.warning),
                                }
                              else
                                {
                                  authenticate.setUser(response.data),
                                  Navigator.pop(context),
                                }
                            });
                  }),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgetPasswordScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    AppLocalizations.of(context).forgetPassword,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).dontHaveAnAccount,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context).signUp,
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
