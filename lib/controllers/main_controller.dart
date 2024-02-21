import 'dart:convert';

import 'package:esmabatu/widgets/custom_snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

enum UploadType {
  message,
  image,
  clear,
}

class MainController extends GetxController {
  var remTimeDays = 0.obs;
  var remTimeHours = 0.obs;
  var remTimeMinutes = 0.obs;
  var remTimeSeconds = 0.obs;

  var uuid = const Uuid();
  Base64Codec base64 = const Base64Codec();
  late UploadTask uploadTask;

  void calculateRemainingTime() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final future = DateTime(2024, 06, 14, 19, 0, 0).millisecondsSinceEpoch;
    Duration remaining = Duration(milliseconds: future - now);

    remTimeDays.value = remaining.inDays;
    remTimeHours.value = remaining.inHours.remainder(24);
    remTimeMinutes.value = remaining.inMinutes.remainder(60);
    remTimeSeconds.value = remaining.inSeconds.remainder(60);
  }

  Future<UploadTask?> uploadImage(
      XFile image, BuildContext context, String senderName) async {
    String fileName = "$senderName-${uuid.v4()}";
    if (senderName == "") {
      fileName = uuid.v4();
    }

    Reference refImages = FirebaseStorage.instance
        .ref()
        .child('Resimler')
        .child("/$fileName.jpg");

    final metadata = SettableMetadata(
      contentType: 'image/jpg',
      customMetadata: {
        'picked-file-path': image.path,
        "owner": senderName,
      },
    );

    uploadTask = refImages.putData(await image.readAsBytes(), metadata);

    return Future.value(uploadTask);
  }

  /// A new string is uploaded to storage.
  UploadTask? uploadMessage(
      String? msg, String senderName, BuildContext context) {
    print(msg);
    if (msg == null || msg == "") {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
        text: "Boş mesaj göndermeye çalıştınız :(",
        duration: const Duration(seconds: 2),
      ));
      return null;
    }

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('Mesajlar')
        .child('/$senderName-${uuid.v4()}.txt');

    // Start upload of putString
    return ref.putString(
      msg,
      metadata: SettableMetadata(
        contentLanguage: 'tr',
        customMetadata: <String, String>{'owner': senderName},
      ),
    );
  }
}
