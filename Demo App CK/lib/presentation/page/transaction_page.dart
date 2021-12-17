import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demoappck/presentation/page/bang_gia.dart';
import 'package:demoappck/core/implements/http_client.dart';

class TransactionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransactionPageStage();
}

class _TransactionPageStage extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đặt lệnh'),
        leading: new IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => BangGiaPage()));
            },
            icon: new Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              child: Center(
                child: Text(
                  'VCB',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),
            ),
            itemsRow('Mua/Bán', 'Mua'),
            SizedBox(
              height: 10,
            ),
            itemsRow('Loại GD', 'Thường'),
            SizedBox(
              height: 10,
            ),
            itemsRow('Khối lượng', '1000'),
            SizedBox(
              height: 10,
            ),
            itemsRow('Giá', '99.9'),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              onPressed: () {
                //get tranID
                RestClient().createTrans().then((tranID) {
                  print('tranId: $tranID');
                  showSuccessDialog("Thông báo",
                      "Vui lòng xác nhận giao dịch trên ứng dụng VNPT SmartCA");
                });
              },
              child: Text(
                'Xác nhận',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }

  Widget itemsRow(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              maxLines: 2,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }

  void showSuccessDialog(String title, String mesg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: mesg,
                      children: [
                        TextSpan(
                          text: '',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Xác nhận',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          );
        });
  }
}
