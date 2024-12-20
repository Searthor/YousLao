import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yous_app/pages/login_page.dart';
import 'package:yous_app/states/app_colors.dart';
import 'package:yous_app/states/auth_controller.dart';
import 'package:yous_app/util/constants.dart';
import 'package:yous_app/widgets/custom_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AppColors appColors = AppColors();
  TextEditingController nameC = TextEditingController();
  TextEditingController phomeC = TextEditingController();
  TextEditingController PasswordC = TextEditingController();
  TextEditingController comfirmPasswordC = TextEditingController();
  AuthController authController = Get.put(AuthController());
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
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: Text(
          'register'.tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        
        height: double.infinity,
        decoration: BoxDecoration(
          color: appColors.backgroundColor,
          borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10))
        ),
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
              _buildUsernameTF(),
              SizedBox(
                height: 10.0,
              ),
              _buildPhoneTF(),
              SizedBox(
                height: 10.0,
              ),
              _buildPasswordTF(),
                SizedBox(
                height: 10.0,
              ),
              _buildComfirmPasswordTF(),
              _buildSignupBtn(),
                SizedBox(
                height: 10.0,
              ),
              _buildLoginBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'fullname'.tr,
          style: TextStyle(
            color: appColors.grey1,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onChanged: (value) {
              // Print the entered data whenever it changes
              print('Entered name: $value');
            },
            controller: nameC,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 15.0),
              prefixIcon: Icon(
                Icons.person,
                color: Color.fromARGB(255, 62, 62, 62),
              ),
              hintText: 'fullname'.tr,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

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
              print('Entered phone number: $value');
            },
            controller: phomeC,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 15.0),
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
                Icons.key,
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

  Widget _buildComfirmPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'confirm_password'.tr,
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
            controller: comfirmPasswordC,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 12.0),
              prefixIcon: Icon(
                Icons.key,
                color: Color.fromARGB(255, 62, 62, 62),
              ),
              hintText: 'confirm_password'.tr,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupBtn() {
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
          if (phomeC.text.trim().isEmpty ||
              PasswordC.text.trim().isEmpty ||
              comfirmPasswordC.text.trim().isEmpty) {
            CustomDialog().dialogShowMessage(
              context,
              message: 'please_enter_all_field'.tr,
            );
          } else if (PasswordC.text.trim() != comfirmPasswordC.text.trim()) {
            CustomDialog().dialogShowMessage(
              context,
              message: 'password_not_match'.tr,
            );
          } else {
            authController.register(
              phone: phomeC.text,
              password: PasswordC.text,
              comfirmPassword: comfirmPasswordC.text,
              name: nameC.text,
            );
          }
        },
        child: Text(
          'register',
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

  Widget _buildLoginBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'already_have_an_account'.tr,
              style: TextStyle(
                color: appColors.grey1,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'login'.tr,
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
}
