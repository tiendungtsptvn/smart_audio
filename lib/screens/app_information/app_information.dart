import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/constants/constants.dart';

class AppInformationScreen extends StatelessWidget {
  const AppInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App Information',
          style: TextStyle(
            color: ColorSAU.textGrey,
          ),
        ),
        backgroundColor: ColorSAU.primaryColor,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: ColorSAU.secondaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(StringSAU.logoImage, width: 150, height: 150,fit: BoxFit.cover,),
            const Text("Let the music take you away", style: TextStyle(
              fontSize: 20,
            ),),
            const SizedBox(height: 30,),
            const Text("Smart Audio brings you a new and more enjoyable "
                "listening experience. With the help of virtual assistant Alan,"
                " you can search and play a song, intelligently request song recommendations,"
                " and much more. To start communicating with the virtual assistant,"
                " you need to wake it up by saying \"Hey, Alan\","
                " right after that you can say \"Play Dreamer\" to play Dreamer song "
                "or \"Recommend me music\" to get recommended songs from Alan, and more.",
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            )


          ],
        ),
      ),
    );
  }
}
