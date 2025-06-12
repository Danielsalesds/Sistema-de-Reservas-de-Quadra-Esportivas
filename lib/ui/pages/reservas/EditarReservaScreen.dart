import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clube/services/FirestoreService.dart';
import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:clube/ui/widgets/CustomButton.dart';
import 'package:clube/ui/widgets/CustomFAB.dart';
import 'package:clube/ui/widgets/SucessDialog.dart';
import 'package:clube/ui/widgets/ErroDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditarReservaScreen extends StatefulWidget {
  final String reservaId;
  final DateTime dataHora;
  final String tipoQuadraId;
  final String quadraId;

  const EditarReservaScreen({
    super.key,
    required this.reservaId,
    required this.dataHora,
    required this.tipoQuadraId,
    required this.quadraId,
  });

  @override
  State<EditarReservaScreen> createState() => _EditarReservaScreenState();
}

class _EditarReservaScreenState extends State<EditarReservaScreen> {
  DateTime _dataSelecionada = DateTime.now();
  TimeOfDay _horaSelecionada = TimeOfDay.now();
  late String _tipoQuadraId;
  late String _quadraNome = '';
  late String _tipoQuadraNome = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _dataSelecionada = widget.dataHora;
    _horaSelecionada = TimeOfDay.fromDateTime(widget.dataHora);
    _tipoQuadraId = widget.tipoQuadraId;
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final firestore = Provider.of<FirestoreService>(context, listen: false);
    
    try {
      // Carregar nome da quadra
      _quadraNome = await firestore.getQuadraNome(widget.quadraId);
      
      // Carregar nome do tipo de quadra
      _tipoQuadraNome = await firestore.getTipoQuadra(widget.tipoQuadraId);
      
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        showErrorDialog(context, "Erro ao carregar dados: ${e.toString()}");
      }
    }
  }

  Future<void> _selecionarData() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null && picked != _dataSelecionada) {
      setState(() {
        _dataSelecionada = picked;
      });
    }
  }

  Future<void> _selecionarHora() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _horaSelecionada,
    );

    if (picked != null && picked != _horaSelecionada) {
      setState(() {
        _horaSelecionada = picked;
      });
    }
  }

  Future<void> _atualizarReserva() async {
    final firestore = Provider.of<FirestoreService>(context, listen: false);
    
    try {
      setState(() {
        _isLoading = true;
      });
      
      // Combinar data e hora selecionadas
      final DateTime novaDataHora = DateTime(
        _dataSelecionada.year,
        _dataSelecionada.month,
        _dataSelecionada.day,
        _horaSelecionada.hour,
        _horaSelecionada.minute,
      );
      
      // Verificar se a data/hora é futura
      if (novaDataHora.isBefore(DateTime.now())) {
        showErrorDialog(context, "Não é possível agendar para um horário passado");
        setState(() {
          _isLoading = false;
        });
        return;
      }
      
      // Atualizar a reserva no Firestore
      await firestore.updateReserva(widget.reservaId, {
        'dataHora': Timestamp.fromDate(novaDataHora),
        'tipoQuadraId': _tipoQuadraId,
      });
      
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        showSucessDialog(context, "Reserva atualizada com sucesso");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        showErrorDialog(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Editar Reserva'),
      bottomNavigationBar: const CustomBottomBar(),
      floatingActionButton: const CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: Text(
                        "Editar Reserva",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Informações da Quadra",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("Quadra: $_quadraNome"),
                            Text("Tipo: $_tipoQuadraNome"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Data da Reserva",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: _selecionarData,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(DateFormat('dd/MM/yyyy').format(_dataSelecionada)),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Horário da Reserva",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: _selecionarHora,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_horaSelecionada.format(context)),
                            const Icon(Icons.access_time),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: CustomButton(
                        height: 60,
                        width: 250,
                        text: "Atualizar Reserva",
                        onclick: _atualizarReserva,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}