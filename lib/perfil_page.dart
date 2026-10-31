import 'package:flutter/material.dart';

class Companero {
  const Companero({
    required this.nombre,
    required this.edad,
    required this.zona,
    required this.deportes,
    required this.horarios,
    required this.lugar,
    required this.emoji,
  });

  final String nombre;
  final int edad;
  final String zona;
  final List<String> deportes;
  final List<String> horarios;
  final String lugar;
  final String emoji;
}

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _edadController = TextEditingController();
  final _zonaController = TextEditingController();
  final _lugarController = TextEditingController();

  String _deporte = 'Running';
  final Set<String> _horarios = {};
  bool _busquedaRealizada = false;

  final List<Companero> _ejemplos = const [
    Companero(
      nombre: 'Jaime',
      edad: 18,
      zona: 'Centro',
      deportes: ['Running', 'Ciclismo'],
      horarios: ['Tardes', 'Fines de semana'],
      lugar: 'PMT',
      emoji: '🏃🏻‍♂️',
    ),
    Companero(
      nombre: 'Nora',
      edad: 26,
      zona: 'Bellvitge',
      deportes: ['Pádel', 'Running'],
      horarios: ['Mañanas', 'Tardes'],
      lugar: 'Club Deportivo Norte',
      emoji: '🎾',
    ),
    Companero(
      nombre: 'Carla',
      edad: 20,
      zona: 'Centro',
      deportes: ['Yoga', 'Running'],
      horarios: ['Tardes', 'Noches'],
      lugar: 'VivaGym Plaza Europa',
      emoji: '🧘🏻‍♀️',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _edadController.dispose();
    _zonaController.dispose();
    _lugarController.dispose();
    super.dispose();
  }

  int _compatibilidad(Companero persona) {
    final edad = int.tryParse(_edadController.text.trim());
    final zona = _zonaController.text.trim().toLowerCase();
    final lugar = _lugarController.text.trim().toLowerCase();
    var puntos = 0;

    if (edad != null && (edad - persona.edad).abs() <= 8) puntos += 20;
    if (persona.deportes.contains(_deporte)) puntos += 20;
    if (persona.horarios.any(_horarios.contains)) puntos += 20;
    if (persona.zona.toLowerCase().contains(zona) ||
        zona.contains(persona.zona.toLowerCase())) {
      puntos += 20;
    }
    if (persona.lugar.toLowerCase().contains(lugar) ||
        lugar.contains(persona.lugar.toLowerCase())) {
      puntos += 20;
    }
    return puntos;
  }

  List<Companero> get _compatibles {
    final personas = _ejemplos
        .where((persona) => _compatibilidad(persona) >= 40)
        .toList();
    personas.sort(
      (a, b) => _compatibilidad(b).compareTo(_compatibilidad(a)),
    );
    return personas;
  }

  void _buscarCompatibles() {
    final edad = int.tryParse(_edadController.text.trim());
    if (edad == null ||
        _zonaController.text.trim().isEmpty ||
        _lugarController.text.trim().isEmpty ||
        _horarios.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completa tus datos y selecciona al menos un horario.'),
        ),
      );
      return;
    }

    setState(() => _busquedaRealizada = true);
    _tabs.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi perfil deportivo'),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: 'Mis datos', icon: Icon(Icons.person_outline)),
            Tab(text: 'Compatibles', icon: Icon(Icons.favorite_outline)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _formulario(),
          _resultados(),
        ],
      ),
    );
  }

  Widget _formulario() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Cuéntanos qué buscas',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          'Usaremos tus preferencias para encontrar compañeros compatibles.',
          style: TextStyle(color: Colors.grey.shade700),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _edadController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Edad',
            prefixIcon: Icon(Icons.cake_outlined),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _zonaController,
          decoration: const InputDecoration(
            labelText: 'Zona o barrio',
            prefixIcon: Icon(Icons.location_on_outlined),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          initialValue: _deporte,
          decoration: const InputDecoration(
            labelText: 'Deporte que buscas',
            prefixIcon: Icon(Icons.sports),
            border: OutlineInputBorder(),
          ),
          items: ['Running', 'Pádel', 'Ciclismo', 'Yoga']
              .map((deporte) => DropdownMenuItem(
                    value: deporte,
                    child: Text(deporte),
                  ))
              .toList(),
          onChanged: (deporte) {
            if (deporte != null) setState(() => _deporte = deporte);
          },
        ),
        const SizedBox(height: 18),
        const Text(
          '¿Qué horarios te van bien?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['Mañanas', 'Tardes', 'Noches', 'Fines de semana']
              .map(
                (horario) => FilterChip(
                  label: Text(horario),
                  selected: _horarios.contains(horario),
                  onSelected: (seleccionado) {
                    setState(() {
                      if (seleccionado) {
                        _horarios.add(horario);
                      } else {
                        _horarios.remove(horario);
                      }
                    });
                  },
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _lugarController,
          decoration: const InputDecoration(
            labelText: 'Cancha, parque o gimnasio habitual',
            prefixIcon: Icon(Icons.place_outlined),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 22),
        FilledButton.icon(
          onPressed: _buscarCompatibles,
          icon: const Icon(Icons.search),
          label: const Text('Buscar compañeros compatibles'),
        ),
      ],
    );
  }

  Widget _resultados() {
    if (!_busquedaRealizada) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Completa tus datos y pulsa “Buscar compañeros compatibles”.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final resultados = _compatibles;
    if (resultados.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'No encontramos coincidencias todavía. Prueba con otra zona, horario o lugar.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: resultados.map((persona) {
        final puntos = _compatibilidad(persona);
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(14),
            leading: CircleAvatar(
              radius: 28,
              child: Text(persona.emoji, style: const TextStyle(fontSize: 26)),
            ),
            title: Text(
              '${persona.nombre}, ${persona.edad}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '${persona.zona} · ${persona.deportes.join(', ')}\n'
                '${persona.horarios.join(', ')} · ${persona.lugar}\n'
                'Compatibilidad: $puntos%',
              ),
            ),
            isThreeLine: true,
            trailing: IconButton(
              tooltip: 'Mostrar interés',
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Interés enviado a ${persona.nombre}.')),
                );
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}