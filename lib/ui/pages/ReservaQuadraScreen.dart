import 'package:flutter/material.dart';
import 'package:clube/theme/theme.dart';

class ReservaQuadraScreen extends StatefulWidget {
  const ReservaQuadraScreen({super.key});

  @override
  State<ReservaQuadraScreen> createState() => _ReservaQuadraScreenState();
}

class _ReservaQuadraScreenState extends State<ReservaQuadraScreen> {
  DateTime? _selectedDate;
  int? _selectedQuadraIndex;

  Widget _buildStatusBadge(ThemeData theme, ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Disponível',
        style: theme.textTheme.labelSmall?.copyWith(
          color: colors.onSecondaryContainer,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar quadra', style: TextStyle(color: colors.onPrimary)),
        flexibleSpace: _buildAppBarGradient(),
        actions: [_buildLogoutButton(colors)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSelector(theme, context),
            const SizedBox(height: 20),
            Expanded(child: _buildQuadrasList(theme, colors)),
            _buildReserveButton(theme, colors),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarGradient() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFA7C7E7), Color(0xFF6B9AC4)],
          stops: [0, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildLogoutButton(ColorScheme colors) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.logout),
      color: colors.onPrimary,
    );
  }

  Widget _buildDateSelector(ThemeData theme, BuildContext context) {
    return Row(
      children: [
        Icon(Icons.calendar_today, color: theme.colorScheme.primary),
        const SizedBox(width: 10),
        Text(
          'Data selecionada:',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(width: 10),
        Text(
          _selectedDate != null
              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
              : 'Nenhuma data',
          style: theme.textTheme.bodyLarge,
        ),
        const Spacer(),
        TextButton(
          onPressed: () => _selectDate(context),
          child: const Text('data'),
        ),
      ],
    );
  }

  Widget _buildQuadrasList(ThemeData theme, ColorScheme colors) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => _selectQuadra(index),
        child: Card(
          color: _selectedQuadraIndex == index
              ? colors.primaryContainer
              : colors.surfaceContainerHighest,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.sports_tennis, color: colors.primary),
                    const SizedBox(width: 10),
                    Text(
                      'Quadra ${index + 1}',
                      style: theme.textTheme.titleLarge,
                    ),
                    const Spacer(),
                    _buildStatusBadge(theme, colors),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Tipo: Saibro • Capacidade: 4 pessoas',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Localização: Setor ${index + 1}',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectQuadra(int index) {
    setState(() {
      _selectedQuadraIndex = index;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedQuadraIndex = null;
      });
    }
  }

  Widget _buildReserveButton(ThemeData theme, ColorScheme colors) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: _selectedDate != null && _selectedQuadraIndex != null
            ? () => _confirmReservation()
            : null,
        style: FilledButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
        ),
        child: const Text('Confirmar Reserva'),
      ),
    );
  }

  void _confirmReservation() {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reserva Confirmada'),
        content: Text('Quadra ${_selectedQuadraIndex! + 1} para '
            '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}