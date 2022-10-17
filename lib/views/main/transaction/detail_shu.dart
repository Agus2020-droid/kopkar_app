import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_japernosa/contents/r.dart';
import 'package:kopkar_japernosa/models/detail_shu.dart';
import 'package:kopkar_japernosa/models/network_response.dart';
import 'package:kopkar_japernosa/repository/kopkar_japernosa_api.dart';

class DetailShuPage extends StatefulWidget {
  const DetailShuPage({Key? key, required this.id}) : super(key: key);
  static String route = "detail_shu_page";
  final int id;
  @override
  State<DetailShuPage> createState() => _DetailShuPageState();
}

class _DetailShuPageState extends State<DetailShuPage> {
  DetailShu? detailShu;
  getDetailShu() async {
    final result = await KopkarJapernosaApi().getShuDetail(widget.id);
    if (result.status == Status.success) {
      detailShu = DetailShu.fromJson(result.data!);

      setState(() {
        print("detailPinjaman");
        print(detailShu);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailShu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(elevation: 0, centerTitle: true, title: Text("Detail SHU")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
        child: detailShu == null
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
            : Container(
                child: ListView.builder(
                    itemCount: detailShu!.data!.length,
                    itemBuilder: (context, index) {
                      final currentShu = detailShu!.data![index];
                      return GestureDetector(
                        child: ShowShu(
                          jmlShu: double.parse(currentShu.jumlahShu!),
                          tglShu: currentShu.tglShu!,
                          shuId: currentShu.idShu!,
                          noRek: currentShu.noRek!,
                          nmBank: currentShu.namaBank!,
                          peranbljwn:
                              double.parse(currentShu.peranBelanjaWanamart!),
                          peransmpwn:
                              double.parse(currentShu.peranSimpananWanamart!),
                          lainlain: double.parse(currentShu.lainLain!),
                          perankrd: double.parse(currentShu.peranKredit!),
                          peransmp: double.parse(currentShu.peranSimpanan!),
                          perngurus: double.parse(currentShu.pengurus!),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}

class ShowShu extends StatelessWidget {
  const ShowShu({
    Key? key,
    this.jmlShu,
    this.noRek,
    this.nmBank,
    this.shuId,
    this.tglShu,
    this.peranbljwn,
    this.lainlain,
    this.peransmpwn,
    this.perankrd,
    this.peransmp,
    this.perngurus,
  }) : super(key: key);
  final double? jmlShu;
  final String? noRek;
  final String? nmBank;
  final int? shuId;
  final String? tglShu;
  final double? peranbljwn;
  final double? lainlain;
  final double? peransmpwn;
  final double? perankrd;
  final double? peransmp;
  final double? perngurus;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: R.colors.primary,
          // height: 30,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Tanggal",
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  Spacer(),
                  Text(
                    // "$tglShu",
                    DateFormat("dd MMM yyy").format(DateTime.parse(tglShu!)),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "Nomor SHU",
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  Text(
                    "P-" + "$shuId",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Nama Bank",
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  Text(
                    "$nmBank",
                    style: TextStyle(color: Colors.white),
                  ),
                  // Text("Pengembangan"),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "No. Rekening",
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),

                  Text(
                    "$noRek",
                    style: TextStyle(color: Colors.white),
                  ),
                  // Text("Pengembangan"),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 5, left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                offset: const Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 2.0,
                spreadRadius: 1.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Keterangan Detail",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "Nominal",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "1. SHU Peran Wanamart (Belanja)",
                    ),
                    Spacer(),
                    Text(
                      // "$peranbljwn"
                      NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                          .format(peranbljwn),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "2. SHU Peran Wanamart (Simpanan)",
                    ),
                    Spacer(),
                    Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                          .format(peransmpwn),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "3. SHU Japernosa Water & Fotocopy",
                    ),
                    Spacer(),
                    Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                          .format(lainlain),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "4. SHU Peran Kredit Pinjaman",
                    ),
                    Spacer(),
                    Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                          .format(perankrd),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "5. SHU Peran Kredit dari Simpanan",
                    ),
                    Spacer(),
                    Text(
                      // "Belum Lunas",
                      NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                          .format(peransmp),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "6. SHU Peran Pengurus",
                    ),
                    Spacer(),
                    Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                          .format(perngurus),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.red,
                ),
                Row(
                  children: [
                    Text(
                      "JUMLAH SHU (Rp)",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    Spacer(),
                    Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                          .format(jmlShu),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
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
  }
}
