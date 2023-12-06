
import 'package:frontend/models/RapportModel.dart';
import 'package:get/get.dart';

class RapportController extends GetxController{

  RxBool valid = true.obs;
  var items=[
    "n'est pas traité",
    "en cour de traitement",
    "traité"
  ].obs;

  List<RapportModel> listeDeRapports = <RapportModel>[
    RapportModel(
        rapportType: "Qualité",
        rapportContent: "lskdfsdmdfljvndfmlgmfdlhgmdfkjhgfmdjgfmdkjghfmdkjghfmdkhgfmdkjgfmdkhgfmdkglkfjlsdflsihg",
        seen: true,
        status: "traité"
    ),
    RapportModel(
        rapportType: "Personnel",
        rapportContent: "lskdfsdlkfjlsdflsihg",
        seen: true,
        status: "n'est pas traité"
    ),
    RapportModel(
        rapportType: "Qualité",
        rapportContent: "lskdfsdlkfjlsdflsihg",
        seen: true,
        status: "en cour de traitement"
    ),
    RapportModel(
        rapportType: "Personnel",
        rapportContent: "lskdfsdlkfjlsdflsihg",
        seen: false,
        status: "en cour de traitement"
    ),
  ].obs;



}