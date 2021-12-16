import 'package:flutter/material.dart';
import 'package:demoappck/presentation/page/transaction_page.dart';

class BangGiaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BangGiaState();
}

class _BangGiaState extends State<BangGiaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bảng giá"),
      ),
      body: Column(
        children: [
          Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(),
              2: FixedColumnWidth(50),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: <Widget>[
                  Container(
                    height: 42,
                    width: 128,
                    child: Center(
                      child: Text(
                        'Mã CK',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      child: Text(
                        'Khớp',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      child: Text(
                        '+/-',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Khối lượng',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableRowInkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TransactionPage()));
                    },
                    child: Container(
                      height: 42,
                      width: 128,
                      child: Center(
                        child: Text(
                          'VCB',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      child: Text(
                        '99.9',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      child: Text(
                        '5.5%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      '12.000.000',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  void showAlertMesg(String mesg) {
    showDialog(
        context: context,
        builder: (context) {
          return Container();
        });
  }
}
