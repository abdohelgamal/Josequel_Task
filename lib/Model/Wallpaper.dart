class WallPaper {
  WallPaper(
      this.id,
      this.name,
      this.url,
      this.photographerName,
      this.photographerUrl,
      this.photographerID,
      this.urlOriginal,
      this.urlLarge2x,
      this.urlLarge,
      this.urlMedium,
      this.urlSmall,
      this.urlPortrait,
      this.urlLandscape,
      this.urlTiny);
  int id;
  String name;
  String url;
  String photographerName;
  String photographerUrl;
  int photographerID;
  String urlOriginal;
  String urlLarge2x;
  String urlLarge;
  String urlMedium;
  String urlSmall;
  String urlPortrait;
  String urlLandscape;
  String urlTiny;
  factory WallPaper.fromMap(Map map) {
    return WallPaper(
        map["id"],
        map["alt"],
        map["url"],
        map["photographer"],
        map["photographer_url"],
        map["photographer_id"],
        map["src"]["original"],
        map["src"]["large2x"],
        map["src"]["large"],
        map["src"]["medium"],
        map["src"]["small"],
        map["src"]["portrait"],
        map["src"]["landscape"],
        map["src"]["tiny"]);
  }
  Map toMap() {
    return {
      'id': id,
      'alt': name,
      'url': url,
      'photographer': photographerName,
      'photographer_url': photographerUrl,
      'photographer_id': photographerID,
      'src': {
        'original': urlOriginal,
        'large2x': urlLarge2x,
        'large': urlLarge,
        'medium': urlMedium,
        'small': urlSmall,
        'portrait': urlPortrait,
        'landscape': urlLandscape,
        'tiny': urlTiny
      }
    };
  }
}
