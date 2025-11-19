import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'package:productos_app/models/producto_model.dart';

import 'package:http/http.dart' as http;

class ProductoService extends ChangeNotifier {
  final String _baseUrl = 'productos-e792e-default-rtdb.firebaseio.com';

  final List<Producto> productos = [];

  bool isLoading = true;
  bool isSaving = false;

  Producto? productoSeleccionado;

  File? newImagenProducto;

  //constructor
  ProductoService() {
    this.obtenerProductos();
  }

  //metodo para obtener los productos de la BD
  Future obtenerProductos() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'productos.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productosMap = json.decode(resp.body);
    //print(productosMap);

    //recorremos el mapa de la respuesta y vamos agregando productos a la lista
    productosMap.forEach((key, value) {
      final tempProducto = Producto.fromMap(value);
      tempProducto.id = key;
      this.productos.add(tempProducto);
    });

    this.isLoading = false;
    notifyListeners();

    return this.productos;
  }

  //metodo para actualizar productos

  Future<String> updateProducto(Producto producto) async {
    final url = Uri.https(_baseUrl, 'productos/${producto.id}.json');
    final resp = await http.put(url, body: producto.toJson());

    final decodedData = resp.body;
    print(decodedData);

    final index = this.productos.indexWhere(
      (element) => element.id == producto.id,
    );

    this.productos[index] = producto;

    return producto.id!;
  }

  //método para crear un nuevo producto o actualizar
  Future crearOActualizarProducto(Producto producto) async {
    isSaving = true;
    notifyListeners();

    if (producto.id == null) {
      //producto nuevo
      await this.nuevoProducto(producto);
    } else {
      //producto existente
      await updateProducto(producto);
    }

    isSaving = false;
    notifyListeners();
  }

  //metodo para agregar productos nuevos
  Future<String> nuevoProducto(Producto producto) async {
    final url = Uri.https(_baseUrl, 'productos.json');
    final resp = await http.post(url, body: producto.toJson());

    final decodedData = json.decode(resp.body);
    //print(decodedData);

    producto.id = decodedData['name'];
    this.productos.add(producto);

    return producto.id!;
  }

  //metodo para actualizar la imagen del producto
  void updateImagenProducto(String path) {
    this.productoSeleccionado!.imagen = path;
    this.newImagenProducto = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  //metodo para subir la imagen a cloudinary
  Future<String?> subirImagen() async {
    if (this.newImagenProducto == null) return null;
    notifyListeners();

    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/fotosUsuarios/image/upload?upload_preset=productos',
    );

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
      'file',
      newImagenProducto!.path,
    );
    imageUploadRequest.files.add(file);

    final steamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(steamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Error');
      return null;
    }

    this.newImagenProducto = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
