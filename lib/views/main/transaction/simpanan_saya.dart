import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_japernosa/contents/r.dart';
import 'package:kopkar_japernosa/models/list_penarikan.dart';
import 'package:kopkar_japernosa/models/list_simpanan.dart';
import 'package:kopkar_japernosa/models/network_response.dart';
import 'package:kopkar_japernosa/models/total_simpanan.dart';
import 'package:kopkar_japernosa/repository/kopkar_japernosa_api.dart';
import 'package:skeletons/skeletons.dart';

class SimpananPage extends StatefulWidget {
  const SimpananPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SimpananPage> createState() => _SimpananPageState();
}

class _SimpananPageState extends State<SimpananPage> {
  // double? ttlSimpanan;
  ListSimpanan? listSimpanan;
  Future getListSimpanan() async {
    final result = await KopkarJapernosaApi().getSimpanan();
    if (result.status == Status.success) {
      listSimpanan = ListSimpanan.fromJson(result.data!);

      setState(() {
        print("List Simpanan");
        print(result.status);
      });
    }
  }

  ListPenarikan? listPenarikan;
  Future getListPenarikan() async {
    final result = await KopkarJapernosaApi().getPenarikan();
    if (result.status == Status.success) {
      listPenarikan = ListPenarikan.fromJson(result.data!);

      setState(() {
        print("List Penarikan");
        print(result.status);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListSimpanan();
    getListPenarikan();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: "SIMPANAN "),
                Tab(text: "PENARIKAN"),
              ],
            ),
            title: Text("Tabungan Saya"),
          ),
          body: TabBarView(children: [
            listSimpanan == null
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
                    itemCount: listSimpanan!.data!.length,
                    itemBuilder: (contex, index) {
                      final currentListSimpanan = listSimpanan!.data![index];
                      final tglSimpanan = currentListSimpanan.tglPotongan;
                      final jmlSimpanan =
                          double.parse(currentListSimpanan.jumlahSimpanan!);
                      DateTime tanggal = DateTime.parse(tglSimpanan!);

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: ListTile(
                          // leading: Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Container(child: Image.asset(R.assets.icNote)),
                          // ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // "$tglSimpanan",
                                DateFormat("dd-MMM-yyy").format(tanggal),
                                style: TextStyle(
                                    fontSize: 14, color: R.colors.greySubtitle),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment:
                                //     CrossAxisAlignment.start,
                                children: [
                                  // Icon(
                                  //   Icons.cloud_download,
                                  //   color: Colors.blue,
                                  // ),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  Text(
                                    "Simpanan Bulan " +
                                        DateFormat("MMMM yy").format(tanggal),
                                    // "$tglSimpan",
                                    // DateFormat.yMMMEd().format().toString(tglPinjam),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    // "+ Rp. 100.000,00",
                                    "+" +
                                        NumberFormat.currency(
                                                locale: 'id',
                                                symbol: "Rp. ",
                                                decimalDigits: 0)
                                            .format(jmlSimpanan),
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       "Success",
                              //       style: TextStyle(
                              //           color: Colors.green,
                              //           fontSize: 10,
                              //           fontWeight: FontWeight.w600),
                              //     )
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      );
                    }),
            listPenarikan == null
                ? Container(
                    height: 70,
                    width: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    itemCount: listPenarikan!.data!.length,
                    itemBuilder: (contex, index) {
                      final currentPenarikan = listPenarikan!.data![index];
                      final tglAmbil = currentPenarikan.tglPengambilan;
                      final jmlAmbil = currentPenarikan.jumlahPengambilan;
                      final ttdBnd = currentPenarikan.ttdBendahara;
                      final ttdKet = currentPenarikan.ttdKetua;
                      DateTime tanggalAmbil = DateTime.parse(tglAmbil!);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          // leading: Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Container(child: Image.asset(R.assets.icNote)),
                          // ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // "$tglAmbil",
                                DateFormat("dd-MMM-yyy").format(tanggalAmbil),
                                style: TextStyle(
                                    fontSize: 14, color: R.colors.greySubtitle),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment:
                                //     CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tarik dana simpanan",
                                    // "$tglSimpan",
                                    // DateFormat.yMMMEd().format().toString(tglPinjam),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),

                                    // Text('Tanggal ' +
                                    //     listSimpanan!.data![index].tglPotongan!),
                                    // leading: CircleAvatar(
                                    //   child: Icon(Icons.attach_money),
                                    // Text("S", style: TextStyle(fontSize: 20)
                                    //         Image.asset(
                                    //   R.assets.imgUser,
                                    //   height: 50,
                                    //   width: 50,
                                    // )
                                  ),
                                  Spacer(),
                                  Text(
                                    "",
                                    // "- "
                                    // NumberFormat.currency(
                                    //         locale: 'id',
                                    //         symbol: "Rp. ",
                                    //         decimalDigits: 0)
                                    //     .format(jmlAmbil),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment:
                                //     CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "B",
                                    // "$tglSimpan",
                                    // DateFormat.yMMMEd().format().toString(tglPinjam),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  ttdBnd == "Approved"
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 14,
                                        )
                                      : Icon(
                                          Icons.warning_amber_outlined,
                                          color: Colors.amber,
                                          size: 14,
                                        ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "K",
                                    // "$tglSimpan",
                                    // DateFormat.yMMMEd().format().toString(tglPinjam),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  ttdKet == "Approved"
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 14,
                                        )
                                      : Icon(
                                          Icons.warning_amber_outlined,
                                          color: Colors.amber,
                                          size: 14,
                                        ),
                                  Spacer(),
                                  Text(
                                    // "- Rp. 100.000,00",
                                    "- " +
                                        NumberFormat.currency(
                                                locale: 'id',
                                                symbol: "Rp. ",
                                                decimalDigits: 0)
                                            .format(jmlAmbil),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
          ]),
        ));
  }
}
