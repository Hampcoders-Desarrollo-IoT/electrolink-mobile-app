import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF), // El mismo fondo azul claro
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E2746), // El azul oscuro de tu logo
        title: const Text(
          'ElectroLink - Home',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        // Pequeño botón para poder regresar al Login mientras pruebas
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  )
                ],
              ),
              child: const Icon(
                  Icons.construction,
                  size: 60,
                  color: Color(0xFF1E2746)
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '¡Bienvenido a tu panel!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E2746)),
            ),
            const SizedBox(height: 8),
            const Text(
              'Aquí puedes empezar a modificar tu vista de Home.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}