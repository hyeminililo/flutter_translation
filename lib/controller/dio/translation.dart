import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multilinual_api/model/client.dart';
import 'package:http/http.dart';

class PapagoTranslationPage extends StatefulWidget {
  const PapagoTranslationPage({super.key});

  @override
  State<PapagoTranslationPage> createState() => _PapagoTranslationPageState();
}

class _PapagoTranslationPageState extends State<PapagoTranslationPage> {
  final dio = Dio();
  final TextEditingController _textEditingController = TextEditingController();
  String translationResult = "";

  Future<void> translatedText() async {
    final response = await dio.post('https://openapi.naver.com/v1/papago/n2mt',
        data: {
          'source': 'ko',
          'target': 'en',
          'text': _textEditingController.text,
        },
        options: Options(headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'X-Naver-Client-Id': CLIENT_ID,
          'X-Naver-Client-Secret': CLIENT_SECRET,
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      final data = response.data;
      final translatedText = data['message']['result']['translatedText'];
      setState(() {
        translationResult = translatedText;
      });
    } else {
      setState(() {
        translationResult = '번역 실패: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('네이버 파파고 입력')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 50.0,
            ),
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(labelText: '번역할 텍스트 입력 '),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(onPressed: translatedText, child: const Text('번역')),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              '번역 결과: $translationResult',
              style: const TextStyle(fontSize: 16),
            )
          ],
        ));
  }
}
