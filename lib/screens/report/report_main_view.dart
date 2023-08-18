import 'package:blabla/screens/report/report_view_model.dart';
import 'package:blabla/screens/report/widgets/report_history_tile.dart';
import 'package:blabla/styles/colors.dart';
import 'package:blabla/styles/txt_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ReportMainView extends StatelessWidget {
  const ReportMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ReportViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: BlaColor.white,
        elevation: 0,
        title: Text(
          "히스토리",
          style: BlaTxt.txt18B,
        ),
        centerTitle: true,
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //       print("인포 버튼 클릭");
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 20),
        //       child: SvgPicture.asset(
        //         "assets/icons/ic_24_info.svg",
        //         width: 24,
        //         height: 24,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  HistoryFilter.values.length,
                  (idx) => GestureDetector(
                    onTap: () {
                      viewModel.setHistoryFilter(HistoryFilter.values[idx]);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: 84,
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: viewModel.filter == HistoryFilter.values[idx]
                            ? BlaColor.lightOrange
                            : BlaColor.grey100,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                "assets/icons/ic_16_${HistoryFilter.values[idx].icon}.svg",
                                width: 16,
                                height: 16,
                                colorFilter: ColorFilter.mode(
                                    viewModel.filter ==
                                            HistoryFilter.values[idx]
                                        ? BlaColor.orange
                                        : BlaColor.grey600,
                                    BlendMode.srcIn)),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              HistoryFilter.values[idx].name,
                              style:
                                  viewModel.filter == HistoryFilter.values[idx]
                                      ? BlaTxt.txt12B
                                          .copyWith(color: BlaColor.orange)
                                      : BlaTxt.txt12M
                                          .copyWith(color: BlaColor.grey600),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: List.generate(
                  viewModel.histories.length,
                  (calendarIdx) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    child: Column(
                        children: List.generate(
                            viewModel.histories[calendarIdx].reports.length,
                            (idx) => Row(
                                  children: [
                                    if (idx == 0)
                                      SizedBox(
                                        width: 30,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${viewModel.histories[calendarIdx].datetime.month}월",
                                              style: BlaTxt.txt12R.copyWith(
                                                  color: BlaColor.grey700),
                                            ),
                                            Text(
                                              "${viewModel.histories[calendarIdx].datetime.day}",
                                              style: BlaTxt.txt20B,
                                            )
                                          ],
                                        ),
                                      ),
                                    SizedBox(width: idx == 0 ? 16 : 46),
                                    Expanded(
                                        child: ReportHistoryTile(
                                      report: viewModel
                                          .histories[calendarIdx].reports[idx],
                                    )),
                                  ],
                                ))),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
