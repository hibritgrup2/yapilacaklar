import 'package:flutter/material.dart';
import 'package:flutter_application_3/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.purple[100],
      content: Container(
        height: 120,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          //kullanıcı girişi
          TextField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Yeni taslak ekle."),
          ),
          //butonlar -> kayıt + iptal
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //kayıt butonu
              MyButton(text: "Kaydet", onPressed: onSave),

              const SizedBox(width: 8),
              //iptal butonu
              MyButton(text: "İptal", onPressed: onCancel),
            ],
          )
        ]),
      ),
    );
  }
}
