// ignore_for_file: non_constant_identifier_names, prefer_initializing_formals

class GasolineraModel{
  String id = '';
  String locationLatitude = '';
  String locationLongitude = ''; 
  String name = ''; 
  String priceDiesel = '';
  String priceEspecial = '';
  String priceRegular = '';

  GasolineraModel(String id, String locationLatitude, String locationLongitude, String name, String priceDiesel, 
  String priceEspecial, String priceRegular){
    this.id = id;
    this.locationLatitude = locationLatitude;
    this.locationLongitude = locationLongitude;
    this.name = name;
    this.priceDiesel = priceDiesel;
    this.priceEspecial = priceEspecial;
    this.priceRegular = priceRegular;
  }
}