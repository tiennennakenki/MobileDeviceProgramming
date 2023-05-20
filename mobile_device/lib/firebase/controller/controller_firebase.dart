import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile_device/firebase/firebase_data.dart';

class ControllerFirebase extends GetxController{
  final _listSVSN = <LaptopSnapShot>[].obs;

  List<LaptopSnapShot> get listSVSN => _listSVSN.value;

  @override
  void onInit() {
    _listSVSN.bindStream(LaptopSnapShot.getAll2());
  }
}

class ControllerFirebase2 extends GetxController{
  final _listSVSN = <LaptopSnapShot>[].obs;

  List<LaptopSnapShot> get listSVSN => _listSVSN.value;


  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData(){
    LaptopSnapShot.dsLaptopTuFirebaseOneTime()
        .then((value) {
      _listSVSN.value = value;
      _listSVSN.refresh();
    }).catchError((error) {
      print(error);
      _listSVSN.value = [];
      _listSVSN.refresh();
    });
  }
}