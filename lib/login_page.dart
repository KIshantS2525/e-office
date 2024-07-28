import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'center_widget.dart';
import 'admin_home_page.dart';  // Import Admin Home Page
import 'user_home_page.dart';  // Import User Home Page

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _adminKey = GlobalKey<FormState>();
  final _userKey = GlobalKey<FormState>();
  String _adminUsername = '';
  String _adminPassword = '';
  String _userUsername = '';
  String _userPassword = '';
  bool _adminPasswordVisible = false;
  bool _userPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _loginAsAdmin() {
    if (_adminKey.currentState!.validate()) {
      _adminKey.currentState!.save();
      if (_adminUsername == 'King' && _adminPassword == 'Ishant') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminHomePage(username : _adminUsername)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid admin credentials')));
      }
    }
  }

  void _loginAsUser() {
    if (_userKey.currentState!.validate()) {
      _userKey.currentState!.save();
      if (_userUsername == 'Ishant' && _userPassword == 'Great') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserHomePage(username : _userUsername)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid user credentials')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          TabBarView(
            controller: _tabController,
            children: [
              _buildAdminLogin(),
              _buildUserLogin(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdminLogin() {
    return Form(
      key: _adminKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInUp(
              duration: Duration(milliseconds: 1000),
              child: _makeInput(
                label: "Username",
                onSaved: (value) => _adminUsername = value!,
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 1200),
              child: _makeInput(
                label: "Password",
                obscureText: !_adminPasswordVisible,
                onSaved: (value) => _adminPassword = value!,
                suffixIcon: IconButton(
                  icon: Icon(
                    _adminPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _adminPasswordVisible = !_adminPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            FadeInUp(
              duration: Duration(milliseconds: 1400),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: _loginAsAdmin,
                color: Colors.greenAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text("Login", style: TextStyle(
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

  Widget _buildUserLogin() {
    return Form(
      key: _userKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInUp(
              duration: Duration(milliseconds: 1000),
              child: _makeInput(
                label: "Username",
                onSaved: (value) => _userUsername = value!,
              ),
            ),
            FadeInUp(
              duration: Duration(milliseconds: 1200),
              child: _makeInput(
                label: "Password",
                obscureText: !_userPasswordVisible,
                onSaved: (value) => _userPassword = value!,
                suffixIcon: IconButton(
                  icon: Icon(
                    _userPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _userPasswordVisible = !_userPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            FadeInUp(
              duration: Duration(milliseconds: 1400),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: _loginAsUser,
                color: Colors.greenAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text("Login", style: TextStyle(
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
    Widget? suffixIcon,
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
            suffixIcon: suffixIcon,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
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
