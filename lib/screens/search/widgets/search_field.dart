import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/constants/color.dart';
import '../search_controller.dart';

import '../../../theme/colors.dart';
import '../../../theme/text_theme.dart';

class SearchTrackField extends GetView<SearchController> {
  const SearchTrackField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller.searchController,
        textInputAction: TextInputAction.search,
        style: textStyle(GPTypography.body16)?.copyWith(
          color: Colors.white
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          prefixIcon: Icon(
            Icons.search_outlined,
            color: ColorSAU.secondaryColor,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
                onTap: () {
                  controller.clearData();
                },
                child: Text(
                  "Clear",
                  style: TextStyle(
                    color: ColorSAU.secondaryColor,
                  ),
                )),
          ),
          suffixIconConstraints: const BoxConstraints(
            maxWidth: 50,
          ),
          fillColor: GPColor.textFieldBkg,
          hintText: "Search tracks",
        ),
        autocorrect: false,
        onChanged: (keyword) {
          controller.searchTracks(keyword: keyword);
        },
      ),
    );
  }
}
