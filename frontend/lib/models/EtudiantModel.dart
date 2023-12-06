
class EtudiantModel{
  String? id;
  String? nomComplet;
  String? cin;
  String? numInsc;
  String? phone;
  String? email;
  String? photo;
  String? filiere;
  String? classe;

  EtudiantModel({
    this.id,
    this.nomComplet,
    this.email,
    this.phone,
    this.cin,
    this.classe,
    this.filiere,
    this.numInsc,
    this.photo,
});

  Map<String, dynamic> toJson() => {
    'nomComplet': nomComplet,
    "cin":cin,
    "photo":photo,
    "numInsc":numInsc,
    "phone":phone,
    'email': email,
    "filiere":filiere,
    "classe":classe
  };

  EtudiantModel.fromJson(Map<String, dynamic> json)
      : nomComplet = json['nomComplet'] as String,
        cin = json['cin'] as String,
        classe = json['classe'] as String,
        photo = json['photo'] as String,
        email = json['email'] as String,
        phone = json['password'] as String,
        filiere = json['filiere'] as String,
        numInsc = json['numInsc'] as String;

}