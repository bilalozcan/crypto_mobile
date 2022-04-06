import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:crypto_mobile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Hw2Question2View extends StatefulWidget {
  const Hw2Question2View({Key? key}) : super(key: key);

  @override
  State<Hw2Question2View> createState() => _Hw2Question2ViewState();
}

class _Hw2Question2ViewState extends State<Hw2Question2View> {
  final _dummyData =
      'The quick, brown fox jumps over a lazy dog. DJs flock by when MTV ax quiz prog. '
      'Junk MTV quiz graced by fox whelps. Bawds jog, flick quartz, vex nymphs. '
      'Waltz, bad nymph, for quick jigs vex! Fox nymphs grab quick-jived waltz. '
      'Brick quiz whangs jumpy veldt fox. Bright vixens jump; dozy fowl quack. '
      'Quick wafting zephyrs vex bold Jim. Quick zephyrs blow, vexing daft Jim. '
      'Sex-charged fop blew my junk TV quiz. How quickly daft jumping zebras vex. '
      'Two driven jocks help fax my big quiz. Quick, Baz, get';
  late String dummyData;
  String? hashData;
  List<String> hashList = [];
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    dummyData = _dummyData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Question 2'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _buildTitle('Hashlenecek metin (500 karakter):'),
            const SizedBox(height: 20),
            Text(dummyData),
            const SizedBox(height: 20),
            _buildTitle('Hash:'),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueGrey)),
              child: Center(
                  child: hashData != null ? Text(hashData!) : const SizedBox()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      var bytes = utf8.encode(dummyData);
                      var hashText = md5.convert(bytes);
                      setState(() {
                        hashData = hashText.toString();
                      });
                    },
                    child: const Text('Hashle')),
                ElevatedButton(
                    onPressed: () async {
                      //! BURADA METNİN HER BİR KARAKTERİ SIRAYLA RANDOM BİR KARAKTER İLE
                      //! DEĞİŞTİRİLEREK TEKRAR HASHLENİYOR VE LİSTEYE EKLENİYOR
                      for (var i = 0; i < 500; ++i) {
                        setState(() {
                          dummyData = _dummyData.replaceRange(
                              i, i + 1, getRandomString(1));
                          var bytes = utf8.encode(dummyData);
                          var hashText = md5.convert(bytes);
                          hashList.add(hashText.toString());
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 1),
                          );
                        });
                        await Future.delayed(const Duration(milliseconds: 25));
                      }
                    },
                    child: const Text('Programı Başlat')),
                    ElevatedButton(
                    onPressed: () {
                      setState(() {
                        dummyData = _dummyData;
                        hashList.clear();
                        hashData = null;
                      });
                    },
                    child: const Text('Sıfırla')),
              ],
            ),
            Expanded(
                child: ListView(
              controller: scrollController,
              children: hashList
                  .map((hash) => Row(
                        children: [
                          Text((hashList.indexOf(hash) + 1).toString() + ' - '),
                          Text(hash)
                        ],
                      ))
                  .toList(),
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Align _buildTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
