import 'package:flutter/material.dart';

class SolicitudesScreen extends StatelessWidget {
  const SolicitudesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildDataBlock('Solicitud 1', 'Detalles de la solicitud 1', '2024-08-12')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDataBlock('Solicitud 2', 'Detalles de la solicitud 2', '2024-08-11')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildDataBlock('Solicitud 3', 'Detalles de la solicitud 3', '2024-08-10')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDataBlock('Solicitud 4', 'Detalles de la solicitud 4', '2024-08-09')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildDataBlock('Solicitud 5', 'Detalles de la solicitud 5', '2024-08-08')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDataBlock('Solicitud 6', 'Detalles de la solicitud 6', '2024-08-07')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataBlock(String title, String details, String date) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            details,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Fecha: $date',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
