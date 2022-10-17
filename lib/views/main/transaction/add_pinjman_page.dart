import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_japernosa/contents/r.dart';
import 'package:kopkar_japernosa/helpers/preference_helper.dart';
import 'package:kopkar_japernosa/models/data_anggota.dart';
import 'package:kopkar_japernosa/models/network_response.dart';
import 'package:kopkar_japernosa/models/user_login.dart';
import 'package:kopkar_japernosa/repository/kopkar_japernosa_api.dart';
import 'package:kopkar_japernosa/views/login_page.dart';
import 'package:kopkar_japernosa/views/main/transaction/pinjaman_page.dart';
import 'package:kopkar_japernosa/views/main_page.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';

class TambahPinjaman extends StatefulWidget {
  const TambahPinjaman({Key? key}) : super(key: key);
  @override
  State<TambahPinjaman> createState() => _TambahPinjamanState();
}

int decimalDigit = 2;

enum JenisPinjam { pengembangan, pinjamanSosial }

enum Pembelian { sendiri, koperasi }

class _TambahPinjamanState extends State<TambahPinjaman> {
  Dataku? dataUser;
  getUserData() async {
    final data = await PreferenceHelper().getUserData();
    dataUser = data;
    setState(() {
      // print("Profile Page");
      // print(dataUser);
    });
  }

  DataAnggota? dataAnggota;
  getDataAnggota() async {
    final dataAnggotaResult = await KopkarJapernosaApi().getPegawai();
    if (dataAnggotaResult.status == Status.success) {
      dataAnggota = DataAnggota.fromJson(dataAnggotaResult.data!);
      // final detailAnggota = dataAnggota!.data.
      setState(() {
        print("Data Anggota");
        print(dataAnggota!.data);
      });
    }
  }

  List<String> classTenor = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12"
  ];
  List<String> classBeli = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12"
  ];
  String jenis = "Pengembangan";
  String selectedClassTenor = "1";
  String beli = "Koperasi";
  String selectedClassBeli = "1";
  final namaBarangController = TextEditingController();
  final merkController = TextEditingController();
  final spesifikasiController = TextEditingController();
  final unitController = TextEditingController();
  final plafonController = TextEditingController();

  onTapJenis(JenisPinjam jenisInput) {
    if (jenisInput == JenisPinjam.pengembangan) {
      jenis = "Pengembangan";
    } else {
      jenis = "Pinjaman Sosial";
    }
    setState(() {});
  }

  onTapBeli(Pembelian beliInput) {
    if (beliInput == Pembelian.sendiri) {
      beli = "Sendiri";
    } else {
      beli = "Koperasi";
    }
    setState(() {});
  }

  // double? angsur;
  // calculateAngsuran() {
  //   int plafons = int.parse(plafonController.text);
  //   // int plafons = 2000000;
  //   int tenors = int.parse(selectedClassTenor);
  //   // int tenors = 5;

  //   final angsurans = (plafons * 0.15 + plafons) / tenors;
  //   final angsur = angsurans.toString();

  //   setState(() {
  //     // print(angsur);
  //   });
  // }

  // double? ttlKredit;
  // double? calculateTotalKredit() {
  //   int plafons = int.parse(plafonController.text);
  //   // int plafons = 2000000;
  //   int tenors = int.parse(selectedClassTenor);
  //   // int tenors = 5;
  //   // if (jenis == "Pengembangan") {
  //   final ttlKredit = (plafons * 0.15 + plafons);
  //   // } else {
  //   // ttlKredit = (plafons * 0.0 + plafons);
  //   // }
  //   setState(() {
  //     print(ttlKredit);
  //   });
  // }

  initDataUSer() async {
    // final dataUser = await PreferenceHelper().getUserData();
    // emailController.text = UserEmail.getUserEmail()!;
    // // fullNameController.text = UserEmail.getUserDisplayName()!;
    // fullNameController.text = dataUser!.userName!;
    // schoolNameController.text = dataUser.userAsalSekolah!;
    // JenisPinjam = jenis;
    // // selectedClassTenor = dataUser.jenjang!;
    // print(jabatan);

    //   setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initDataUSer();
    getUserData();
    getDataAnggota();
    // _calculateAngsuran();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff0f3f5),
      appBar: AppBar(
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(25.0),
        //         bottomRight: Radius.circular(25.0))),
        elevation: 0,
        // backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Form Pengajuan Pinjaman Kredit",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ButtonLogin(
            // radius: 8,
            onTap: () {
              final intStr = plafonController.text.replaceAll(".", "");

              final plaf = double.parse(intStr);
              // print('plafon');
              // print(intStr);
              final ttlKredit = jenis == "Pengembangan"
                  ? plaf * 0.15 + plaf
                  : plaf * 0.0 + plaf;

              final angsur = jenis == "Pengembangan"
                  ? (plaf * 0.15 + plaf) / double.parse(selectedClassTenor)
                  : (plaf * 0.0 + plaf) / double.parse(selectedClassTenor);
              print('ttlKredit');
              print(ttlKredit);
              print('angsur');
              print(angsur);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return new AlertDialog(
                      title: new Text("Konfirmasi Data"),
                      content: Container(
                        height: double.infinity,
                        width: double.infinity,
                        padding: EdgeInsets.all(2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(color: Colors.blue),
                            Text(
                              "Jenis Pinjaman",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: R.colors.primary),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              jenis,
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Nama Barang",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: R.colors.primary),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              namaBarangController.text,
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Merk",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: R.colors.primary),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              merkController.text,
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Spesifikasi",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: R.colors.primary),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              spesifikasiController.text,
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Unit",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: R.colors.primary),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              unitController.text,
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Tenor",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: R.colors.primary),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              selectedClassTenor,
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Plafon",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: R.colors.primary),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: "Rp. ",
                                      decimalDigits: 0)
                                  .format(plaf),
                              // plafonController.text,
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Pembelian oleh",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: R.colors.primary),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              beli,
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Total Kredit",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: R.colors.primary),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: "Rp. ",
                                      decimalDigits: 0)
                                  .format(ttlKredit),
                              // ttlKredit.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Angsuran per bulan",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: R.colors.primary),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: "Rp. ",
                                      decimalDigits: 0)
                                  .format(angsur),
                              // angsur.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Batal')),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Kirim'),
                          onPressed: () async {
                            // Navigator.of(context).pop();
                            final json = {
                              "id_user": dataUser!.user!.id,
                              "nik_ktp": dataUser!.user!.nikKtp,
                              "nama": dataUser!.user!.nama,
                              "nik_karyawan": dataUser!.user!.nikKaryawan,
                              "jabatan": dataUser!.user!.jabatan,
                              "jenis_pinjaman": jenis,
                              "metode": beli,
                              "nama_barang": namaBarangController.text,
                              "merk": merkController.text,
                              "spesifikasi": spesifikasiController.text,
                              "unit": unitController.text,
                              "plafon": plaf,
                              "tenor": selectedClassTenor,
                              "angsuran": angsur,
                              "total_kredit": ttlKredit,
                              "foto_user": dataUser!.user!.fotoUser,
                              "notifikasi": "Pengajuan pinjaman baru",
                              "name": dataUser!.user!.name,
                            };

                            print(json);
                            final result =
                                await KopkarJapernosaApi().postPinjaman(json);
                            if (result.status == Status.success) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MainPage()));
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: "Selamat, pengajuan berhasil dibuat",
                                  autoCloseDuration: Duration(seconds: 2));
                              // Navigator.of(context).pop();

                              // Navigator.pop(context, true);
                              // } else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       content: Text(result.message!),
                              //     ),
                              //   );
                              // }
                            } else {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     content: Text(result.message!),
                              //   ),
                              // );
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: "Gagal dibuat",
                                  autoCloseDuration: Duration(seconds: 2));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Terjadi kesalahan, silahkan ulangi kembali"),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  });
            },
            backgroundColor: R.colors.primary,
            borderColor: R.colors.primary,
            child: Text(
              // R.strings.perbaharuiAkun,
              "Selanjutnya",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // EditProfileTextField(
              //   hintText: '16 ditit nomor KTP',
              //   title: "NIK KTP",
              //   // controller: fullNameController,
              // ),
              // EditProfileTextField(
              //   // controller: emailController,

              //   hintText: 'Nama lengkap anda',
              //   title: "Nama",
              //   enabled: false,
              // ),
              // EditProfileTextField(
              //   hintText: 'NIK Karyawan',
              //   title: "NIK Karyawan",
              //   // controller: fullNameController,
              // ),
              // EditProfileTextField(
              //   hintText: 'Kontrak/Tetap/Mitra',
              //   title: "Status Karyawan",
              //   // controller: fullNameController,
              // ),
              SizedBox(height: 5),
              Text(
                "Jenis Pinjaman",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: R.colors.greySubtitle),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: jenis.toLowerCase() ==
                                  "Pengembangan".toLowerCase()
                              ? R.colors.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                width: 1, color: R.colors.greyBorder),
                          ),
                        ),
                        onPressed: () {
                          onTapJenis(JenisPinjam.pengembangan);
                          // print(JenisPinjam.pengembangan);
                        },
                        child: Text(
                          "Pengembangan",
                          style: TextStyle(
                            fontSize: 12,
                            color: jenis.toLowerCase() ==
                                    "Pengembangan".toLowerCase()
                                ? Colors.white
                                : Color(0xff282828),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: jenis == "Pinjaman Sosial"
                              ? R.colors.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                width: 1, color: R.colors.greyBorder),
                          ),
                        ),
                        onPressed: () {
                          onTapJenis(JenisPinjam.pinjamanSosial);
                          // print(JenisPinjam.pinjamanSosial);
                        },
                        child: Text(
                          "Pinjaman Sosial",
                          style: TextStyle(
                            fontSize: 12,
                            color: jenis == "Pinjaman Sosial"
                                ? Colors.white
                                : Color(0xff282828),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5),
              EditProfileTextField(
                hintText: 'contoh: Handphone..',
                title: "Nama barang/jasa",
                controller: namaBarangController,
              ),
              SizedBox(height: 5),
              EditProfileTextField(
                hintText: 'contoh: Samsung',
                title: "Merk barang",
                controller: merkController,
              ),
              SizedBox(height: 5),
              EditProfileTextField(
                hintText: 'contoh: Galaxy S8',
                title: "Spesifikasi",
                controller: spesifikasiController,
              ),
              SizedBox(height: 5),
              EditProfileTextField(
                hintText: 'contoh: 1 pcs',
                title: "Jumlah unit",
                controller: unitController,
              ),
              SizedBox(height: 5),
              Text(
                "Tenor",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: R.colors.greySubtitle),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // color: Colors.white,
                  border: Border.all(color: R.colors.greyBorder),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      value: selectedClassTenor,
                      items: classTenor
                          .map(
                            (e) => DropdownMenuItem<String>(
                              child: Text(e),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (String? val) {
                        selectedClassTenor = val!;
                        setState(() {});
                      }),
                ),
              ),
              SizedBox(height: 5),
              Text("Plafon Pinjaman"),
              TextField(
                controller: plafonController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  NumberTextInputFormatter(
                    integerDigits: 10,
                    decimalDigits: 0,
                    maxValue: '1000000000',
                    decimalSeparator: ',',
                    groupDigits: 3,
                    groupSeparator: '.',
                    allowNegative: false,
                    overrideDecimalPoint: true,
                    insertDecimalPoint: false,
                    insertDecimalDigits: true,
                  ),
                ],
              ),
              // TextFormField(
              //   controller: plafonController,
              //   validator: (Value) {
              //     if (Value == null || Value.isEmpty) {
              //       return 'Plafon is required';
              //     }
              //   },
              //   decoration: InputDecoration(
              //     // border: OutlineInputBorder(),
              //     labelText: 'Jumlah Plafon',
              //   ),
              //   keyboardType: TextInputType.number,
              //   inputFormatters: <TextInputFormatter>[
              //     FilteringTextInputFormatter.digitsOnly,
              //     CurrencyInputFormatter()
              //   ], //
              // ),
              SizedBox(height: 5),
              Text(
                "Pembelian oleh",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: R.colors.greySubtitle),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary:
                              beli.toLowerCase() == "Koperasi".toLowerCase()
                                  ? R.colors.primary
                                  : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                width: 1, color: R.colors.greyBorder),
                          ),
                        ),
                        onPressed: () {
                          onTapBeli(Pembelian.koperasi);
                        },
                        child: Text(
                          "Koperasi",
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                beli.toLowerCase() == "Koperasi".toLowerCase()
                                    ? Colors.white
                                    : Color(0xff282828),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: beli == "Sendiri"
                              ? R.colors.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                width: 1, color: R.colors.greyBorder),
                          ),
                        ),
                        onPressed: () {
                          onTapBeli(Pembelian.sendiri);
                        },
                        child: Text(
                          "Sendiri",
                          style: TextStyle(
                            fontSize: 14,
                            color: beli.toLowerCase() == "Sendiri".toLowerCase()
                                ? Colors.white
                                : Color(0xff282828),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
    Key? key,
    required this.title,
    required this.hintText,
    this.controller,
    this.enabled = true,
  }) : super(key: key);
  final String title;
  final String hintText;
  final bool enabled;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: R.colors.greySubtitle),
          ),
          SizedBox(height: 5),
          TextField(
            enabled: enabled,
            controller: controller,
            decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: R.colors.greyHintText,
                )),
          ),
        ],
      ),
    );
  }
}
