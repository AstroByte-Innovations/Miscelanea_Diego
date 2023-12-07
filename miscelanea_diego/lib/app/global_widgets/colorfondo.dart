import 'dart:ui';

class ColorFondo {
  final int key;
  final String nombre;
  final Color color;

  const ColorFondo({
    required this.nombre,
    required this.key,
    required this.color,
  });

  @override
  String toString() {
    return 'ColorFondo(key: $key, nombre: $nombre, color: $color)';
  }
}
