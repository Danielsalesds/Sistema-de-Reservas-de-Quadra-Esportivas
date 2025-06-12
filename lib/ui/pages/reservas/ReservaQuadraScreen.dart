import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clube/services/FirestoreService.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:clube/ui/widgets/CustomFAB.dart';
import 'package:intl/intl.dart';

import '../../../theme/AppColors.dart';

class ReservaQuadraScreen extends StatefulWidget {
  const ReservaQuadraScreen({super.key});

  @override
  ReservaQuadraScreenState createState() => ReservaQuadraScreenState();
}

class ReservaQuadraScreenState extends State<ReservaQuadraScreen> {
  String? _selectedTipoQuadraId;
  TimeOfDay? _selectedTime;
  DateTime _selectedDate = DateTime.now();
  bool _isSubmitting = false;
  Map<String, String> _tipos = {};
  bool _loaded = false;

  // Horários disponíveis (7:00 às 21:00, de hora em hora)
  final List<TimeOfDay> _horariosDisponiveis = List.generate(
    15, // 22 - 7 = 15 horários
    (index) => TimeOfDay(hour: 7 + index, minute: 0),
  );

  @override
  void initState() {
    super.initState();
    _loadTipos();
  }

  Future<void> _loadTipos() async {
    final service = Provider.of<FirestoreService>(context, listen: false);
    final map = await service.getAllTipoQuadraMap();
    setState(() {
      _tipos = map;
      _loaded = true;
    });
  }

  Future<void> _pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _pickTime() async {
    // Mostrar dialog personalizado com horários disponíveis
    final TimeOfDay? time = await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecione o horário'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _horariosDisponiveis.length,
              itemBuilder: (context, index) {
                final horario = _horariosDisponiveis[index];
                return ListTile(
                  title: Text(horario.format(context)),
                  onTap: () {
                    Navigator.of(context).pop(horario);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
    
    if (time != null) setState(() => _selectedTime = time);
  }

  Future<void> _submit() async {
    if (_selectedTipoQuadraId == null || _selectedTime == null) {
      _showErrorSnackBar('Por favor, selecione o tipo de quadra e o horário.');
      return;
    }

    setState(() => _isSubmitting = true);
    final service = Provider.of<FirestoreService>(context, listen: false);
    final dt = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    try {
      await service.createReserva(
        tipoQuadraId: _selectedTipoQuadraId!,
        dataHora: dt,
      );
      _showSuccessSnackBar('Reserva criada com sucesso!');
      Navigator.pop(context);
    } catch (e) {
      _showErrorSnackBar(e.toString().replaceAll('Exception: ', ''));
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Fechar',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Reservar Quadra'),
      bottomNavigationBar: const CustomBottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const CustomFAB(),
      body: _loaded
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tipo de Quadra',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Selecione o tipo de quadra',
                    ),
                    items: _tipos.entries
                        .map((e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(e.value),
                            ))
                        .toList(),
                    value: _selectedTipoQuadraId,
                    onChanged: (v) => setState(() => _selectedTipoQuadraId = v),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Data',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _pickDate,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      child: Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        'Horário (início)',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 8),
                      Tooltip(
                        message: 'Funcionamento: 07:00 às 22:00',
                        child: Icon(
                          Icons.info_outline,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _pickTime,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.access_time),
                      ),
                      child: Text(
                        _selectedTime?.format(context) ?? 'Selecione o horário',
                        style: TextStyle(
                          color: _selectedTime == null ? Colors.grey[600] : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info, color: Colors.blue[700], size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Informações importantes:',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[700],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '• Horário de funcionamento: 07:00 às 22:00\n'
                          '• Cada reserva tem duração de 1 hora\n'
                          '• Apenas uma reserva por tipo de quadra por dia\n'
                          '• Reservas devem ser feitas em horários fechados',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.baseColor,
                          foregroundColor: colors.onBaseColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isSubmitting
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Reservar',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}