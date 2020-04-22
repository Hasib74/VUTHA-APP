class History {
  var date;
  Location location;

  var serviceManNumber;

  var serviceType;


  History({this.serviceManNumber,this.location,this.date,this.serviceType});
}

class Location {
  var lat;
  var lan;

  Location({this.lat,this.lan});
}
