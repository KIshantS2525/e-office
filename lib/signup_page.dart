import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'center_widget.dart';  // Make sure to import your CenterWidget here

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _adminSignupKey = GlobalKey<FormState>();
  final _userSignupKey = GlobalKey<FormState>();
  String _adminEmail = '';
  String _adminPassword = '';
  String _adminConfirmPassword = '';
  String _userEmail = '';
  String _userPassword = '';
  String _userConfirmPassword = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _signupAsAdmin() {
    if (_adminSignupKey.currentState!.validate()) {
      _adminSignupKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Admin signup successful!')));
    }
  }

  void _signupAsUser() {
    if (_userSignupKey.currentState!.validate()) {
      _userSignupKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User signup successful!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Admin'),
            Tab(text: 'User'),
          ],
        ),
      ),
      body: Stack(
        children: [
          CenterWidget(size: MediaQuery.of(context).size),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 50,
              width: double.infinity,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAdminSignup(),
                  _buildUserSignup(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminSignup() {
    return Form(
      key: _adminSignupKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInUp(
              duration: Duration(milliseconds: 1200),
              child: _makeInput(
                label: "Email",
                onSaved: (value) => _adminEmail = value!,
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 1300),
              child: _makeInput(
                label: "Password",
                obscureText: true,
                onSaved: (value) => _adminPassword = value!,
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 1400),
              child: _makeInput(
                label: "Confirm Password",
                obscureText: true,
                onSaved: (value) => _adminConfirmPassword = value!,
              ),
            ),
            SizedBox(height: 20),
            FadeInUp(
              duration: Duration(milliseconds: 1500),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: _signupAsAdmin,
                color: Colors.greenAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text("Sign up", style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserSignup() {
    return Form(
      key: _userSignupKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInUp(
              duration: Duration(milliseconds: 1200),
              child: _makeInput(
                label: "Email",
                onSaved: (value) => _userEmail = value!,
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 1300),
              child: _makeInput(
                label: "Password",
                obscureText: true,
                onSaved: (value) => _userPassword = value!,
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 1400),
              child: _makeInput(
                label: "Confirm Password",
                obscureText: true,
                onSaved: (value) => _userConfirmPassword = value!,
              ),
            ),
            SizedBox(height: 20),
            FadeInUp(
              duration: Duration(milliseconds: 1500),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: _signupAsUser,
                color: Colors.greenAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text("Sign up", style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _makeInput({
    required String label,
    bool obscureText = false,
    required void Function(String?) onSaved,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        )),
        SizedBox(height: 5),
        TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            if (label == "Confirm Password" && value != _adminPassword && value != _userPassword) {
              return 'Passwords do not match';
            }
            return null;
          },
          onSaved: onSaved,
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
