class ImageData {
  late String url;

  ImageData(this.url);

  // Constructeur fromMap pour construire un ImageData à partir d'un JSON
  ImageData.fromMap(Map<String, dynamic> json) {
    url = json['url'];
  }

  // Méthode toMap pour convertir l'objet en Map
  Map<String, dynamic> toMap() {
    return {
      'url': url,
    };
  }
}
