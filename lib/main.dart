import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quitar el banner de debug
      home: AgendaScreen(),
    );
  }
}

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  List<String> nombres = []; // Lista para almacenar los nombres
  TextEditingController nombreController = TextEditingController();
  TextEditingController controlController = TextEditingController();

  // Función para agregar nombres
  void agregarNombre() {
    String nombre = nombreController.text;
    String control = controlController.text;

    if (nombre.isNotEmpty && control.isNotEmpty) {
      setState(() {
        nombres.add("$nombre - $control");
        nombreController.clear(); // Limpiar campos
        controlController.clear();
      });
    }
  }

  // Función para cambiar de pantalla y mostrar la lista
  void verAgenda() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListaContactosScreen(nombres: nombres),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App segunda parcial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Agenda',
                style: TextStyle(fontSize: 24, color: Colors.blue),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre completo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controlController,
              decoration: InputDecoration(
                labelText: 'No control',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: agregarNombre,
              child: Text('Agregar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
              ),
            ),
            SizedBox(height: 16),
            Text('Contactos agregados: ${nombres.length}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: verAgenda,
              child: Text('Ver agenda'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListaContactosScreen extends StatelessWidget {
  final List<String> nombres;

  ListaContactosScreen({required this.nombres});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de contactos'),
      ),
      body: ListView.builder(
        itemCount: nombres.length,
        itemBuilder: (context, index) {
          // Extraer el nombre y el número de control separados por el guión
          String nombre = nombres[index].split(' - ')[0];
          String control = nombres[index].split(' - ')[1];

          return ListTile(
            leading: CircleAvatar(
              child: Text(nombre[0]), // Mostrar la inicial del nombre
            ),
            title: Text(nombre),
            subtitle: Text(control),
            trailing: Icon(Icons.arrow_forward_ios), // Flecha a la derecha
          );
        },
      ),
    );
  }
}
