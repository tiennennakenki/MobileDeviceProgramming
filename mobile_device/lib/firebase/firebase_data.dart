import 'package:cloud_firestore/cloud_firestore.dart';

class Laptop{
  String? ten, thuongHieu, moTa, hinhAnh, gia;


  Laptop({this.ten, this.thuongHieu, this.moTa, this.hinhAnh, this.gia});

  Map<String, dynamic> toJson() {
    return {
      'ten': this.ten,
      'thuongHieu': this.thuongHieu,
      'moTa': this.moTa,
      'hinhAnh': this.hinhAnh,
      'gia': this.gia,
    };
  }

  factory Laptop.fromJson(Map<String, dynamic> map) {
    return Laptop(
      ten: map['ten'] as String,
      thuongHieu: map['thuongHieu'] as String,
      moTa: map['moTa'] as String,
      hinhAnh: map['hinhAnh'] as String,
      gia: map['gia'] as String,
    );
  }
}

class LaptopSnapShot{
  Laptop? laptop;
  DocumentReference? documentReference;

  LaptopSnapShot({
    required this.laptop,
    required this.documentReference
  });

  factory LaptopSnapShot.fromSnapShot(DocumentSnapshot docSnapLaptop){
    return LaptopSnapShot(
        laptop: Laptop.fromJson(docSnapLaptop.data() as Map<String, dynamic>),
        documentReference: docSnapLaptop.reference
    );
  }

  Future<void> capNhat(Laptop lt) async{
    return documentReference!.update(lt.toJson());
  }

  Future<void> xoa() async {
    return documentReference!.delete();
  }

  static Future<DocumentReference> themMoi(Laptop lt) async {
    return FirebaseFirestore.instance.collection("Laptop").add(lt.toJson());
  }

  static Stream<List<LaptopSnapShot>> dsSVTuFireBase(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.
    collection("Laptop").snapshots();
    // Chuyển Stream<QS> --> Stream<List<DS>>
    Stream<List<DocumentSnapshot>> StreamListDocSnap =
    streamQS.map((querySn) => querySn.docs);

    //map1: Chuyển Stream<List> --> Stream<List khác kiểu>
    //map2: Chuyển List<DS> --> List<SVS>
    return StreamListDocSnap.map((
        listDocSnap) =>
        listDocSnap.map((docSnap) => LaptopSnapShot.fromSnapShot(docSnap)).toList()
    );
  }

  // rút gọn dsSVTuFireBase
  static Stream<List<LaptopSnapShot>> getAll(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("Laptop").snapshots();
    return streamQS.map((qs) => qs.docs)
        .map((listDocSnap) => listDocSnap.map((docSnap) =>
        LaptopSnapShot.fromSnapShot(docSnap)).toList());
  }

  static Stream<List<LaptopSnapShot>> getAll2(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("Laptop").snapshots();
    return streamQS.map((qs) => qs.docs.map((docSnap) => LaptopSnapShot.fromSnapShot(docSnap)).toList()
    );
  }

  static Future<List<LaptopSnapShot>> dsLaptopTuFirebaseOneTime() async {
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Laptop").get();
    return qs.docs.map((doc) => LaptopSnapShot.fromSnapShot(doc)).toList();
  }
}