import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokeka_2/Schedule/Schedule.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email = '';
  String _password = '';
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログインページ'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "mail",
                        hintText: 'xxx@gmail.com',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
                    TextField(
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: "password",
                        hintText: '6文字以上',
                        suffixIcon: IconButton(
                          // 文字の表示、非表示でアイコンを変える
                          icon: Icon(_isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                          // アイコンがタップされたら現在と反対の状態をセット
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                  ],
                )
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    color: const Color(0xFFE0E0E0),
                    child: const Text(
                      '登録する',
                      style: TextStyle(color: Colors.black),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), //角の丸み
                      // side: BorderSide(color: Colors.black), //枠線の設定
                    ),
                    onPressed: () async {
                      try {
                        final User? user = (
                            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: _email, password: _password)
                        ).user;
                        if (user != null) {
                          print('ユーザーを登録しました ${user.email} ${user.uid}');
                        }
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Schedule()));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('ユーザー登録ができません'),
                              backgroundColor: Colors.red,
                            )
                        );
                        print(e);
                      }
                    },
                  ),
                  MaterialButton(
                    color: const Color(0xFFE0E0E0),
                    child: const Text(
                      'ログイン',
                      style: TextStyle(color: Colors.black),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), //角の丸み
                      // side: BorderSide(color: Colors.black), //枠線の設定
                    ),
                    onPressed: () async {
                      try {
                        final User? user = (
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: _email, password: _password)).user;
                        if (user != null) {
                          print('ログインしました ${_email} ${user.uid}');
                        }
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Schedule()));
                      }
                      // 例外処理
                      catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          // snackbarでログインができなかったことを知らせる
                            const SnackBar(
                              content: Text('ログインができませんでした'),
                              backgroundColor: Colors.red,
                            ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
