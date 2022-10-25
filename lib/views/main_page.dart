import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kopkar_japernosa/contents/r.dart';
import 'package:kopkar_japernosa/helpers/preference_helper.dart';
import 'package:kopkar_japernosa/models/data_anggota.dart';
import 'package:kopkar_japernosa/models/network_response.dart';
import 'package:kopkar_japernosa/models/piutang.dart';
import 'package:kopkar_japernosa/models/sisa_pinjaman.dart';
import 'package:kopkar_japernosa/models/user_login.dart';
import 'package:kopkar_japernosa/repository/kopkar_japernosa_api.dart';
import 'package:kopkar_japernosa/views/login_page.dart';
import 'package:kopkar_japernosa/views/main/profile/profile_page.dart';
import 'package:kopkar_japernosa/views/main/transaction/add_penarikan_page.dart';
import 'package:kopkar_japernosa/views/main/transaction/add_pinjman_page.dart';
import 'package:kopkar_japernosa/views/main/transaction/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);
  static String route = "main_page";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pc = PageController();
  int index = 0;

  Dataku? user;
  getUserData() async {
    final data = await PreferenceHelper().getUserData();
    user = data;
    setState(() {
      // print("Profile Page");
      // print(user);
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

  double? sisaKredit;
  SisaPinjaman? sisaPinjaman;
  Future getSisaPinjam() async {
    final result = await KopkarJapernosaApi().getSisaPinjaman();
    if (result.status == Status.success) {
      sisaPinjaman = SisaPinjaman.fromJson(result.data!);
      int intValue = sisaPinjaman!.data!;
      sisaKredit = intValue.toDouble();

      setState(() {
        print(sisaKredit);
      });
    }
  }

  Piutang? piutang;
  Future getSisaPiutang() async {
    final result = await KopkarJapernosaApi().getPiutang();
    if (result.status == Status.success) {
      piutang = Piutang.fromJson(result.data!);

      // sisaPiutang = intValue.toDouble();

      setState(() {
        // print(sisaPiutang);
      });
    }
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token_key';
    final value = prefs.get(key) ?? null;
    print("KEY :");
    print(prefs);
    if (value != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => new MainPage()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getSisaPinjam();
    getDataAnggota();
    getSisaPiutang();
    read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child:
            // Image.asset(
            //   R.assets.icDiscuss,
            //   width: 30,
            // ),
            Icon(Icons.business_center),
        onPressed: () {
          final statusAnggota = dataAnggota!.data!.status;
          showModalBottomSheet(
              context: context,
              builder: (builder) {
                return Container(
                  height: 350,
                  color: R.colors.primary,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pilih Transaksi",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ListTile(
                        leading: new Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        title: new Text(
                          "Pengajuan Pinjaman",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          print("Sisa Piutang");
                          print(piutang!.data);
                          if (dataAnggota!.data!.status != "AKTIF" &&
                              piutang!.data != 0) {
                            _showDialogStatus(context);
                          } else if (dataAnggota!.data!.status != "AKTIF" &&
                              piutang!.data == 0) {
                            _showDialogStatus(context);
                          } else if (dataAnggota!.data!.status == "AKTIF" &&
                              piutang!.data != 0) {
                            _showDialogPiutang(context);
                          } else {
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TambahPinjaman()));
                          }
                          ;
                        },
                      ),
                      ListTile(
                        leading: new Icon(
                          Icons.cloud_download,
                          color: Colors.white,
                        ),
                        title: new Text(
                          "Penarikan Simpanan",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.pop(context);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TambahPenarikan()));
                        },
                      ),
                    ],
                  ),
                );
              });
          // user!.user!.status == "AKTIF" && sisaPinjaman == 0
          //     ?
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => TambahPinjaman()));
          // : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //     backgroundColor: Colors.red,
          //     content: Text(
          //       "Maaf, Anda belum bisa melakukan transaksi ini. Silahkan hubungi Admin kopkar",
          //       style: TextStyle(color: Colors.white),
          //     )));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigation(),
      body: PageView(
        controller: _pc,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomePage(), //0
          // ChatPage(),
          ProfilePage(), //1
        ],
      ),
    );
  }

  Container _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 20,
            color: Colors.black.withOpacity(0.06))
      ]),
      child: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        // print("Home");
                        index = 0;
                        _pc.animateToPage(index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.bounceInOut);
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.home,
                            size: 30,
                            color: index == 0 ? Colors.blue : Colors.grey,
                          ),
                          // Image.asset(
                          //   R.assets.icHome,
                          //   height: 30,
                          //   color: index == 0 ? null : Colors.grey,
                          // ),
                          Text(
                            "Home",
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 37.0),
                  child: Material(
                    child: InkWell(
                      child: Column(
                        children: [
                          // Image.asset(
                          //   R.assets.icNote,
                          //   height: 30,
                          // ),
                          Text("Pengajuan")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        // print("Profile");
                        index = 1;
                        _pc.animateToPage(index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          // Icon(
                          //   Icons.account_circle,
                          //   size: 30,
                          //   color: index == 1 ? Colors.blue : Colors.grey,
                          // ),
                          Image.asset(
                            R.assets.imgLogoTrans,
                            height: 30,
                            color: index == 1 ? null : Colors.grey,
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    ),
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

void _showDialogStatus(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.red,
        title: new Text(
          "Alert!!",
          style: TextStyle(color: Colors.white),
        ),
        content: new Text(
          "Status kepesertaan Anda NON AKTIF",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          new ElevatedButton(
            child: new Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _showDialogPiutang(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.red,
        title: new Text(
          "Maaf !",
          style: TextStyle(color: Colors.white),
        ),
        content: new Text(
          "Pinjaman Anda sebelumnya Belum LUNAS atau pengajuan dalam tahap PROSES. Terima kasih  ",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          new ElevatedButton(
            child: new Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
