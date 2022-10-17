import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_japernosa/contents/r.dart';
import 'package:kopkar_japernosa/models/list_shu.dart';
import 'package:kopkar_japernosa/models/network_response.dart';
import 'package:kopkar_japernosa/repository/kopkar_japernosa_api.dart';
import 'package:kopkar_japernosa/views/main/transaction/detail_pinjaman.dart';
import 'package:kopkar_japernosa/views/main/transaction/detail_shu.dart';

class ShuPage extends StatefulWidget {
  const ShuPage({Key? key}) : super(key: key);

  @override
  State<ShuPage> createState() => _ShuPageState();
}

class _ShuPageState extends State<ShuPage> {
  ListShu? listShu;
  Future getShu() async {
    final listShuResult = await KopkarJapernosaApi().getShu();
    if (listShuResult.status == Status.success) {
      listShu = ListShu.fromJson(listShuResult.data!);
      setState(() {
        print("Data SHU");
        print(listShu!.data);
      });
    }
    setState(() {
      // print("Data user:");
      // print(dataUser);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("SHU Saya")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: listShu == null
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
                itemCount: listShu!.data!.length,
                itemBuilder: (context, index) {
                  final currentShu = listShu!.data![index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailShuPage(id: currentShu.idShu!),
                          ),
                        );
                      },
                      child: ShuWidget(
                        jmlShu: double.parse(currentShu.jumlahShu!),
                        tglShu: currentShu.tglShu!,
                        shuId: currentShu.idShu!,
                        noRek: currentShu.noRek!,
                        nmBank: currentShu.namaBank!,
                      ));
                }),
      ),
    );
  }
}

class ShuWidget extends StatelessWidget {
  const ShuWidget({
    Key? key,
    // this.jumlahShu,
    this.shuId,
    this.jmlShu,
    this.tglShu,
    this.noRek,
    this.nmBank,
  }) : super(key: key);

  // final String? jumlahShu;
  final double? jmlShu;
  final String? noRek;
  final String? nmBank;
  final int? shuId;
  final String? tglShu;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 21),
      child: Row(
        children: [
          Container(
            height: 53,
            width: 53,
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
                color: R.colors.grey, borderRadius: BorderRadius.circular(10)),
            child: Image.asset(R.assets.icAtom),
          ),
          SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$nmBank",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: R.colors.greySubtitleHome),
                    ),
                    Text(
                      "Tanggal : " + "$tglShu",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: R.colors.greySubtitleHome),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$noRek",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      // "Rp. $jmlShu",
                      NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 0)
                          .format(jmlShu),

                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Stack(
                  children: [
                    Container(
                      height: 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: R.colors.primary,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 100,
                          child: Container(
                            height: 5,
                            width: MediaQuery.of(context).size.width * 1,
                            decoration: BoxDecoration(
                                color: R.colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
