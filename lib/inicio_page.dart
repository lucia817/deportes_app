import 'package:flutter/material.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({
    super.key,
    required this.onPlanesTap,
    required this.onMatchTap,
    required this.onPerfilTap,
  });

  final VoidCallback onPlanesTap;
  final VoidCallback onMatchTap;
  final VoidCallback onPerfilTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F8F6),
        title: const Text(
          'Deporte en compañía',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.sports_soccer, color: Color(0xFF176B55)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [Color(0xFF176B55), Color(0xFF0D4939)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('MUÉVETE ACOMPAÑADO'),
                const SizedBox(height: 12),
                const Text(
                  'Encuentra a tu gente\\Comparte tu deporte.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 29,
                    height: 1.15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Descubre personas y planes deportivos que encajan contigo.',
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: onMatchTap,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF176B55),
                  ),
                  icon: const Icon(Icons.favorite),
                  label: const Text('Encontrar compañeros'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          const Text(
            '¿Qué te apetece hacer?',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _AccesoCard(
            icono: Icons.event_available,
            titulo: 'Explorar planes',
            descripcion: 'Apúntate a una actividad deportiva cerca de ti.',
            alPulsar: onPlanesTap,
          ),
          const SizedBox(height: 10),
          _AccesoCard(
            icono: Icons.favorite_outline,
            titulo: 'Hacer Match',
            descripcion: 'Conoce gente con horarios y deportes parecidos.',
            alPulsar: onMatchTap,
          ),
          const SizedBox(height: 10),
          _AccesoCard(
            icono: Icons.person_outline,
            titulo: 'Completar mi perfil',
            descripcion: 'Añade tus preferencias para encontrar mejores coincidencias.',
            alPulsar: onPerfilTap,
          ),
        ],
      ),
    );
  }
}

class _AccesoCard extends StatelessWidget {
  const _AccesoCard({
    required this.icono,
    required this.titulo,
    required this.descripcion,
    required this.alPulsar,
  });

  final IconData icono;
  final String titulo;
  final String descripcion;
  final VoidCallback alPulsar;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        onTap: alPulsar,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE4F0EB),
          child: Icon(icono, color: const Color(0xFF176B55)),
        ),
        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(descripcion),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}