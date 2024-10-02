import 'package:exo3/models/image.dart';

class Breed {
  late String id;
  late String name;
  late String description;
  ImageData? image; // Utilisation de ImageData pour représenter l'image

  // Constructeur principal
  Breed(this.id, this.name, this.description, this.image);

  // Constructeur fromMap pour construire un Breed à partir d'un JSON
  Breed.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];

    // Vérifie si l'image est présente dans les données JSON et l'initialise
    if (json['image'] != null) {
      image = ImageData.fromMap(json['image']);
    } else {
      image = null; // Pas d'image disponible
    }
  }

  // Méthode toMap pour convertir l'objet en Map (JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'name': name,
      'description': description,
      // Conversion de l'image si elle existe
      'image': image != null ? image!.toMap() : null,
    };
  }

  // Affichage du nom de la race dans le toString
  @override
  String toString() {
    return name;
  }

  // Méthode de comparaison pour assurer l'unicité
  @override
  int get hashCode => id.hashCode;
}
