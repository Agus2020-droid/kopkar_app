import 'package:cupertino_progress_bar/cupertino_progress_bar.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_japernosa/contents/r.dart';
import 'package:kopkar_japernosa/models/list_pinjaman.dart';
import 'package:kopkar_japernosa/models/network_response.dart';
import 'package:kopkar_japernosa/repository/kopkar_japernosa_api.dart';
import 'package:kopkar_japernosa/views/main/transaction/detail_pinjaman.dart';
import 'package:skeletons/skeletons.dart';

class PinjamanPage extends StatefulWidget {
  const PinjamanPage({Key? key}) : super(key: key);

  @override
  State<PinjamanPage> createState() => _PinjamanPageState();
}

class _PinjamanPageState extends State<PinjamanPage> {
  ListPinjaman? listPinjaman;
  Future getPinjaman() async {
    final listPinjamanResult = await KopkarJapernosaApi().getPinjaman();
    if (listPinjamanResult.status == Status.success) {
      listPinjaman = ListPinjaman.fromJson(listPinjamanResult.data!);

      setState(() {
        print("Data List Pinjaman");
        print(listPinjaman!.data!.length);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPinjaman();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Pinjaman Saya")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: listPinjaman == null
            ? Container(
                // height: 16,
                width: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Loading...")
                    ],
                  ),
                ),
              )
            : ListView.builder(
                itemCount: listPinjaman!.data!.length,
                itemBuilder: (context, index) {
                  final currentPinjaman = listPinjaman!.data![index];
                  final String nomor = currentPinjaman.noPinjaman!.toString();
                  final tgl = currentPinjaman.tglPengajuan;
                  final ttlPinjam = currentPinjaman.totalKredit!;
                  final bal = currentPinjaman.balance!;
                  final totalPinjam = ttlPinjam.toString();

                  // print(tanggals);
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailPinjamanPage(
                                id: currentPinjaman.noPinjaman!),
                          ),
                        );
                      },
                      child: PinjamanWidget(
                        jnsPinjaman: currentPinjaman.jenisPinjaman!,
                        jmlkredit: double.tryParse(totalPinjam),
                        tanggals: tgl,
                        balances: double.tryParse(bal),
                        no: nomor,
                      ));
                }),
      ),
    );
  }
}

class PinjamanWidget extends StatelessWidget {
  const PinjamanWidget({
    Key? key,
    this.jnsPinjaman,
    this.jmlkredit,
    this.tenors,
    this.no,
    this.balances,
    this.tanggals,
    // this.jmlAngsur,
  }) : super(key: key);

  // final String? jumlahShu;
  final String? jnsPinjaman;
  final double? jmlkredit;
  final double? balances;
  final String? tanggals;

  final int? tenors;
  final String? no;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: R.colors.primary,
          height: 30,
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Text(
                "Tanggal",
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.blue),
              ),
              Spacer(),
              Text(
                // "$tanggals",
                DateFormat("dd-MMM-yyy").format(DateTime.parse(tanggals!)),
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Colors.red),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(8),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey,
            //     offset: const Offset(
            //       5.0,
            //       5.0,
            //     ),
            //     blurRadius: 3.0,
            //     spreadRadius: 1.0,
            //   ), //BoxShadow
            //   BoxShadow(
            //     color: Colors.white,
            //     offset: const Offset(0.0, 0.0),
            //     blurRadius: 0.0,
            //     spreadRadius: 0.0,
            //   ), //BoxShadow
            // ],
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.black.withOpacity(0.25))
                ]),
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Nomor Pinjaman",
                    ),
                    Spacer(),
                    Text(
                      "P-" + "$no",
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Jenis Pinjaman",
                    ),
                    Spacer(),
                    Text("$jnsPinjaman"),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Jumlah",
                    ),
                    Spacer(),
                    Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                          .format(jmlkredit),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Status Pinjaman",
                    ),
                    Spacer(),
                    balances == 0
                        ? Text(
                            "LUNAS",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "BELUM LUNAS",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );

    // Container(
    //   decoration: BoxDecoration(
    //       color: Colors.white, borderRadius: BorderRadius.circular(10)),
    //   margin: const EdgeInsets.only(bottom: 10),
    //   padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 21),
    // child: Row(
    //   children: [
    //     Container(
    //         height: 53,
    //         width: 53,
    //         padding: EdgeInsets.all(8),
    //         decoration: BoxDecoration(
    //             color: R.colors.grey,
    //             borderRadius: BorderRadius.circular(10)),
    //         child: Icon(
    //           Icons.add_chart,
    //           color: Colors.blue,
    //         )
    //         // Image.asset(R.assets.icNote),
    //         ),
    //     SizedBox(width: 6),
    //     Expanded(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           jmlkredit == null
    //               ? Container(
    //                   height: 40,
    //                   width: 40,
    //                   child: Center(
    //                     child: CircularProgressIndicator(),
    //                   ),
    //                 )
    //               : Text(
    //                   // "$tglPinjam",
    //                   "P-" + "$no",
    //                   style: TextStyle(
    //                       fontWeight: FontWeight.w500,
    //                       fontSize: 12,
    //                       color: R.colors.primary),
    //                   // "$jmlkredit",
    //                 ),
    //           Divider(
    //             color: Colors.black,
    //           ),
    //           // SizedBox(height: 2),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 "$jnsPinjaman",
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.w500,
    //                     fontSize: 12,
    //                     color: Colors.green),
    //               ),
    //               Text(
    //                 NumberFormat.currency(
    //                         locale: 'id', symbol: "Rp. ", decimalDigits: 0)
    //                     .format(jmlkredit),
    //                 style:
    //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    //               ),
    //             ],
    //           ),
    //           // SizedBox(height: 5),
    //           // Stack(
    //           //   children: [
    //           //     Container(
    //           //       height: 5,
    //           //       width: double.infinity,
    //           //       decoration: BoxDecoration(
    //           //           color: R.colors.grey,
    //           //           borderRadius: BorderRadius.circular(10)),
    //           //     ),
    //           //     Row(
    //           //       children: [
    //           //         Expanded(
    //           //           flex: 100,
    //           //           child: Container(
    //           //             height: 5,
    //           //             width: MediaQuery.of(context).size.width * 0.5,
    //           //             // decoration: BoxDecoration(
    //           //             //     color: R.colors.primary,
    //           //             //     borderRadius: BorderRadius.circular(10)),
    //           //           ),
    //           //         ),
    //           //         // Expanded(
    //           //         //   flex: tenors! - angsur!,
    //           //         //   child: Container(
    //           //         //     height: 5,
    //           //         //     width: MediaQuery.of(context).size.width * 0.5,
    //           //         //     decoration: BoxDecoration(
    //           //         //         color: R.colors.primary,
    //           //         //         borderRadius: BorderRadius.circular(10)),
    //           //         //   ),
    //           //         // ),
    //           //       ],
    //           //     )
    //           //   ],
    //           // )
    //         ],
    //       ),
    //     )
    //   ],
    // ),
    // );
  }
}
