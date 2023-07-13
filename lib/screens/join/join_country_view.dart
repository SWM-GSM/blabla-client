import 'package:blabla/models/country.dart';
import 'package:blabla/screens/join/join_view_model.dart';
import 'package:blabla/screens/join/widgets/join_country_widget.dart';
import 'package:blabla/screens/join/widgets/join_desc_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class JoinCountryView extends StatefulWidget {
  const JoinCountryView({super.key});

  @override
  State<JoinCountryView> createState() => _JoinCountryViewState();
}

class _JoinCountryViewState extends State<JoinCountryView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinViewModel>(context);
    String keyword = "";

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            JoinDescWidget(
              page: JoinPage.country,
              title: "국가를\n선택해주세요",
              step: 0.125 * (JoinPage.country.index + 1),
              widgets: [
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
                        viewModel.getCountries(keyword);
                      });
                    },
                    style: BlaTxt.txt16R,
                    decoration: InputDecoration(
                      icon: SvgPicture.asset("assets/icons/ic_24_search.svg",
                          width: 24, height: 24),
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      hintText: "국가 검색",
                      hintStyle:
                          BlaTxt.txt16R.copyWith(color: BlaColor.grey500),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
                itemCount: viewModel.searchCountries.length,
                itemBuilder: (context, idx) {
                  return GestureDetector(
                      onTap: () {
                        viewModel.setCountry(viewModel.searchCountries[idx].code);
                      },
                      child: JoinCountryWidget(
                          country: viewModel.searchCountries[idx],
                          selected: viewModel.countryCode ==
                              viewModel.searchCountries[idx].code));
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          if (viewModel.countryCode.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JoinCountryView()),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              20, 10, 20, 10 + MediaQuery.of(context).viewPadding.bottom),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: viewModel.countryCode.isNotEmpty
                  ? BlaColor.orange
                  : BlaColor.grey400),
          child:
              Text("다음", style: BlaTxt.txt16B.copyWith(color: BlaColor.white)),
        ),
      ),
    );
  }
}
