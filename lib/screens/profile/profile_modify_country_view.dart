import 'package:blabla/screens/profile/profile_modify_view_model.dart';
import 'package:blabla/screens/profile/widgets/profile_country_widget.dart';
import 'package:blabla/screens/profile/widgets/profile_modify_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileModifyCountryView extends StatefulWidget {
  const ProfileModifyCountryView({super.key});

  @override
  State<ProfileModifyCountryView> createState() =>
      _ProfileModifyCountryViewState();
}

class _ProfileModifyCountryViewState extends State<ProfileModifyCountryView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileModifyViewModel>(context);
    String keyword = "";
    return ProfileModifyWidget(
        title: "국적",
        subTitle: "국가를 선택해주세요",
        leadingTap: () {
          viewModel.tempCountryCode == viewModel.countryCode
              ? Navigator.pop(context)
              : showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                        title: Text(
                          "화면을 나가면\n변경사항이 저장되지 않습니다.\n나가시겠습니까?",
                          style: BlaTxt.txt14R,
                        ),
                        actions: [
                          CupertinoDialogAction(
                            child: Text(
                              "취소",
                              style: BlaTxt.txt14R,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text("나가기",
                                style: BlaTxt.txt14R
                                    .copyWith(color: BlaColor.red)),
                            onPressed: () {
                              viewModel.revertCountry();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ));
        },
        actionTap: () {
          Navigator.pop(context);
        },
        widget: Expanded(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: BlaColor.grey100,
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      keyword = value;
                      viewModel.getSearchCountryList(keyword);
                    });
                  },
                  style: BlaTxt.txt16R,
                  decoration: InputDecoration(
                    icon: SvgPicture.asset("assets/icons/ic_24_search.svg",
                        width: 24, height: 24),
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    hintText: "국가 검색",
                    hintStyle: BlaTxt.txt16R.copyWith(color: BlaColor.grey500),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  itemCount: viewModel.searchCountryList.length,
                  itemBuilder: (context, idx) {
                    return GestureDetector(
                        onTap: () {
                          viewModel.setCountry(
                              viewModel.searchCountryList[idx].code);
                        },
                        child: ProfileCountryWidget(
                            country: viewModel.searchCountryList[idx],
                            selected: viewModel.tempCountryCode ==
                                viewModel.searchCountryList[idx].code));
                  },
                ),
              )
            ],
          ),
        ));
  }
}
