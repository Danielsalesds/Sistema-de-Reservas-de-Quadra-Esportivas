import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clube/services/FirestoreService.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:clube/ui/widgets/CustomFAB.dart';
import 'package:intl/intl.dart';

import '../../theme/AppColors.dart';

class ReservaQuadraScreen extends StatefulWidget {
  const ReservaQuadraScreen({Key? key}) : super(key: key);

  @override
  _ReservaQuadraScreenState createState() => _ReservaQuadraScreenState();
}

class _ReservaQuadraScreenState extends State<ReservaQuadraScreen> {
  String? _selectedTipoQuadraId;
  TimeOfDay? _selectedTime;
  DateTime _selectedDate = DateTime.now();
  bool _isSubmitting = false;
  Map<String, String> _tipos = {};
  bool _loaded = false;

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
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: DateTime.now().hour, minute: 0),
    );
    if (time != null) setState(() => _selectedTime = time);
  }

  Future<void> _submit() async {
    if (_selectedTipoQuadraId == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione tipo e horário.')),
      );
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reserva criada com sucesso!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
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
                  const Text('Tipo de Quadra'),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    items: _tipos.entries
                        .map((e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(e.value),
                            ))
                        .toList(),
                    value: _selectedTipoQuadraId,
                    onChanged: (v) => setState(() => _selectedTipoQuadraId = v),
                  ),
                  const SizedBox(height: 12),
                  const Text('Data'),
                  InkWell(
                    onTap: _pickDate,
                    child: InputDecorator(
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      child: Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Horário (início)'),
                  InkWell(
                    onTap: _pickTime,
                    child: InputDecorator(
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      child: Text(_selectedTime?.format(context) ?? 'Selecione o horário'),
                    ),
                  ),
                  const Spacer(),
                  Padding(padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.baseColor,
                          foregroundColor: colors.onBaseColor,
                        ),
                        child: Text(_isSubmitting ? 'Aguarde...' : 'Reservar'),
                      ),
                    )
                  )

                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
