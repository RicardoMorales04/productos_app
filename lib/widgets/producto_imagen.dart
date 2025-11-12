import 'package:flutter/material.dart';

class ProductoImagen extends StatelessWidget {
  final String? imagenUrl;

  const ProductoImagen({super.key, this.imagenUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        height: 450,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
            child: imagenUrl == null
            ?  Image(
              image: AssetImage(
                'assets/no-image.png'
              ),
              fit: BoxFit.cover,
            )
            : FadeInImage(
              image: NetworkImage(this.imagenUrl!),
              placeholder: AssetImage('assets/jar-loading.gif'),
            )
          ),
        ),
      ),
    );
  }
}
