import 'package:blabla/screens/crew_space/crews_view_model.dart';
import 'package:blabla/screens/crew_space/widgets/crews_report_widget.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:blabla/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CrewsReportsView extends StatelessWidget {
  const CrewsReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CrewsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Text(
          "크루 리포트",
          style: BlaTxt.txt18B,
        ),
        backgroundColor: BlaColor.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SvgPicture.asset(
                "assets/icons/ic_32_arrow_left.svg",
                width: 24,
                height: 24,
                colorFilter:
                    const ColorFilter.mode(BlaColor.black, BlendMode.srcIn),
              )),
        ),
        leadingWidth: 64,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: BlaColor.grey200, width: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Wrap(
                        spacing: 4,
                        direction: Axis.horizontal,
                        children: [
                          Text(
                            "기간",
                            style:
                                BlaTxt.txt14M.copyWith(color: BlaColor.grey700),
                          ),
                          SvgPicture.asset("assets/icons/ic_24_arrow_down.svg",
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(
                                  BlaColor.grey800, BlendMode.srcIn))
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      direction: Axis.horizontal,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_20_sort.svg",
                          width: 20,
                          height: 20,
                        ),
                        Text(
                          "최신순",
                          style: BlaTxt.txt14M.copyWith(color: BlaColor.grey700),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: viewModel.reportList.map((e) => CrewsReportWidget(reportType: ReportType.big, reportStatus: true, report: e)).toList()
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
