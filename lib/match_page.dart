import 'package:flutter/material.dart';

void main() {
  runApp(const PistaApp());
}

class PistaApp extends StatelessWidget {
  const PistaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pista',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF176B55),
        ),
        useMaterial3: true,
      ),
      home: const MatchPage(),
    );
  }
}

class Persona {
  const Persona({
    required this.nombre,
    required this.edad,
    required this.zona,
    required this.deportes,
    required this.horarios,
    required this.coincidencias,
    required this.emoji,
    required this.color,
  });

  final String nombre;
  final int edad;
  final String zona;
  final List<String> deportes;
  final List<String> horarios;
  final List<String> coincidencias;
  final String emoji;
  final Color color;
}

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  String deporteElegido = 'Todos';
  int personaActual = 0;

  final List<Persona> personas = const [
    Persona(
      nombre: 'Alicia',
      edad: 18,
      zona: 'Centro',
      deportes: ['Running', 'Senderismo'],
      horarios: ['Entre semana', 'Tardes'],
      coincidencias: ['Running', 'Tardes', 'Centro'],
      emoji: '🏃🏻‍♀️',
      color: Color(0xFFE7D9CE),
    ),
    Persona(
      nombre: 'Álvaro',
      edad: 30,
      zona: 'Retiro',
      deportes: ['Pádel', 'Running'],
      horarios: ['Mañanas', 'Fines de semana'],
      coincidencias: ['Pádel', 'Fines de semana', 'Retiro'],
      emoji: '🎾',
      color: Color(0xFFDCE8D9),
    ),
    Persona(
      nombre: 'Nora',
      edad: 25,
      zona: 'Centro',
      deportes: ['Ciclismo', 'Running'],
      horarios: ['Entre semana', 'Tardes'],
      coincidencias: ['Running', 'Tardes', 'Centro'],
      emoji: '🚴🏻‍♀️',
      color: Color(0xFFE5E0F0),
    ),
    Persona(
      nombre: 'Alicia',
      edad: 23,
      zona: 'Centro',
      deportes: ['Yoga', 'Gimnasio'],
      horarios: ['Fines de semana', 'Mañana'],
      coincidencias: ['Running', 'Tardes', 'Zona Bellvitge'],
      emoji: '🧘🏻‍♀️',
      color: Color(0xFFE5E0F0),
    ),
  ];

  List<Persona> get personasFiltradas {
    if (deporteElegido == 'Todos') return personas;
    return personas
        .where((persona) => persona.deportes.contains(deporteElegido))
        .toList();
  }

  void pasarPersona() {
    setState(() {
      personaActual++;
    });
  }

  void mostrarInteres(Persona persona) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Has enviado interés a ${persona.nombre}.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
    pasarPersona();
  }

  @override
  Widget build(BuildContext context) {
    final lista = personasFiltradas;
    final persona = lista.isEmpty || personaActual >= lista.length
        ? null
        : lista[personaActual];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pista',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Filtros',
            onPressed: () {},
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tu próximo compañero de deporte',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Personas con gustos y horarios parecidos a los tuyos.',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 42,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: ['Todos', 'Running', 'Pádel', 'Ciclismo']
                          .map(
                            (deporte) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(deporte),
                                selected: deporteElegido == deporte,
                                onSelected: (_) {
                                  setState(() {
                                    deporteElegido = deporte;
                                    personaActual = 0;
                                  });
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: persona == null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('🎉', style: TextStyle(fontSize: 48)),
                            const SizedBox(height: 12),
                            const Text(
                              'Has visto todos los perfiles',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('Prueba otro deporte para descubrir más.'),
                            const SizedBox(height: 16),
                            OutlinedButton(
                              onPressed: () {
                                setState(() => personaActual = 0);
                              },
                              child: const Text('Volver a empezar'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        color: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                color: persona.color,
                                child: Center(
                                  child: Text(
                                    persona.emoji,
                                    style: const TextStyle(fontSize: 110),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${persona.nombre}, ${persona.edad}',
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text('📍 Zona ${persona.zona}'),
                                  const SizedBox(height: 14),
                                  const Text(
                                    'Coincidís en',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 6,
                                    children: persona.coincidencias
                                        .map(
                                          (coincidencia) => Chip(
                                            label: Text(coincidencia),
                                            visualDensity:
                                                VisualDensity.compact,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Le gusta: ${persona.deportes.join(' · ')}',
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    'Puede: ${persona.horarios.join(' · ')}',
                                    style:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton.icon(
                                          onPressed: pasarPersona,
                                          icon: const Icon(Icons.close),
                                          label: const Text('Pasar'),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: FilledButton.icon(
                                          onPressed: () =>
                                              mostrarInteres(persona),
                                          icon: const Icon(Icons.favorite),
                                          label: const Text('Me interesa'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}