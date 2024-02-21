import 'package:esmabatu/controllers/main_controller.dart';
import 'package:esmabatu/route.dart';
import 'package:esmabatu/utils/constants.dart';
import 'package:esmabatu/widgets/custom_app_bar.dart';
import 'package:esmabatu/widgets/custom_button.dart';
import 'package:esmabatu/widgets/custom_snackbar.dart';
import 'package:esmabatu/widgets/dates_widget.dart';
import 'package:esmabatu/widgets/family_card.dart';
import 'package:esmabatu/widgets/timer_counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final homeController = Get.find<MainController>();

  final TextEditingController senderNameController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  Future<void> _takePhoto() async {
    try {
      final pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 25);

      if (pickedFile != null) {
        final XFile imgBytes = pickedFile;
        // ignore: use_build_context_synchronously
        await homeController.uploadImage(
          imgBytes,
          context,
          senderNameController.text,
        );

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          text: "Fotoğrafınız gönderildi! Teşekkür ederiz.",
          duration: const Duration(seconds: 2),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
        text: "Tekrar deneyin!",
        duration: const Duration(seconds: 2),
      ));
      debugPrint("Error: $e");
    }
  }

  Future<void> _writeNote() async {
    String note = "";
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 8,
          content: Container(
            padding: const EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              onChanged: (value) {
                note = value;
              },
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Notunuzu yazın",
                labelStyle: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text("İptal"),
            ),
            TextButton(
              onPressed: () {
                final task = homeController.uploadMessage(
                  note,
                  senderNameController.text,
                  context,
                );
                if (task != null) {
                  ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                    text: "Notunuz gönderildi! Teşekkür ederiz.",
                    duration: const Duration(seconds: 2),
                  ));
                }

                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text("Gönder"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/main_bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(),
              const SizedBox(height: 16.0),
              const CountdownWidget(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 36.0),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      runSpacing: 20.0,
                      children: [
                        CustomButton(
                          btnText: 'Düğün',
                          onPressed: () => Get.rootDelegate.toNamed(
                            MyRoute.weddingPage,
                          ),
                        ),
                        CustomButton(
                          btnText: 'Kına',
                          onPressed: () => Get.rootDelegate.toNamed(
                            MyRoute.kinaPage,
                          ),
                        ),
                        CustomButton(
                          btnText: "Fotoğraf/Not Gönder",
                          onPressed: () => customBottomModalSheet(context),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          top: 32, bottom: 30, left: 20, right: 20),
                      child: Text(
                        invNote,
                        style: GoogleFonts.alexBrush(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                    ),
                    const FamilyCard(),
                    const SizedBox(
                      height: 36,
                    ),
                    const DatesWidget(),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void customBottomModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Fotoğraf/Not Gönder",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextField(
                    controller: senderNameController,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.name,
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "İsminiz",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        _takePhoto();
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[400],
                        minimumSize: const Size(100, 50),
                      ),
                      child: Text(
                        "Fotoğraf",
                        style: GoogleFonts.quicksand(fontSize: 20),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (senderNameController.text == '') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(CustomSnackBar(
                            text: "Lütfen isminizi giriniz!",
                            duration: const Duration(seconds: 2),
                          ));
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          return;
                        }
                        _writeNote();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[400],
                        minimumSize: const Size(100, 50),
                      ),
                      child: Text(
                        "Not",
                        style: GoogleFonts.quicksand(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
