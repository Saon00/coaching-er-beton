import 'package:coachingerbeton/controllers/paid_unpaid_controller.dart';
import 'package:coachingerbeton/models/data/student_info_sp.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:coachingerbeton/views/pages/batch_page.dart';
import 'package:coachingerbeton/views/pages/homepagewidgets/debitcredit.dart';
import 'package:coachingerbeton/views/pages/homepagewidgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // PaidUnpaidController? paidUnpaidController;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     paidUnpaidController =
  //         Provider.of<PaidUnpaidController>(context, listen: false);
  //     await fetchTotals();
  //   });
  //   fetchTotals();
  // }

  // Future<void> fetchTotals() async {
  //   DatabaseHelper db = DatabaseHelper();
  //   int paid = await db.getTotalSalary(isPaid: 1);
  //   int unpaid = await db.getTotalSalary(isPaid: 0);
  //   paidUnpaidController?.fetchTotals(paid, unpaid); // Update data in provider
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer
      // drawer: const MyDrawer(),

      appBar: AppBar(
        // profile name
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Hi, ${StudentInfoUtils.displayName ?? ""}',
              style: titlePopins.copyWith(fontSize: 20),
            ),
          ),
        ],
      ),

      // body
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            // month name
            Center(
              child: Text(DateFormat('d MMMM ').format(DateTime.now()),
                  style: titlePopins.copyWith(fontSize: 30)),
            ),
            const SizedBox(height: 15),

            // money flow
            // Consumer<PaidUnpaidController>(builder: (context, value, child) {
            //   return Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       DebitCreditWidget(
            //         title: AppLocalizations.of(context)!.paid.toString(),
            //         color: Colors.green,
            //         amount: value.totalPaid,
            //       ),
            //       DebitCreditWidget(
            //         title: AppLocalizations.of(context)!.unpaid.toString(),
            //         color: Colors.redAccent,
            //         amount: value.totalUnpaid,
            //       ),
            //     ],
            //   );
            // }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DebitCreditWidget(
                  title: AppLocalizations.of(context)!.paid.toString(),
                  color: Colors.green,
                  amount: Provider.of<PaidUnpaidController>(context).totalPaid,
                ),
                DebitCreditWidget(
                  title: AppLocalizations.of(context)!.unpaid.toString(),
                  color: Colors.redAccent,
                  amount:
                      Provider.of<PaidUnpaidController>(context).totalUnpaid,
                ),
              ],
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
