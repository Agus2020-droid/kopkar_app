import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kopkar_japernosa/contents/r.dart';
import 'package:kopkar_japernosa/helpers/preference_helper.dart';
import 'package:kopkar_japernosa/models/network_response.dart';
import 'package:kopkar_japernosa/models/user_login.dart';
import 'package:kopkar_japernosa/repository/auth_api.dart';
import 'package:kopkar_japernosa/views/main_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String route = "login_page";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _telpController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = true;
  String? Function(String?)? validator;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _loginData = {};

  read() async {
    final prefs = await PreferenceHelper().getUserData();
    final token = prefs.token!.token;
    // final key = int.parse(token!);
    print("KEY :");
    print(token);
    if (token != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MainPage()));
      //   } else {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (context) => new LoginPage()));
    }
  }

  _register() async {
    const url = 'https://forms.gle/fsWPWzyyGu72miMK7';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _resetPassword() async {
    const url = 'https://kopkar.japernosa.com/password/reset';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              child: Column(children: [
                SizedBox(height: 80),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  minRadius: 50.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      R.assets.imgLogo,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "KOPERASI KARYAWAN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  "JAYA PERSADA EKONOMI SEJAHTERA",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.amber),
                ),
                Text(
                  "PT. SUMBER GRAHA SEJAHTERA",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black),
                ),
                Text(
                  "CABANG PURBALINGGA",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _telpController,
                        validator: (Value) {
                          if (Value == null || Value.isEmpty) {
                            return 'Nomor HP field is required';
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.phone_android),
                          ),
                          // border: OutlineInputBorder(),
                          labelText: 'Nomor HP',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], //
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        validator: (Value) {
                          if (Value == null || Value.isEmpty) {
                            return 'Password field is required';
                          }
                        },
                        obscureText: _showPassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: _showPassword == false
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                          // border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                      SizedBox(height: 35),
                      ButtonLogin(
                        backgroundColor: R.colors.primary,
                        borderColor: R.colors.primary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset(R.assets.imgGoogle),
                            // Icon(Icons.login),
                            // SizedBox(
                            //   width: 15,
                            // ),
                            Text(
                              // R.strings.loginWithGoogle,
                              "LOGIN",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        // style: ElevatedButton.styleFrom(
                        //   primary: Color(0xff3c8dbc),
                        //   elevation: 0,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(25),
                        //     side: BorderSide(
                        //       color: Color(0xff3c8dbc),
                        //     ),
                        //   ),
                        //   fixedSize:
                        //       Size(MediaQuery.of(context).size.width * 0.8, 50),
                        // ),
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            _loginData['telp'] = _telpController.text;
                            _loginData['password'] = _passwordController.text;
                          }

                          final json = {
                            "telp": _telpController.text,
                            "password": _passwordController.text,
                          };

                          final result = await AuthApi().postLogin(json);
                          // print(result);
                          // print("Status :");
                          print(result.status);

                          if (result.status == Status.success) {
                            final loginResult = Login.fromJson(result.data!);
                            // final loginResult = Token.fromJson(result.data!);
                            print("loginResult.status");
                            print(loginResult.status);
                            if (loginResult.status == 1) {
                              await PreferenceHelper()
                                  .setUserData(loginResult.data!.dataku!);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  MainPage.route, (context) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(loginResult.message!)));
                            }
                            // print("Token :");
                            // print(loginResult.data!.dataku!.token!.token);

                          } else {
                            _showDialog(context);
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //     backgroundColor: Colors.red,
                            //     content: Text(
                            //       "Gagal masuk, silahkan coba lagi!",
                            //       style: TextStyle(color: Colors.white),
                            //     )));
                          }

                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => HomePage()));
                        },
                        // child: InkWell(
                        //   onTap: () {
                        //     // _telpController.text = '085325430003';
                        //     // _passwordController.text = 'alfa2020';
                        //   },
                        //   child: Text(
                        //     "LOGIN",
                        //     style: TextStyle(
                        //       fontSize: 18,
                        //     ),
                        //   ),
                        // ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Lupa Password',
                                  style: new TextStyle(color: Colors.blue),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launch(
                                          'https://kopkar.japernosa.com/password/reset');
                                    },
                                ),
                              ]),
                            ),
                            Spacer(),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Daftar',
                                  style: new TextStyle(color: Colors.blue),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      launch(
                                          'https://forms.gle/fsWPWzyyGu72miMK7');
                                    },
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text("Version: V.01")
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    ));

    // Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 25),
    //   child: ListView(
    //     children: [
    //       SizedBox(height: 50),
    //       Container(
    //         alignment: Alignment.centerLeft,
    //         height: 150,
    //         child: Image.asset(
    //           "assets/auth/login.png",
    //           fit: BoxFit.contain,
    //         ),
    //       ),
    //       SizedBox(height: 20),
    //       Text(
    //         "Silahkan masuk dengan nomor hanphone kamu",
    //         style: TextStyle(
    //           fontSize: 18,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       SizedBox(height: 15),
    //       Text(
    //         "Nomor HP",
    //         style: TextStyle(
    //           fontSize: 14,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       SizedBox(height: 10),
    //       TextField(
    //         controller: telpController,
    //         keyboardType: TextInputType.phone,
    //         autocorrect: false,
    //         decoration: InputDecoration(
    //           border: OutlineInputBorder(),
    //           hintText: "Cth. 08129011xxxx",
    //         ),
    //       ),
    //       SizedBox(height: 10),
    //       Text(
    //         "Password",
    //         style: TextStyle(
    //           fontSize: 14,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       SizedBox(height: 10),
    //       TextField(
    //         controller: passwordController,
    //         obscureText: true,
    //         autocorrect: false,
    //         decoration: InputDecoration(
    //           border: OutlineInputBorder(),
    //           hintText: "Cth. 12345678",
    //         ),
    //       ),
    //       SizedBox(height: 10),
    //       Row(
    //         children: [],
    //       ),
    //       SizedBox(height: 30),
    //       ButtonLogin(
    //         onTap: () async {
    //           final json = {
    //             "telp": telpController.text,
    //             "password": passwordController.text,
    //           };
    //           final result = await AuthApi().postLogin(json);
    //           print(result);
    //           // // print("Status :");
    //           // // print(result.status);

    //           if (result.status == Status.success) {
    //             final loginResult = Login.fromJson(result.data!);
    //             // final loginResult = Token.fromJson(result.data!);

    //             if (loginResult.status == 1) {
    //               await PreferenceHelper().setUserData(loginResult.data!);

    //               Navigator.of(context).pushNamedAndRemoveUntil(
    //                   MainPage.route, (context) => false);
    //             } else {
    //               ScaffoldMessenger.of(context).showSnackBar(
    //                   SnackBar(content: Text(loginResult.message!)));
    //             }
    //             //   print("Login Result :");
    //             print(loginResult.data!);
    //           } else {
    //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //                 backgroundColor: Colors.red,
    //                 content: Text(
    //                   "Gagal masuk, silahkan coba lagi!",
    //                   style: TextStyle(color: Colors.white),
    //                 )));
    //           }

    //           // Navigator.of(context).pushNamed(MainPage.route);
    //         },
    //         backgroundColor: Colors.blueAccent,
    //         borderColor: R.colors.primary,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             // Image.asset(R.assets.icGoogle),
    //             // SizedBox(width: 15),
    //             Text(
    //               "Masuk",
    //               style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.w500,
    //                 color: Colors.white,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: 30),
    //       Center(
    //         child: Text("Atau masuk menggunakan"),
    //       ),
    //       SizedBox(height: 40),
    //       ButtonLogin(
    //         onTap: () {},
    //         backgroundColor: Colors.white,
    //         borderColor: R.colors.primary,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Image.asset(R.assets.icGoogle),
    //             SizedBox(width: 15),
    //             Text(
    //               R.strings.loginWithGoogle,
    //               style: TextStyle(
    //                 fontSize: 15,
    //                 fontWeight: FontWeight.w500,
    //                 color: R.colors.blackLogin,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    // );
  }
}

class _showLoading extends StatelessWidget {
  const _showLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 16,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CircularProgressIndicator(
            //   backgroundColor: Colors.red,
            // ),
            Image.asset(R.assets.imgNotFound),
            SizedBox(
              height: 8,
            ),
            Text("Loading...")
          ],
        ),
      ),
    );
  }
}

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({
    Key? key,
    required this.backgroundColor,
    required this.child,
    required this.borderColor,
    required this.onTap,
    this.radius,
  }) : super(key: key);
  final double? radius;
  final Color backgroundColor;
  final Widget child;
  final Color borderColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 25),
            side: BorderSide(
              color: borderColor,
            ),
          ),
          fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
        ),
        onPressed: onTap,
        child: child,
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Alert!"),
        content: new Text("Login gagal, Silahkan coba lagi"),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
