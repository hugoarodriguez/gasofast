import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;
import 'package:gasofast/src/models/gasolinera_model.dart';

class GasolineraProvider{

  final cloud_firestore.FirebaseFirestore _firestore = cloud_firestore.FirebaseFirestore.instance;

  //Agregar Gasolinera Favorita
  Future<bool> aggGasolineraFavorita(String uid, GasolineraModel gasolineraModel) async {
    
    cloud_firestore.CollectionReference reference  = _firestore.collection('favorite_gas_stations');

    try{
      
      //Registrar
      await reference.doc(gasolineraModel.id + uid).set({
        'id_user'             : uid,
        'id_gas_station'      : gasolineraModel.id,
        'location_latitude'   : gasolineraModel.locationLatitude,
        'location_longitude'  : gasolineraModel.locationLongitude,
        'name'                : gasolineraModel.name,
        'price_diesel'        : gasolineraModel.priceDiesel,
        'price_especial'      : gasolineraModel.priceEspecial,
        'price_regular'       : gasolineraModel.priceRegular,
        'cover_img'           : gasolineraModel.coverImg,
      });
      //Si la subida salió bien se retorna 'true'
      return true;
      
    } on cloud_firestore.FirebaseException catch(e){
      //Si hubo error en la subida se retorna 'false'
      print(e);
      return false;
    }
  }

  //Eliminar Gasolinera Favorita
  Future<bool> elmGasolineraFavorita(String uid, GasolineraModel gasolineraModel) async {
    
    cloud_firestore.CollectionReference reference  = _firestore.collection('favorite_gas_stations');

    try{
      
      //Registrar
      await reference.doc(gasolineraModel.id + uid).delete();

      //Si la subida salió bien se retorna 'true'
      return true;
      
    } on cloud_firestore.FirebaseException catch(e){
      //Si hubo error en la subida se retorna 'false'
      print(e);
      return false;
    }
  }

  //Evaluamos si la gasolinera es favorita
  Future<bool> isFavorita(String uid, String idGasolinera) async {

    String idGasolineraFinal = idGasolinera;

    if(idGasolinera.contains('(')){
      int indexParentesis1 = idGasolinera.indexOf('(');
      int indexParentesis2 = idGasolinera.indexOf(')');
      idGasolineraFinal = idGasolinera.substring(indexParentesis1 + 1, indexParentesis2);
    }

    cloud_firestore.CollectionReference reference  = _firestore.collection('favorite_gas_stations');
    bool r = false;

    try{
      
      //Registrar
      final cloud_firestore.DocumentSnapshot documentSnapshot = await reference.doc(idGasolineraFinal + uid).get();

      r = documentSnapshot.exists;//Retorna 'true' si existe, 'false' si no
      
      return r;
      
    } on cloud_firestore.FirebaseException catch(e){
      //Si hubo error en la consulta retorna 'false', indica que no existe
      print(e);
      return false;
    }
  }

  Future<List<GasolineraModel>> getGasolineras() async {
    List<GasolineraModel> gasolinerasList = [];

    cloud_firestore.CollectionReference reference  = _firestore.collection('gas_stations');

    final cloud_firestore.QuerySnapshot result = await reference.get();
    final List<cloud_firestore.DocumentSnapshot> documents = result.docs;
    
    for (var doc in documents) { 
      gasolinerasList.add(GasolineraModel(doc.reference.id, doc['location_latitude'], doc['location_longitude'], 
      doc['name'], doc['price_diesel'], doc['price_especial'], doc['price_regular'], doc['cover_img'], doc['schedule']));
    }

    return gasolinerasList;
  }

  Future<List<GasolineraModel>> getGasolinera(String idGasolinera) async {

    String idGasolineraFinal = idGasolinera;

    if(idGasolinera.contains('(')){
      int indexParentesis1 = idGasolinera.indexOf('(');
      int indexParentesis2 = idGasolinera.indexOf(')');
      idGasolineraFinal = idGasolinera.substring(indexParentesis1 + 1, indexParentesis2);
    }

    List<GasolineraModel> gasolinerasList = [];
    
    cloud_firestore.CollectionReference reference  = _firestore.collection('gas_stations');

    final cloud_firestore.DocumentSnapshot doc = await reference.doc(idGasolineraFinal).get();
    
    gasolinerasList.add(GasolineraModel(doc.reference.id, doc['location_latitude'], doc['location_longitude'], 
      doc['name'], doc['price_diesel'], doc['price_especial'], doc['price_regular'], doc['cover_img'], doc['schedule']));

    return gasolinerasList;
  }
}