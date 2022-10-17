import 'package:cupertino_progress_bar/cupertino_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_japernosa/contents/r.dart';
import 'package:kopkar_japernosa/helpers/preference_helper.dart';
import 'package:kopkar_japernosa/models/network_response.dart';
import 'package:kopkar_japernosa/models/sisa_pinjaman.dart';
import 'package:kopkar_japernosa/models/total_simpanan.dart';
import 'package:kopkar_japernosa/models/user_login.dart';
import 'package:kopkar_japernosa/repository/kopkar_japernosa_api.dart';
import 'package:kopkar_japernosa/views/main/transaction/pinjaman_page.dart';
import 'package:kopkar_japernosa/views/main/transaction/shu_saya.dart';
import 'package:kopkar_japernosa/views/main/transaction/simpanan_saya.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dataku? dataUser;
  Future getUserDAta() async {
    dataUser = await PreferenceHelper().getUserData();
    setState(() {
      // print("Data user:");
      // print(dataUser);
    });
  }

  double? ttlSimpanan;
  TotalSimpanan? totalSimpanan;
  Future getTotalSimpan() async {
    final result = await KopkarJapernosaApi().getTotalSimpanan();
    if (result.status == Status.success) {
      totalSimpanan = TotalSimpanan.fromJson(result.data!);
      final saldo = totalSimpanan!.data.toString();
      ttlSimpanan = double.parse(saldo);
      setState(() {
        print("result.status");
        print(result.status);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDAta();
    getTotalSimpan();

    getSisaPinjam();
  }

  @override
  Widget build(BuildContext context) {
    // bool _dark = false;
    double _value = 0.77;
    final name = dataUser!.user!.name;
    final email = dataUser!.user!.email;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(0xff3c8dbc),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'KOPKAR ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Japernosa",
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),

      body: ttlSimpanan == null || sisaKredit == null
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
          : SafeArea(
              child: ListView(
                children: <Widget>[
                  CustomCard(
                      user: dataUser!.user!.name,
                      email: dataUser!.user!.email,
                      foto: dataUser!.user!.fotoPegawai),
                  SizedBox(
                    height: 40,
                  ),
                  BannerCard(),
                  SizedBox(
                    height: 10,
                  ),
                  MenuCard(
                    saldoSimpanan: ttlSimpanan!,
                    saldoPinjaman: sisaKredit!,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 30),
                  //         child: Text("Terbaru",
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold, fontSize: 16)),
                  //       ),
                  //       SizedBox(height: 10),
                  //       // bannerList == null
                  //       //     ? Container(
                  //       //         height: 70,
                  //       //         width: double.infinity,
                  //       //         child: Center(child: CircularProgressIndicator()),
                  //       //       )
                  //       //     :
                  //       Container(
                  //         height: 150,
                  //         child: ListView.builder(
                  //           //content
                  //           itemCount: 2,
                  //           scrollDirection: Axis.horizontal,
                  //           itemBuilder: ((context, index) {
                  //             // final currentBanner = bannerList!.data![index];
                  //             return Padding(
                  //                 padding: const EdgeInsets.only(left: 20.0),
                  //                 child: ClipRRect(
                  //                     borderRadius: BorderRadius.circular(10),
                  //                     child: Image.asset(R.assets.banneHome)));
                  //           }),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),

      //   appBar: AppBar(
      //     centerTitle: true,
      //     title: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         const Text(
      //           'KOPKAR ',
      //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //         ),
      //         Text(
      //           "Japernosa",
      //           style: TextStyle(fontSize: 18),
      //         )
      //       ],
      //     ),
      //     backgroundColor: R.colors.primary,
      //     elevation: 0,
      //   ),
      //   body: Stack(
      //     children: [
      //       ClipPath(
      //         clipper: ClipPathClass(),
      //         child: Container(
      //           height: 320,
      //           color: R.colors.primary,
      //         ),
      //       ),
      //       Container(
      //         // margin: EdgeInsets.only(top: 10),
      //         child: Column(
      //           children: [
      //             Column(
      //               children: [
      //                 Container(
      //                   child: new Stack(
      //                     children: <Widget>[
      //                       Container(
      //                         padding: EdgeInsets.all(15.0),
      //                         height: 80,
      //                         decoration: BoxDecoration(
      //                           color: R.colors.primary,
      //                         ),
      //                       ),
      //                       FractionalTranslation(
      //                         translation: Offset(-0.35, 0.25),
      //                         child: Align(
      //                           child: CircleAvatar(
      //                             backgroundColor: Colors.white,
      //                             minRadius: 10.0,
      //                             child: ClipRRect(
      //                               borderRadius: BorderRadius.circular(15.0),
      //                               child: Image.asset(
      //                                 R.assets.imgLogo,
      //                                 height: 70,
      //                                 width: 70,
      //                               ),
      //                             ),
      //                           ),
      //                           alignment: FractionalOffset(0.5, 0.0),
      //                         ),
      //                       ),
      //                       FractionalTranslation(
      //                         translation: Offset(0.3, 0.6),
      //                         child: Align(
      //                           child: Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Text("Hi," + "$name",
      //                                   style: GoogleFonts.poppins(
      //                                       color: Colors.white,
      //                                       fontSize: 14,
      //                                       fontWeight: FontWeight.w500)),
      //                               Row(
      //                                 // mainAxisAlignment:
      //                                 //     MainAxisAlignment.spaceBetween,
      //                                 children: [
      //                                   Text("$email",
      //                                       style: GoogleFonts.poppins(
      //                                           color: Colors.white,
      //                                           fontSize: 12,
      //                                           fontWeight: FontWeight.w500)
      //                                       // TextStyle(
      //                                       //     color: Colors.white,
      //                                       //     fontSize: 16,
      //                                       //     fontWeight: FontWeight.w700),
      //                                       ),
      //                                 ],
      //                               ),
      //                             ],
      //                           ),
      //                           alignment: FractionalOffset(0.5, 0.0),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 SizedBox(height: 5),
      //                 Container(
      //                   height: 90,
      //                   // width: double.infinity,
      //                   padding: EdgeInsets.symmetric(vertical: 5.0),
      //                   // margin: EdgeInsets.symmetric(horizontal: 20),
      //                   margin: EdgeInsets.all(15),
      //                   decoration: BoxDecoration(
      //                     boxShadow: [
      //                       BoxShadow(
      //                         color: Colors.orange,
      //                         offset: const Offset(
      //                           5.0,
      //                           5.0,
      //                         ),
      //                         blurRadius: 3.0,
      //                         spreadRadius: 1.0,
      //                       ), //BoxShadow
      //                       BoxShadow(
      //                         color: Colors.white,
      //                         offset: const Offset(0.0, 0.0),
      //                         blurRadius: 0.0,
      //                         spreadRadius: 0.0,
      //                       ), //BoxShadow
      //                     ],
      //                     borderRadius: BorderRadius.circular(3),
      //                   ),
      //                   child: Padding(
      //                     padding: const EdgeInsets.only(left: 40, top: 10),
      //                     child: Column(
      //                       children: [
      //                         Row(
      //                           children: [
      //                             Column(
      //                               crossAxisAlignment: CrossAxisAlignment.start,
      //                               children: [
      //                                 Row(
      //                                   children: [
      //                                     Text("Saldo Tabungan",
      //                                         style: GoogleFonts.poppins(
      //                                             color: Colors.blue,
      //                                             fontSize: 18)),
      //                                     SizedBox(
      //                                       width: 8,
      //                                     ),
      //                                     Icon(
      //                                       Icons.verified,
      //                                       size: 16,
      //                                       color: Colors.lightGreen,
      //                                     )
      //                                   ],
      //                                 ),
      //                                 Row(
      //                                   children: [
      //                                     ttlSimpanan == null
      //                                         ? Container(
      //                                             // height: 16,
      //                                             width: double.infinity,
      //                                             child: Center(
      //                                               child:
      //                                                   CircularProgressIndicator(),
      //                                             ),
      //                                           )
      //                                         : Text(
      //                                             // "300000",
      //                                             NumberFormat.currency(
      //                                                     locale: 'id',
      //                                                     symbol: "Rp. ",
      //                                                     decimalDigits: 0)
      //                                                 .format(ttlSimpanan),
      //                                             style: GoogleFonts.poppins(
      //                                                 fontSize: 25),
      //                                           ),
      //                                     Text(",00",
      //                                         style: GoogleFonts.poppins())
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                           ],
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 90,
      //                   padding: EdgeInsets.symmetric(vertical: 5.0),
      //                   // margin: EdgeInsets.symmetric(horizontal: 20),
      //                   margin: EdgeInsets.all(
      //                     15,
      //                   ),
      //                   decoration: BoxDecoration(
      //                     boxShadow: [
      //                       BoxShadow(
      //                         color: Colors.blue,
      //                         offset: const Offset(
      //                           5.0,
      //                           5.0,
      //                         ),
      //                         blurRadius: 3.0,
      //                         spreadRadius: 1.0,
      //                       ), //BoxShadow
      //                       BoxShadow(
      //                         color: Colors.white,
      //                         offset: const Offset(0.0, 0.0),
      //                         blurRadius: 0.0,
      //                         spreadRadius: 0.0,
      //                       ), //BoxShadow
      //                     ],
      //                     borderRadius: BorderRadius.circular(3),
      //                   ),
      //                   child: Padding(
      //                     padding: const EdgeInsets.only(left: 40, top: 10),
      //                     child: Column(
      //                       children: [
      //                         Row(
      //                           children: [
      //                             Container(
      //                               child: Column(
      //                                 crossAxisAlignment:
      //                                     CrossAxisAlignment.start,
      //                                 children: [
      //                                   Row(
      //                                     children: [
      //                                       Text("Pinjaman Kredit",
      //                                           style: GoogleFonts.poppins(
      //                                               color: Colors.black,
      //                                               fontSize: 18)),
      //                                       SizedBox(
      //                                         width: 8,
      //                                       ),
      //                                       Icon(Icons.verified,
      //                                           size: 16, color: Colors.blue)
      //                                     ],
      //                                   ),
      //                                   Row(
      //                                     children: [
      //                                       sisaKredit == null
      //                                           ? Container(
      //                                               // height: 16,
      //                                               width: double.infinity,
      //                                               child: Center(
      //                                                 child:
      //                                                     CircularProgressIndicator(),
      //                                               ),
      //                                             )
      //                                           : Text(
      //                                               // "300000",
      //                                               NumberFormat.currency(
      //                                                       locale: 'id',
      //                                                       symbol: "Rp. ",
      //                                                       decimalDigits: 0)
      //                                                   .format(sisaKredit),
      //                                               style: GoogleFonts.poppins(
      //                                                   fontSize: 25)),
      //                                       Text(",00",
      //                                           style: GoogleFonts.poppins())
      //                                     ],
      //                                   ),
      //                                 ],
      //                               ),
      //                             ),
      //                           ],
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Expanded(
      //               child: Container(
      //                 // color: Colors.purple,
      //                 child: Column(
      //                   children: [
      //                     // body
      //                     Expanded(
      //                       child: ListView(
      //                         padding: EdgeInsets.symmetric(horizontal: 25),
      //                         children: [
      //                           SizedBox(height: 20),
      //                           Text(
      //                             "Pilihan transaksi",
      //                             style: TextStyle(
      //                               fontSize: 16,
      //                               fontWeight: FontWeight.bold,
      //                             ),
      //                           ),
      //                           SizedBox(height: 20),
      //                           Row(
      //                             mainAxisAlignment:
      //                                 MainAxisAlignment.spaceBetween,
      //                             children: [
      //                               GestureDetector(
      //                                 onTap: () {
      //                                   Navigator.of(context).push(
      //                                       MaterialPageRoute(
      //                                           builder: (context) =>
      //                                               SimpananPage()));
      //                                 },
      //                                 child: ItemKategori(
      //                                   title: "Tabungan",
      //                                   icon: "assets/ic_atom.png",
      //                                 ),
      //                               ),
      //                               GestureDetector(
      //                                 onTap: () {
      //                                   Navigator.of(context).push(
      //                                       MaterialPageRoute(
      //                                           builder: (context) =>
      //                                               PinjamanPage()));
      //                                 },
      //                                 child: ItemKategori(
      //                                   title: "Pinjaman",
      //                                   icon: "assets/ic_kimia.png",
      //                                 ),
      //                               ),
      //                               GestureDetector(
      //                                 onTap: () {
      //                                   Navigator.of(context).push(
      //                                       MaterialPageRoute(
      //                                           builder: (context) => ShuPage()));
      //                                 },
      //                                 child: ItemKategori(
      //                                   title: "SHU",
      //                                   icon: "assets/ic_lang.png",
      //                                 ),
      //                               ),
      //                               GestureDetector(
      //                                 onTap: () {
      //                                   Navigator.of(context).push(
      //                                       MaterialPageRoute(
      //                                           builder: (context) =>
      //                                               SimulasiPage()));
      //                                 },
      //                                 child: ItemKategori(
      //                                   title: "Simulasi",
      //                                   icon: "assets/ic_dna.png",
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                           SizedBox(height: 30),
      //                           Row(
      //                             crossAxisAlignment: CrossAxisAlignment.end,
      //                             mainAxisAlignment:
      //                                 MainAxisAlignment.spaceBetween,
      //                             children: [
      //                               Text(
      //                                 "Terbaru dari Kopkar",
      //                                 style: TextStyle(
      //                                   fontSize: 16,
      //                                   fontWeight: FontWeight.bold,
      //                                 ),
      //                               ),
      //                               Text(
      //                                 "Lihat Semua",
      //                                 style: TextStyle(
      //                                   fontSize: 12,
      //                                   color: Colors.red,
      //                                   fontWeight: FontWeight.bold,
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                           SizedBox(height: 20),
      //                           SingleChildScrollView(
      //                             scrollDirection: Axis.horizontal,
      //                             child: Row(
      //                               children: [
      //                                 ItemTerbaru(
      //                                   image: "assets/img_banner.png",
      //                                 ),
      //                                 ItemTerbaru(
      //                                   image: "assets/img_banner.png",
      //                                 ),
      //                                 ItemTerbaru(
      //                                   image: "assets/img_banner.png",
      //                                 ),
      //                                 ItemTerbaru(
      //                                   image: "assets/img_banner.png",
      //                                 ),
      //                                 ItemTerbaru(
      //                                   image: "assets/img_banner.png",
      //                                 ),
      //                                 ItemTerbaru(
      //                                   image: "assets/img_banner.png",
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                           SizedBox(height: 30),
      //                         ],
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // );
    );
  }
}

class BannerCard extends StatelessWidget {
  const BannerCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              R.colors.primary,
              Colors.lightBlue.shade50,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            // stops: [0.5, 0.9]
          ),
          // color: R.colors.primary,
          borderRadius: BorderRadius.circular(20)),
      height: 147,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            child: Text(
              "Cek saldo simpanan atau transaksi kini lebih mudah.",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            right: 13,
            bottom: 13,
            child: Image.asset(
              R.assets.imgLogo,
              width: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// class ItemTerbaru extends StatelessWidget {
//   ItemTerbaru({
//     Key? key,
//     required this.image,
//   }) : super(key: key);

//   final String image;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(right: 20),
//       // width: Get.width * 0.7,
//       width: 100,
//       height: 100,
//       decoration: BoxDecoration(
//         color: Colors.amber,
//         borderRadius: BorderRadius.circular(20),
//         image: DecorationImage(
//           image: AssetImage(image),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }

// class ItemKategori extends StatelessWidget {
//   ItemKategori({
//     Key? key,
//     required this.title,
//     required this.icon,
//   }) : super(key: key);

//   final String title;
//   final String icon;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           width: 50,
//           height: 50,
//           child: Image.asset(
//             icon,
//             fit: BoxFit.cover,
//           ),
//         ),
//         SizedBox(height: 10),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ClipInfoClass extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height);
//     path.lineTo(size.width - 80, size.height);
//     path.lineTo(size.width, size.height - 80);
//     path.lineTo(size.width, 0);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }

// class ClipPathClass extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height - 60);
//     path.quadraticBezierTo(
//       size.width / 2,
//       size.height,
//       size.width,
//       size.height - 60,
//     );
//     path.lineTo(size.width, 0);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }

class MenuCard extends StatelessWidget {
  const MenuCard({
    Key? key,
    required this.saldoSimpanan,
    required this.saldoPinjaman,
  }) : super(key: key);

  final double saldoSimpanan;
  final double saldoPinjaman;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text("Pilihan Menu"),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.save_alt_rounded,
              size: 40,
              color: Colors.blue,
            ),
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SimpananPage()));
                  },
                  child: Text('SIMPANAN',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                // SizedBox(
                //   width: 5,
                // ),
                // Icon(
                //   Icons.verified,
                //   color: Colors.blue,
                // )
              ],
            ),
            subtitle: Row(
              children: [
                Text(
                  NumberFormat.currency(
                          locale: 'id', symbol: "Rp. ", decimalDigits: 0)
                      .format(saldoSimpanan),
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SimpananPage()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.keyboard_double_arrow_right,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Detail",
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.handshake_rounded,
              size: 40,
              color: Colors.amber,
            ),
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PinjamanPage()));
                  },
                  child: Text('PINJAMAN',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                // SizedBox(
                //   width: 5,
                // ),
                // Icon(
                //   Icons.verified,
                //   color: Colors.green,
                // )
              ],
            ),
            subtitle: Row(
              children: [
                Text(
                  NumberFormat.currency(
                          locale: 'id', symbol: "Rp. ", decimalDigits: 0)
                      .format(saldoPinjaman),
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PinjamanPage()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.keyboard_double_arrow_right,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Detail",
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.control_camera,
              size: 40,
              color: Colors.red,
            ),
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ShuPage()));
                  },
                  child: Text('SHU ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                // SizedBox(
                //   width: 5,
                // ),
                // Icon(
                //   Icons.verified,
                //   color: Colors.green,
                // )
              ],
            ),
            subtitle: Row(
              children: [
                Text("Cek SHU Anda"),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ShuPage()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.keyboard_double_arrow_right,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Detail",
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // child: ListView(children: <Widget>[
      //   ListTile(
      //     leading: Icon(Icons.local_activity, size: 50),
      //     title: Text('Activity'),
      //     subtitle: Text('Description here'),
      //   ),
      //   ListTile(
      //     leading: Icon(Icons.local_airport, size: 50),
      //     title: Text('Airport'),
      //     subtitle: Text('Description here'),
      //   ),
      //   ListTile(
      //     leading: Icon(Icons.local_atm, size: 50),
      //     title: Text('ATM'),
      //     subtitle: Text('Description here'),
      //   ),
      //   ListTile(
      //     leading: Icon(Icons.local_bar, size: 50),
      //     title: Text('Bar'),
      //     subtitle: Text('Description here'),
      //   ),
      // ]),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({
    Key? key,
    this.user,
    this.email,
    this.foto,
  }) : super(key: key);

  var _opacity = 0.2;
  var _xOffset = 4.0;
  var _yOffset = 8.0;
  var _blurRadius = 8.0;
  var _spreadRadius = 0.5;
  final String? user;
  final String? email;
  final String? foto;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        child: new Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              height: 80,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, _opacity),
                    offset: Offset(_xOffset, _yOffset),
                    blurRadius: _blurRadius,
                    spreadRadius: _spreadRadius,
                  )
                ],
                color: R.colors.primary,
                //     gradient: LinearGradient(
                //   colors: [
                //     Colors.lightBlue.shade50,
                //     Color(0xff3c8dbc),
                //   ],
                //   begin: Alignment.centerLeft,
                //   end: Alignment.centerRight,
                //   // stops: [0.5, 0.9]
                // )
              ),
            ),
            FractionalTranslation(
              translation: Offset(-0.35, 0.5),
              child: Align(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35.0,
                  child: Image.asset(
                    R.assets.imgLogo,
                    //   Image.network(
                    // 'https://kopkar.japernosa.com/public/public/foto_user/$foto',
                    height: 70,
                    width: 70,
                  ),
                ),
                alignment: FractionalOffset(0.5, 0.0),
              ),
            ),
            FractionalTranslation(
              translation: Offset(0.3, 0.7),
              child: Align(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, $user',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '$email',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                alignment: FractionalOffset(0.5, 0.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
