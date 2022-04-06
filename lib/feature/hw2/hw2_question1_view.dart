import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:crypto_mobile/core/cache/locale_manager.dart';
import 'package:crypto_mobile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Hw2Question1View extends StatefulWidget {
  const Hw2Question1View({Key? key}) : super(key: key);

  @override
  State<Hw2Question1View> createState() => _Hw2Question1ViewState();
}

class _Hw2Question1ViewState extends State<Hw2Question1View> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  int state = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Question 1'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Text(
              state == 0 ? 'Giriş Yap' : 'Kayıt Ol',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                _buildFormField(usernameController, 'Kullanıcı Adı'),
                const SizedBox(height: 20),
                _buildFormField(passwordController, 'Şifre'),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(state == 0 ? 'Kayıt Ol' : 'Giriş Yap'),
                    onPressed: () {
                      setState(() {
                        state == 0 ? state = 1 : state = 0;
                      });
                    },
                  ),
                )
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  if (state == 0) {
                    signIn();
                  } else {
                    signUp();
                  }
                },
                child: Text(state == 0 ? 'Giriş Yap' : 'Kayıt Ol')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  TextFormField _buildFormField(
      TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }

  void signUp() async {
    try {
      var users = [];
      var userJson = LocaleManager.instance.getStringValue('users');
      if (userJson != '') {
        users = await jsonDecode(userJson);
      }
      var user = users.firstWhere((element) {
        element as Map;
        if (element['username'] == usernameController.text) return true;
        return false;
      }, orElse: () => null);
      if (user == null) {
        var bytes = utf8.encode(passwordController.text);
        var hashPassword = sha512.convert(bytes);
        users.add({
          'username': usernameController.text,
          'password': hashPassword.toString()
        });
        // print(users);
        await LocaleManager.instance.setStringValue('users', jsonEncode(users));
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Kayıt başarılı')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Bu username ile kayıtlı kullanıcı var')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Kayıt hatalı')));
    }
  }

  void signIn() async {
    try {
      var users = [];
      var userJson = LocaleManager.instance.getStringValue('users');
      if (userJson != '') {
        users = await jsonDecode(userJson);
      }
      var user = users.firstWhere((element) {
        element as Map;
        if (element['username'] == usernameController.text) return true;
        return false;
      }, orElse: () => null);
      if (user != null) {
        var bytes = utf8.encode(passwordController.text);
        var hashPassword = sha512.convert(bytes);
        if (hashPassword.toString() == user['password']) {
          snackBar('Şifre doğru');
        } else {
          snackBar('Şifre yanlış');
        }
      } else {
        snackBar('Kayıtlı kullanıcı bulunamadı');
      }

      // print(users);
      // await LocaleManager.instance.setStringValue('users', jsonEncode(users));
      // snackBar('Kayıt başarılı');
    } catch (e) {
      snackBar('Kayıt hatalı');
    }
  }

  void snackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
