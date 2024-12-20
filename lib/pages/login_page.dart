import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yous_app/pages/first_page.dart';
import 'package:yous_app/pages/home_page.dart';
import 'package:yous_app/pages/register_page.dart';
import 'package:yous_app/states/app_colors.dart';
import 'package:yous_app/states/auth_controller.dart';
import 'package:yous_app/util/constants.dart';
import 'package:yous_app/widgets/custom_dialog.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  final String? Checkorder;
  final Function()? closeScreen;

  const LoginPage({Key? key, this.Checkorder, this.closeScreen})
      : super(key: key);
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? _rememberMe = false;
  AppColors appColors = AppColors();
  TextEditingController phomeC = TextEditingController();
  TextEditingController PasswordC = TextEditingController();
  AuthController authController = Get.put(AuthController());

  void initState() {
    super.initState();
    print(widget.Checkorder);
  }

  @override
  Widget _buildPhoneTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'phone'.tr,
          style: TextStyle(
              color: appColors.grey1,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            keyboardType: TextInputType.phone,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            onChanged: (value) {
              // Print the entered data whenever it changes
              // print('Entered phone number: $value');
            },
            controller: phomeC,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Color.fromARGB(255, 62, 62, 62),
              ),
              hintText: '20 xxx xxx',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'password'.tr,
          style: TextStyle(
              color: appColors.grey1,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            controller: PasswordC,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 12.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Color.fromARGB(255, 62, 62, 62),
              ),
              hintText: 'password'.tr,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        child: Text(
          'forgot_password'.tr,
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: appColors.mainColor,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'remeber'.tr,
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5.0,
            padding: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: appColors.mainColor),
        onPressed: () {
          if (phomeC.text.trim().isEmpty || PasswordC.text.trim().isEmpty) {
            CustomDialog().dialogShowMessage(
              context,
              message: 'please_enter_all_field'.tr,
            );
          } else {
            authController.login(
                phone: phomeC.text,
                password: PasswordC.text,
                checkorder: widget.Checkorder);
          }
        },
        child: Text(
          'login'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'no_account_yet'.tr,
              style: TextStyle(
                color: appColors.grey1,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'register'.tr,
              style: TextStyle(
                color: appColors.mainColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainColor,
      appBar: AppBar(
          backgroundColor: appColors.mainColor,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: appColors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => FirstPage(),
              //   ),
              // );
            },
          ),
          title: Text(
            'login'.tr,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      body: Container(
       
        decoration: BoxDecoration(
          color: appColors.backgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
        ),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 30.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset('assets/images/logo1.png')),
                        ),
                        SizedBox(height: 10.0),
                        _buildPhoneTF(),
                        SizedBox(
                          height: 10.0,
                        ),
                        _buildPasswordTF(),
                        _buildForgotPasswordBtn(),
                        _buildRememberMeCheckbox(),
                        _buildLoginBtn(),
                        _buildSignupBtn(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
