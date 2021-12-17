// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:demoappck/presentation/page/bang_gia.dart';
import 'core/implements/http_client.dart';
import 'package:demoappck/core/models/account_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
        // fontFamily: 'SourceSansPro',
        textTheme: TextTheme(
          headline3: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            // fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          button: TextStyle(
            // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
            fontFamily: 'OpenSans',
          ),
          caption: TextStyle(
            fontFamily: 'NotoSans',
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          headline1: TextStyle(fontFamily: 'Quicksand'),
          headline2: TextStyle(fontFamily: 'Quicksand'),
          headline4: TextStyle(fontFamily: 'Quicksand'),
          headline5: TextStyle(fontFamily: 'NotoSans'),
          headline6: TextStyle(fontFamily: 'NotoSans'),
          subtitle1: TextStyle(fontFamily: 'NotoSans'),
          bodyText1: TextStyle(fontFamily: 'NotoSans'),
          bodyText2: TextStyle(fontFamily: 'NotoSans'),
          subtitle2: TextStyle(fontFamily: 'NotoSans'),
          overline: TextStyle(fontFamily: 'NotoSans'),
        ),
      ),
      home: MyHomePage(title: 'Demo chứng khoán'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FlutterLogin(
            // ignore: missing_return
            onSignup: (data) {},
            userType: LoginUserType.phone,
            messages: LoginMessages(
                userHint: 'Tên đăng nhập',
                passwordHint: 'Mật khẩu',
                loginButton: 'Đăng nhập'),
            onSubmitAnimationCompleted: (data) {},
            hideForgotPasswordButton: true,
            hideSignUpButton: true,
            onLogin: (data) {
              return onLogin(data.name, data.password);

              // var loginData = new AccountLogin(
              //     username: data.name, password: data.password);
              // RestClient().getAccessToken(loginData).then((value) {
              //   print(value);
              // });
              // print('on login');
            },
            // ignore: missing_return
            onRecoverPassword: (data) {}),
      ),
    );
  }

  Future<String> onLogin(String userName, String pass) {
    var loginData = new AccountLogin(username: userName, password: pass);
    return RestClient().getAccessToken(loginData).then((value) {
      // return 'User not exists';
      if (!value.success) {
        return value.message;
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => BangGiaPage()));
        return '';
      }
    });
  }
}
