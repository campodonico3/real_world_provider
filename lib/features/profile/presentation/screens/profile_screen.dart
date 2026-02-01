import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_world_provider/features/auth/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(height: 30), // Revisar esto
                  Row(
                    children: [
                      CircleAvatar(),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Kevin Anthony'),
                          Text('anthony@gmail.com'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12,),
                  _buildSectionCard(
                    title: 'Account',
                    children: [
                      _buildListTile('Edit profile', Icons.person_outline),
                      _buildListTile('Change password', Icons.lock_outline),
                      _buildListTile('Payments', Icons.payment_outlined),
                      _buildListTile('Followings', Icons.group_outlined),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Logout botón
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.logout, color: Colors.redAccent),
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () async {
                        await context.read<AuthProvider>().logout();
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sesión cerrada correctamente'),
                          ),
                        );
                        // El enrutador redirige automáticamente al login al cambiar el estado de auth
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título de sección
          Row(
            children: [
              const Icon(Icons.grid_view_outlined, size: 18, color: Colors.black87),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Divisor sutil
          const SizedBox(height: 4),
          // Contenidos (list tiles)
          ...children.map((w) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: w,
                ),
                // Divider entre items (excepto último)
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        // Acción de ejemplo
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.black54),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          const Icon(Icons.chevron_right, color: Colors.black26),
        ],
      ),
    );
  }
}