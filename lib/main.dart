import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'match_page.dart';
import 'perfil_page.dart';
import 'inicio_page.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SportLinkBootstrap());
}

class SportLinkBootstrap extends StatelessWidget {
  const SportLinkBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'No se pudo conectar con Firebase. Comprueba la conexión '
                    'a Internet y vuelve a cargar la aplicación.\\n\\n'
                    '${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        return const DeporteApp();
      },
    );
  }
}

class DeporteApp extends StatelessWidget {
  const DeporteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SportLink',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF176B55),
        ),
        useMaterial3: true,
      ),
      home: const AppShell(),
    );
  }
}

class PlanesPage extends StatefulWidget {
  const PlanesPage({super.key});

  @override
  State<PlanesPage> createState() => _PlanesPageState();
}

class _PlanesPageState extends State<PlanesPage> {
  final TextEditingController _busqueda = TextEditingController();
  final Set<int> _apuntados = {};
  String _deporte = 'Todos';

  final List<Map<String, String>> _planes = [
    {
      'deporte': 'Running',
      'titulo': 'Trote suave por el parque',
      'lugar': 'Parque de bellvitge',
      'hora': 'Hoy · 18:30',
      'personas': '3 de 6 personas',
      'emoji': '🏃',
    },
    {
      'deporte': 'Pádel',
      'titulo': 'Partido de nivel principiante',
      'lugar': 'Club deportivo Norte',
      'hora': 'Mañana · 10:00',
      'personas': '2 de 4 personas',
      'emoji': '🎾',
    },
    {
      'deporte': 'Ciclismo',
      'titulo': 'Ruta tranquila en bici',
      'lugar': 'Plaza de Castilla',
      'hora': 'Sábado · 09:00',
      'personas': '4 de 8 personas',
      'emoji': '🚴',
    },
    {
      'deporte': 'Clase de yoga',
      'titulo': 'Clase de yoga organizada por instructor',
      'lugar': 'Gimnasio VivaGym Plz. Europa',
      'hora': 'Viernes · 20:00',
      'personas': '25 de 30 personas',
      'emoji': '🧘',
    },
    {
      'deporte': 'Pachanga de futbol',
      'titulo': 'Pachanga de futbol organizada por club',
      'lugar': 'Estadio de futbol de Hospitalet',
      'hora': 'c',
      'personas': '10 de 15 personas',
      'emoji': '⚽',
    },
    {
      'deporte': 'Senderismo',
      'titulo': 'Ruta de senderismo en el parque',
      'lugar': 'Parque de bellvitge',
      'hora': 'Domingo · 10:00',
      'personas': '8 de 12 personas',
      'emoji': '🥾',
    }
  ,{
      'deporte': 'Running',
      'titulo': 'Torneo de atletismo en estadio',
      'lugar': 'Estadio Municipal Joan Serrahima',
      'hora': 'Martes 19:00',
      'personas': '20 de 30 personas',
      'emoji': '🏃',
      
    },

  ];

  @override
  void dispose() {
    _busqueda.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final planesVisibles = _planes.asMap().entries.where((entrada) {
      final plan = entrada.value;
      final coincideDeporte =
          _deporte == 'Todos' || plan['deporte'] == _deporte;
      final texto = _busqueda.text.toLowerCase();
      final coincideBusqueda =
          plan.values.any((dato) => dato.toLowerCase().contains(texto));
      return coincideDeporte && coincideBusqueda;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pista',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Notificaciones',
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Apuntate a tu próximo plan',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Deporte en compañía, en tu zona.',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: _busqueda,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Busca deporte o lugar',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 42,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: ['Todos', 'Running', 'Pádel', 'Ciclismo', 'Yoga','Futbol']
                          .map(
                            (deporte) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(deporte),
                                selected: _deporte == deporte,
                                onSelected: (_) {
                                  setState(() => _deporte = deporte);
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Text(
                'Planes cerca de ti',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Expanded(
              child: planesVisibles.isEmpty
                  ? const Center(child: Text('No hay planes con esa búsqueda.'))
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      itemCount: planesVisibles.length,
                      itemBuilder: (context, index) {
                        final entrada = planesVisibles[index];
                        final id = entrada.key;
                        final plan = entrada.value;
                        final apuntado = _apuntados.contains(id);

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 0,
                          color: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      plan['emoji']!,
                                      style: const TextStyle(fontSize: 28),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        plan['deporte']!,
                                        style: const TextStyle(
                                          color: Color(0xFF176B55),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      plan['hora']!,
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  plan['titulo']!,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('📍 ${plan['lugar']}'),
                                const SizedBox(height: 4),
                                Text('👥 ${plan['personas']}'),
                                const SizedBox(height: 12),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: FilledButton(
                                    onPressed: () {
                                      setState(() {
                                        if (apuntado) {
                                          _apuntados.remove(id);
                                        } else {
                                          _apuntados.add(id);
                                        }
                                      });
                                    },
                                    child: Text(
                                      apuntado ? 'Apuntada ✓' : 'Apuntarme',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int tabSeleccionada = 0;

  @override
  Widget build(BuildContext context) {
    final indexedStack = IndexedStack(
      index: tabSeleccionada,
      children: [
        InicioPage(
          onPlanesTap: () => setState(() => tabSeleccionada = 1),
          onMatchTap: () => setState(() => tabSeleccionada = 2),
          onPerfilTap: () => setState(() => tabSeleccionada = 3),
        ),
        const PlanesPage(),
        const MatchPage(),
        const PerfilPage(),
      ],
    );

    return Scaffold(
      body: indexedStack,
      bottomNavigationBar: NavigationBar(
        selectedIndex: tabSeleccionada,
        onDestinationSelected: (indice) {
          setState(() => tabSeleccionada = indice);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_available),
            label: 'Planes',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            label: 'Match',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Mi perfil',
          ),
        ],
      ),
    );
  }
}
