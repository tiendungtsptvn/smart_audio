import 'dart:convert';

class SAUAudio {
  final int id;
  final int order;
  final String name;
  final String? tagline;
  final String? color;
  final String desc;
  final String url;
  final String category;
  final String icon;
  final String image;
  final String? lang;
  SAUAudio({
    required this.id,
    required this.order,
    required this.name,
    this.tagline,
    this.color,
    required this.desc,
    required this.url,
    required this.category,
    required this.icon,
    required this.image,
    this.lang,
  });

  SAUAudio copyWith({
    int? id,
    int? order,
    String? name,
    String? tagline,
    String? color,
    String? desc,
    String? url,
    String? category,
    String? icon,
    String? image,
    String? lang,
  }) {
    return SAUAudio(
      id: id ?? this.id,
      order: order ?? this.order,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      color: color ?? this.color,
      desc: desc ?? this.desc,
      url: url ?? this.url,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      image: image ?? this.image,
      lang: lang ?? this.lang,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': order,
      'name': name,
      'tagline': tagline,
      'color': color,
      'desc': desc,
      'url': url,
      'category': category,
      'icon': icon,
      'image': image,
      'lang': lang,
    };
  }

  factory SAUAudio.fromMap(Map<String, dynamic> map) {
    return SAUAudio(
      id: map['id'],
      order: map['order'],
      name: map['name'],
      tagline: map['tagline'],
      color: map['color'],
      desc: map['desc'],
      url: map['url'],
      category: map['category'],
      icon: map['icon'],
      image: map['image'],
      lang: map['lang'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SAUAudio.fromJson(String source) =>
      SAUAudio.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyRadio(id: $id, order: $order, name: $name, tagline: $tagline, color: $color, desc: $desc, url: $url, category: $category, icon: $icon, image: $image, lang: $lang)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SAUAudio &&
        other.id == id &&
        other.order == order &&
        other.name == name &&
        other.tagline == tagline &&
        other.color == color &&
        other.desc == desc &&
        other.url == url &&
        other.category == category &&
        other.icon == icon &&
        other.image == image &&
        other.lang == lang;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    order.hashCode ^
    name.hashCode ^
    tagline.hashCode ^
    color.hashCode ^
    desc.hashCode ^
    url.hashCode ^
    category.hashCode ^
    icon.hashCode ^
    image.hashCode ^
    lang.hashCode;
  }
}