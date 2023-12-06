class RapportModel {

  String? id;
  String? rapportType;
  String? rapportContent;
  bool? seen;
  String? status;

  RapportModel({this.id,this.rapportContent,this.rapportType,this.seen,this.status});

  Map<String, dynamic> toJson() => {
    'id': id,
    "rapportType":rapportType,
    "rapportContent":rapportContent ,
    "seen":seen ,
    "status":status,
  };
}