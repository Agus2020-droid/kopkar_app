import 'package:cool_alert/cool_alert.dart';
import 'package:cupertino_progress_bar/cupertino_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_japernosa/contents/r.dart';
import 'package:kopkar_japernosa/helpers/preference_helper.dart';
import 'package:kopkar_japernosa/models/data_anggota.dart';
import 'package:kopkar_japernosa/models/network_response.dart';
import 'package:kopkar_japernosa/models/saldo_simpanan_anggota.dart';
import 'package:kopkar_japernosa/models/user_login.dart';
import 'package:kopkar_japernosa/repository/kopkar_japernosa_api.dart';
import 'package:kopkar_japernosa/views/login_page.dart';
import 'package:kopkar_japernosa/views/main_page.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';

class TambahPenarikan extends StatefulWidget {
  const TambahPenarikan({Key? key}) : super(key: key);
  @override
  State<TambahPenarikan> createState() => _TambahPenarikanState();
}

class _TambahPenarikanState extends State<TambahPenarikan> {
  final pokokController = TextEditingController();
  final wajibController = TextEditingController();
  final sukaController = TextEditingController();

  Dataku? dataUser;
  getUserData() async {
    final data = await PreferenceHelper().getUserData();
    dataUser = data;
    setState(() {
      print("Profile Page");
      print(dataUser);
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

  double? pokok;
  double? wajib;
  double? suka;
  SaldoSimpananAnggota? saldoSimpananAnggota;
  getSaldo() async {
    final data = await KopkarJapernosaApi().getSaldoSimpanan();
    if (data.status == Status.success) {
      final saldoSimpananAnggota = SaldoSimpananAnggota.fromJson(data.data!);
      // final simpoks = saldoSimpananAnggota.data!.simsuk.toString();
      pokok = double.parse((saldoSimpananAnggota.data!.simpok).toString());
      wajib = double.parse((saldoSimpananAnggota.data!.simwa).toString());
      suka = double.parse((saldoSimpananAnggota.data!.simsuk).toString());
      // final simpok = double.parse(simpoks);
      setState(() {
        // print("simpok");
        // print(pokok);
      });
    }
  }

  initDataUSer() async {
    // pokokController.text = UserEmail.getUserEmail()!;
    // // fullNameController.text = UserEmail.getUserDisplayName()!;
    // final dataUser = await PreferenceHelper().getUserData();
    // fullNameController.text = dataUser!.userName!;
    // schoolNameController.text = dataUser.userAsalSekolah!;
    // JenisPinjam = dataUser.userGender!;
    // // selectedClassTenor = dataUser.jenjang!;
    // print(JenisPinjam);

    //   setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // initDataUSer();
    getUserData();
    getSaldo();
    getDataAnggota();
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
          "Form Penarikan Dana",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ButtonLogin(
            // radius: 8,
            onTap: () async {
              final intPokok = pokokController.text.replaceAll(",", "");
              final intWajib = wajibController.text.replaceAll(",", "");
              final intSuka = sukaController.text.replaceAll(",", "");
              final jumlah = intPokok + intWajib + intSuka;
              DateTime now = new DateTime.now();
              final json = {
                "simpanan_pokok": intPokok,
                "simpanan_wajib": intWajib,
                "simpanan_sukarela": intSuka,
                "jumlah_pengambilan": jumlah,
                "notifikasi": 'Penarikan saldo simpanan',
                "id_user": dataUser!.user!.id,
                "nik_ktp": dataUser!.user!.nikKtp,
                "foto_user": dataUser!.user!.fotoUser,
                "name": dataUser!.user!.name,
              };
              print(json);
              final result = await KopkarJapernosaApi().postPenarikan(json);
              if (result.status == Status.success) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MainPage()));
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    text: "Sukses",
                    autoCloseDuration: Duration(seconds: 2));
              } else {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.error,
                    text: "Gagal",
                    autoCloseDuration: Duration(seconds: 2));
              }
            },
            backgroundColor: R.colors.primary,
            borderColor: R.colors.primary,
            child: Text(
              // R.strings.perbaharuiAkun,
              "Submit",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: pokok == null ||
              wajib == null ||
              suka == null ||
              dataAnggota == null
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
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text("Simpanan Pokok"),
                        Spacer(),
                        Text(
                          // "120000",
                          NumberFormat.currency(
                                  locale: 'id',
                                  symbol: "Rp. ",
                                  decimalDigits: 2)
                              .format(pokok),
                        )
                      ],
                    ),
                    TextField(
                      enabled:
                          dataAnggota!.data!.status == "AKTIF" ? false : true,
                      inputFormatters: [
                        NumberTextInputFormatter(
                          integerDigits: 10,
                          decimalDigits: 0,
                          maxValue: "$pokok",
                          decimalSeparator: '.',
                          groupDigits: 3,
                          groupSeparator: ',',
                          allowNegative: false,
                          overrideDecimalPoint: true,
                          insertDecimalPoint: false,
                          insertDecimalDigits: true,
                        ),
                      ],
                      keyboardType: TextInputType.number,
                      controller: pokokController,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Simpanan Wajib"),
                        Spacer(),
                        Text(
                          // "120000",
                          NumberFormat.currency(
                                  locale: 'id',
                                  symbol: "Rp. ",
                                  decimalDigits: 2)
                              .format(wajib),
                        )
                      ],
                    ),
                    TextField(
                      enabled:
                          dataAnggota!.data!.status == "AKTIF" ? false : true,
                      inputFormatters: [
                        NumberTextInputFormatter(
                          integerDigits: 10,
                          decimalDigits: 0,
                          maxValue: "$wajib",
                          decimalSeparator: '.',
                          groupDigits: 3,
                          groupSeparator: ',',
                          allowNegative: false,
                          overrideDecimalPoint: true,
                          insertDecimalPoint: false,
                          insertDecimalDigits: true,
                        ),
                      ],
                      keyboardType: TextInputType.number,
                      controller: wajibController,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Simpanan Sukarela"),
                        Spacer(),
                        Text(
                          // "120000",
                          NumberFormat.currency(
                                  locale: 'id',
                                  symbol: "Rp. ",
                                  decimalDigits: 2)
                              .format(suka),
                        )
                      ],
                    ),
                    TextField(
                      enabled: true,
                      inputFormatters: [
                        NumberTextInputFormatter(
                          integerDigits: 10,
                          decimalDigits: 0,
                          maxValue: suka == 0 ? "1" : "$suka",
                          decimalSeparator: '.',
                          groupDigits: 3,
                          groupSeparator: ',',
                          allowNegative: false,
                          overrideDecimalPoint: true,
                          insertDecimalPoint: false,
                          insertDecimalDigits: true,
                        ),
                      ],
                      keyboardType: TextInputType.number,
                      controller: sukaController,
                    ),

                    SizedBox(height: 5),

                    Container(
                      color: Colors.amber,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.warning_amber),
                              SizedBox(
                                width: 5,
                              ),
                              Text("PENTING :",
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Text(
                            "Simpanan Pokok dan Simpanan Wajib hanya dapat diambil jika karyawan sudah NON AKTIF dari kepesertaan anggota KOPKAR JAPERNOSA.",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    )

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
