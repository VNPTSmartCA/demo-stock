import 'package:demoappck/services/VNPTSmartCAChannel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demoappck/presentation/page/bang_gia.dart';
import 'package:demoappck/core/implements/http_client.dart';

class TransactionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransactionPageStage();
}

class _TransactionPageStage extends State<TransactionPage> {

  late int status;
  late String message;



  @override
  void initState() {
    super.initState();

    VNPTSmartCAChannel.platformResult.setMethodCallHandler((call) => VNPTSmartCAChannel.instance.receiveFromNative(call).then((value) => {
      if (value["status"] == "0") {
        if (value["message"] == "REJECT_SUCCESS") {
          showSuccessDialog("Thông báo", "Đã hủy giao dịch", "1")
        } else {
          showSuccessDialog("Thông báo", "Giao dịch thành công", value["status"])
        }
      } else {
        showSuccessDialog("Thông báo", "Đã có lỗi xảy ra. Vui lòng thử lại", value["status"])
      }
    }));
  }

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
            ElevatedButton(
              onPressed: () {
                RestClient().createTrans().then((tranID) {
                  VNPTSmartCAChannel.instance
                      .requestMapping(tranID, "partnerStockVNPTSmartCA");
                });
              },
              child: Text(
                'Xác nhận',
                style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
              ),
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

  void showSuccessDialog(String title, String msg, String status) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Wrap(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Icon(status == "0" ? Icons.check_circle : Icons.cancel, size: 100, color: status == "0" ? Colors.lightGreen : Colors.redAccent,),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 8,
                      ),
                      child: Text(msg, style: Theme.of(context).textTheme.bodyText2, textAlign: TextAlign.center,),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Đóng',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
                        ),
                        // color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                )
              ],
            ),
          );
        });
  }
}
