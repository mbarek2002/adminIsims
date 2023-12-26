class RapportModel {
  String? recID;
  String? id;
  String? rapportType;
  String? rapportContent;
  bool? seen;
  String? status;

  RapportModel({this.id,this.rapportContent,this.rapportType,this.seen,this.status,this.recID});

  Map<String, dynamic> toJson() => {
    'id': id,
    "rapportType":rapportType,
    "rapportContent":rapportContent ,
    "seen":seen ,
    "status":status,
  };

  factory RapportModel.fromMap(Map<String, dynamic> map) {
    return RapportModel(
      recID:map['_id'] as String ?? "",
      id: map['id'] as String ?? "",
      rapportContent: map['rapportContent'] as String ?? "",
      rapportType: map['rapportType'] as String ?? "",
      seen: map['seen'] as bool ?? false,
      status:  map['rapportStatus'] as String ?? "",
    );
  }
}