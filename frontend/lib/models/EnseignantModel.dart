
class EnseignantModel{
  String? id;
  String? nomComplet;
  String? cin;
  String? numInsc;
  String? phone;
  String? email;
  String? photo;
  String? titre;
  String? cv;

  EnseignantModel({
    this.id,
    this.nomComplet,
    this.email,
    this.phone,
    this.cin,
    this.cv,
    this.titre,
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
    "cv":cv,
    "titre":titre
  };

  EnseignantModel.fromJson(Map<String, dynamic> json)
      : nomComplet = json['nomComplet'] as String,
        cin = json['cin'] as String,
        numInsc = json['numInsc'] as String,
        email = json['email'] as String,
        photo = json['photo'] as String,
        cv = json['cv'] as String,
        titre = json['titre'] as String,
        phone = json['phone'] as String;

}