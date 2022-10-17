import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_japernosa/contents/r.dart';
import 'package:kopkar_japernosa/models/detail_pinjaman_page.dart';
import 'package:kopkar_japernosa/models/network_response.dart';
import 'package:kopkar_japernosa/repository/kopkar_japernosa_api.dart';

class DetailPinjamanPage extends StatefulWidget {
  const DetailPinjamanPage({Key? key, required this.id}) : super(key: key);
  static String route = "detail_pinjaman_page";
  final int id;
  @override
  State<DetailPinjamanPage> createState() => _DetailPinjamanPageState();
}

class _DetailPinjamanPageState extends State<DetailPinjamanPage> {
  ShowPinjaman? detailPinjaman;
  getDetailPinjaman() async {
    final result = await KopkarJapernosaApi().getPinjamanDetail(widget.id);
    if (result.status == Status.success) {
      detailPinjaman = ShowPinjaman.fromJson(result.data!);
      final showPinjaman = detailPinjaman!.data!;
      setState(() {
        print("detailPinjaman");
        print(showPinjaman);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailPinjaman();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0, centerTitle: true, title: Text("Detail Pinjaman")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
        child: detailPinjaman == null
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
                    itemCount: detailPinjaman!.data!.length,
                    itemBuilder: (context, index) {
                      final currentPinjaman = detailPinjaman!.data![index];
                      final String nomor =
                          currentPinjaman.noPinjaman!.toString();

                      final ttlPinjam = currentPinjaman.totalKredit!;
                      final totalPinjam = ttlPinjam.toString();

                      final jmlAngsuran = currentPinjaman.totalAngsuran;

                      final plaf = currentPinjaman.plafon!;
                      final plafs = plaf.toString();
                      final posisi = currentPinjaman.posisi!;
                      // print(currentPinjaman.jenisPinjaman);
                      return GestureDetector(
                        child: DetailPinjam(
                          no: currentPinjaman.noPinjaman.toString(),
                          jnsPinjaman: currentPinjaman.jenisPinjaman!,
                          jmlkredit: double.tryParse(totalPinjam),
                          tglPinjam: currentPinjaman.tglPengajuan!,
                          nmbrng: currentPinjaman.namaBarang!,
                          posisis: currentPinjaman.posisi!,
                          ttdAdmin: currentPinjaman.statusPengajuan!,
                          ttdHrbp: currentPinjaman.ttdHrbp!,
                          ttdKetua: currentPinjaman.ttdKetua!,
                          plafons: double.parse(plafs),
                          merks: currentPinjaman.merk!,
                          spec: currentPinjaman.spesifikasi!,
                          units: currentPinjaman.unit!,
                          tenors: int.parse(currentPinjaman.tenor!),
                          angsurans: double.parse(currentPinjaman.angsuran!),
                          jmlAngsur: double.parse(jmlAngsuran!),
                          countAngsur:
                              int.parse(currentPinjaman.countAngsuran!),
                          sisa: double.parse(currentPinjaman.sisaAngsuran!),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}

class DetailPinjam extends StatelessWidget {
  const DetailPinjam({
    Key? key,
    this.no,
    this.jnsPinjaman,
    this.jmlkredit,
    this.tglPinjam,
    this.tenors,
    this.nmbrng,
    this.spec,
    this.merks,
    this.plafons,
    this.ttdAdmin,
    this.ttdKetua,
    this.ttdHrbp,
    this.posisis,
    this.jmlAngsur,
    this.units,
    this.countAngsur,
    this.sisa,
    this.angsurans,
  }) : super(key: key);
  final String? jnsPinjaman;
  final double? jmlkredit;
  final String? tglPinjam;
  final int? tenors;
  final double? angsurans;
  final double? sisa;
  final int? countAngsur;
  final String? no;
  final String? spec;
  final String? merks;
  final double? plafons;
  final String? ttdAdmin;
  final String? ttdKetua;
  final String? ttdHrbp;
  final String? nmbrng;
  final String? posisis;
  final double? jmlAngsur;
  final String? units;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      // margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.grey,
          //   offset: const Offset(
          //     5.0,
          //     5.0,
          //   ),
          //   blurRadius: 3.0,
          //   spreadRadius: 1.0,
          // ), //BoxShadow
          // BoxShadow(
          //   color: Colors.white,
          //   offset: const Offset(0.0, 0.0),
          //   blurRadius: 0.0,
          //   spreadRadius: 0.0,
          // ), //BoxShadow
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Tanggal",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Spacer(),
                Text(
                  DateFormat("dd-MMM-yyy").format(DateTime.parse(tglPinjam!)),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Colors.blue),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Nomor Pinjaman",
                ),
                Spacer(),
                Text(
                  "P" + "$no",
                  // "P" + "20",
                ),
              ],
            ),
            Divider(color: Colors.blue),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Jenis Pinjaman",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text("$jnsPinjaman"),
                // Text("Pengembangan"),
              ],
            ),
            Row(
              children: [
                Text(
                  "Nama Barnag/Jasa",
                ),
                Spacer(),

                Text("$nmbrng"),
                // Text("Pengembangan"),
              ],
            ),
            Row(
              children: [
                Text(
                  "Spesifikasi",
                ),
                Spacer(),
                Text("$spec"),
              ],
            ),
            Row(
              children: [
                Text(
                  "Merk",
                ),
                Spacer(),
                Text("$merks"),
              ],
            ),
            Row(
              children: [
                Text(
                  "Unit",
                ),
                Spacer(),
                Text("$units"),
              ],
            ),
            Divider(
              color: Colors.blue,
            ),
            Row(
              children: [
                Text(
                  "Jumlah pengajuan",
                ),
                Spacer(),
                Text(
                  NumberFormat.currency(
                          locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                      .format(plafons),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Kredit Pinjaman",
                ),
                Spacer(),
                Text(
                  // "Belum Lunas",
                  NumberFormat.currency(
                          locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                      .format(jmlkredit),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Angsuran per bulan",
                ),
                Spacer(),
                Text(
                  // "Belum Lunas",
                  NumberFormat.currency(
                          locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                      .format(angsurans),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Angsuran (kali)",
                ),
                Spacer(),
                Text("$countAngsur" + "/" + "$tenors"),
              ],
            ),
            Row(
              children: [
                Text(
                  "Angsuran (Rp)",
                ),
                Spacer(),
                Text(
                  NumberFormat.currency(
                          locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                      .format(jmlAngsur),
                ),
              ],
            ),
            Divider(color: Colors.blue),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Persetujuan ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "Admin Koperasi",
                ),
                Spacer(),
                ttdAdmin == "VERIFIED"
                    ? Row(
                        children: [
                          Text(
                            "$ttdAdmin",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.green),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 14,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            "$ttdAdmin",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.orange),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Colors.orange,
                            size: 16,
                          ),
                        ],
                      )
              ],
            ),
            Row(
              children: [
                Text(
                  "HRBP",
                ),
                Spacer(),
                ttdHrbp == "APPROVED"
                    ? Row(
                        children: [
                          Text(
                            "$ttdHrbp",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.green),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 14,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            "$ttdHrbp",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.orange),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Colors.orange,
                            size: 16,
                          ),
                        ],
                      )
              ],
            ),
            Row(
              children: [
                Text(
                  "Ketua Kopkar",
                ),
                Spacer(),
                ttdKetua == "APPROVED"
                    ? Row(
                        children: [
                          Text(
                            "$ttdKetua",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.green),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 14,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            "$ttdKetua",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.orange),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Colors.orange,
                            size: 16,
                          ),
                        ],
                      )
              ],
            ),
            Divider(color: Colors.blue),
            Row(
              children: [
                Text(
                  "STATUS",
                ),
                Spacer(),
                sisa == 0
                    ? Text(
                        "LUNAS",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.green),
                      )
                    : Text(
                        "BELUM LUNAS",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.red),
                      ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
