// ignore_for_file: unnecessary_null_comparison

class Gasolineras{

  List<Gasolinera> items = [];

  Gasolineras();

  Gasolineras.fromJsonList( List<dynamic> jsonList){

    if(jsonList == null) return;

    for(var item in jsonList){
      final gasolinera = Gasolinera.fromJsonMap(item);
      items.add(gasolinera);
    }
  }
}

class Gasolinera {

  String uniqueId = "0";//Propiedad inventada para diferenciar ID para uso del Hero Animation

  String locationLatitude = 'location_latitude';
  String locationLongitude = 'location_longitude';
  String name = 'name';
  String gasStationLogo = 'ruta';
  String priceDiesel = 'price_diesel';
  String priceEspecial = 'price_especial';
  String priceRegular = 'price_regular';
  int id = 0;

  Gasolinera({
    required this.locationLatitude,
    required this.locationLongitude,
    required this.name,
    required this.gasStationLogo,
    required this.priceDiesel,
    required this.priceEspecial,
    required this.priceRegular,
    required this.id,
  });

  Gasolinera.fromJsonMap(Map<String, dynamic> json){
    locationLatitude  = json["location_latitude"] ?? '';
    locationLongitude = json["location_longitude"] ?? '';
    name              = json["name"] ?? '';
    gasStationLogo    = json["ruta"] ?? '';
    priceDiesel       = json["price_diesel"] ?? '';
    priceEspecial     = json["price_especial"] ?? '';
    priceRegular      = json["price_regular"] ?? '';
    id                = json["id"] ?? 0;
  }

  getLogoImg(){

    if(gasStationLogo == null){
      return 'https://i.stack.imgur.com/y9DpT.jpg';
    }else{
      return gasStationLogo;
    }
  }

}