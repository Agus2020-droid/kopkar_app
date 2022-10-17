import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_japernosa/contents/r.dart';
import 'package:kopkar_japernosa/helpers/preference_helper.dart';
import 'package:kopkar_japernosa/models/data_anggota.dart';
import 'package:kopkar_japernosa/models/network_response.dart';
import 'package:kopkar_japernosa/models/user_login.dart';
import 'package:kopkar_japernosa/repository/kopkar_japernosa_api.dart';
import 'package:kopkar_japernosa/views/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getDataAnggota();
  }

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: R.colors.primary,
          elevation: 0,
          title: Text("Akun Saya"),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () async {
                  // final result = await Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (BuildContext context) {
                  //   return EditProfilePage();
                  // }));
                  // print("result");
                  // print(result);
                  // if (result == true) {
                  //   getUserData();
                  // }
                },
                child: Text("", style: TextStyle(color: Colors.white)))
          ],
        ),
        body: dataAnggota == null
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
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 28, bottom: 50, left: 25, right: 15),
                        decoration: BoxDecoration(
                            color: R.colors.primary,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(9),
                                bottomRight: Radius.circular(9))),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "" + (dataUser?.user!.nama ?? "Fulan"),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "" +
                                        (dataUser?.user!.email ??
                                            "example@gmail.com"),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 30),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  'https://kopkar.japernosa.com/public/public/foto_user/${dataAnggota!.data!.fotoPegawai}',
                                  fit: BoxFit.cover,
                                  height: 70,
                                  width: 70,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.25))
                            ]),
                        margin:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 13),
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Identitas Diri",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Status kepesertaan",
                                style: TextStyle(
                                    color: R.colors.greySubtitleHome,
                                    fontSize: 12)),
                            SizedBox(height: 5),
                            // dataAnggota.datau == "AKTIF"
                            //     ? Row(
                            //         children: [
                            //           Icon(
                            //             Icons.verified,
                            //             color: Colors.green,
                            //             size: 20,
                            //           ),
                            //           SizedBox(
                            //             width: 5,
                            //           ),
                            //           Text(
                            //             (dataUser?.user!.status ?? "none"),
                            //             style: TextStyle(
                            //                 color: Colors.black,
                            //                 fontSize: 14,
                            //                 fontWeight: FontWeight.w400),
                            //           ),
                            //         ],
                            //       )
                            // :
                            dataAnggota!.data!.status == "AKTIF"
                                ? Row(
                                    children: [
                                      Icon(
                                        Icons.verified,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        (dataAnggota!.data!.status ?? "none"),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        (dataAnggota!.data!.status ?? "none"),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                            SizedBox(height: 10),
                            Text(
                              "NIK KARYAWAN",
                              style: TextStyle(
                                  color: R.colors.greySubtitleHome,
                                  fontSize: 12),
                            ),
                            SizedBox(height: 5),
                            Text(
                              // "123345556",
                              (dataUser!.user!.nikKaryawan ?? "Fulan"),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Nama Lengkap",
                              style: TextStyle(
                                  color: R.colors.greySubtitleHome,
                                  fontSize: 12),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "" + (dataUser!.user!.nama ?? "Fulan"),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Tempat tanggal lahir",
                              style: TextStyle(
                                  color: R.colors.greySubtitleHome,
                                  fontSize: 12),
                            ),
                            SizedBox(height: 5),
                            Text(
                              (dataAnggota!.data!.tempatLahir ?? "Wonosobo") +
                                  "," +
                                  (dataAnggota!.data!.tglLahir ?? "12-12-1985"),
                              // formatDate(
                              //     tgllahir, [dd, '-', mm, '-', yyyy]),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Alamat",
                              style: TextStyle(
                                  color: R.colors.greySubtitleHome,
                                  fontSize: 12),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "" + (dataAnggota!.data!.alamat ?? "kretek"),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Nomor Handphone",
                              style: TextStyle(
                                  color: R.colors.greySubtitleHome,
                                  fontSize: 12),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "" + (dataUser?.user!.telp ?? "0000000000"),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showDialog(context);
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 13),
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 7,
                                  color: Colors.black.withOpacity(0.25))
                            ],
                          ),
                          child: Row(children: [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "LOGOUT",
                              style: TextStyle(
                                color: Colors.white,
                                // fontSize: 12,
                              ),
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Alert!!"),
        content: new Text("Yakin akan keluar dari aplikasi ?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // BottomsheetConfirmation();
              final pref = await SharedPreferences.getInstance();
              final result = await KopkarJapernosaApi().postLogout();
              if (result.status == Status.success) pref.clear();
              print(result.data);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
