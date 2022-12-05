import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:kopkar_japernosa/contents/r.dart';
import 'package:kopkar_japernosa/models/list_angsuran.dart';
import 'package:kopkar_japernosa/models/network_response.dart';
import 'package:kopkar_japernosa/repository/kopkar_japernosa_api.dart';

class AngsuranPage extends StatefulWidget {
  const AngsuranPage({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<AngsuranPage> createState() => _AngsuranPageState();
}

class _AngsuranPageState extends State<AngsuranPage> {
  ListAngsuran? listAngsuran;
  getDataAngsur() async {
    final resultlistAngsuran =
        await KopkarJapernosaApi().getAngsuran(widget.id);
    if (resultlistAngsuran.status == Status.success) {
      listAngsuran = ListAngsuran.fromJson(resultlistAngsuran.data!);
      final angsuran = listAngsuran!.data!;
      setState(() {
        print("Angsuran");
        print(listAngsuran);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataAngsur();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detail Angsuran"),
      ),
      body: listAngsuran == null
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
              itemCount: listAngsuran!.data!.length,
              itemBuilder: (context, index) {
                final currentAngsuran = listAngsuran!.data![index];
                final jml = double.parse(currentAngsuran.jumlahAngsuran!);
                final tglAngsur = currentAngsuran.tglAngsuran;
                return Padding(
                    padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: ListTile(
                      leading: const Icon(
                        Icons.flag_circle,
                        color: Colors.blue,
                        size: 30,
                      ),
                      trailing: Text(
                        // "GFG",
                        NumberFormat.currency(
                                locale: 'id', symbol: "Rp. ", decimalDigits: 2)
                            .format(jml),
                        style: TextStyle(color: Colors.blue, fontSize: 13),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              DateFormat("dd-MMM-yyy")
                                  .format(DateTime.parse(tglAngsur!)),
                              style:
                                  TextStyle(color: R.colors.greySubtitleHome)),
                          Text(
                            DateFormat("MMMM yy")
                                .format(DateTime.parse(tglAngsur)),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ));
              }),
    );
  }
}
