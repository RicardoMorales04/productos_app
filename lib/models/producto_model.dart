  import 'dart:convert';

class Producto {
  bool disponible;
  String? imagen;
  String nombre;
  double precio;
  String? id; // sigue existiendo, pero es opcional

  Producto({
    this.disponible = true,
    this.imagen,
    required this.nombre,
    required this.precio,
    this.id, // <-- ya no required
  });

  factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        disponible: json["disponible"] ?? true,
        imagen: json["imagen"],
        nombre: json["nombre"] ?? '',
        precio: (json["precio"] ?? 0).toDouble(),
        // id se omite, no hace falta aquí
      );

  Map<String, dynamic> toMap() => {
        "disponible": disponible,
        "imagen": imagen,
        "nombre": nombre,
        "precio": precio,
        // no se incluye el id
      };

  Producto copy() => Producto(
        nombre: nombre,
        precio: precio,
        disponible: disponible,
        imagen: imagen,
        id: id,
      );
}

