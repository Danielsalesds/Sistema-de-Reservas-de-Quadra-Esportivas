import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clube/ui/widgets/ErroDialog.dart';
import 'package:clube/ui/widgets/SucessDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/FirestoreService.dart';
import '../../../theme/AppColors.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomBottomBar.dart';
import '../../widgets/CustomButton.dart';
import '../../widgets/CustomFAB.dart';
import '../../widgets/CustomTextFormField.dart';
import '../tipo_quadra/ListarTipoQuadras.dart';

class CadastrarQuadra extends StatefulWidget{
  const CadastrarQuadra({super.key});

  @override
  State<StatefulWidget> createState() => CadastrarQuadraState();
}

class CadastrarQuadraState extends State<CadastrarQuadra>{
  final capacidadeTextController = TextEditingController();
  final nomeTextController = TextEditingController();
  final tipoQuadraTextController = TextEditingController();
  String? tipoQuadraId;
  bool status = false;
  Future<void> create() async {
    final firestore = Provider.of<FirestoreService>(context, listen:false);
    try{
      if(nomeTextController.text.isEmpty || capacidadeTextController.text.isEmpty || tipoQuadraId!.isEmpty){
        showErrorDialog(context, "Preencha todos os campos!");
        return;
      }
      final t = await firestore.isNomeDisponivel(tipoQuadraId!, nomeTextController.text);

      if(!t){
        if(!mounted) return;
        showErrorDialog(context,'Já existe quadra com esse nome. Adicione um nome diferente');
        return;
      }

      await firestore.createQuadra(nomeTextController.text, status, int.parse(capacidadeTextController.text), tipoQuadraId!);
      if(!mounted) return;
      showSucessDialog(context, 'Nova quadra adicionada!');
    }catch (e){
      throw Exception(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreService>(context, listen:false);
    final colors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Criar quadras',),
      bottomNavigationBar: const CustomBottomBar(),
      floatingActionButton: const CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),child:ClipOval(child:Image.asset('assets/soccer.png', width: 250,height: 200,fit: BoxFit.cover),),
                  ),
                ]
            ),
            Text("Adicionar Nova Quadra",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: CustomTextFormField(label: "Nome", controller: nomeTextController,),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: CustomTextFormField(label: "Capacidade", controller: capacidadeTextController, keyboardType: const TextInputType.numberWithOptions(signed: false),), ),
              ],
            ),
            const SizedBox(height: 20,),
            Row(children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal:  35),
                child:StreamBuilder<QuerySnapshot>(
                    stream: firestore.getAllTipoQuadra(),
                    builder:  (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      var tipos = snapshot.data!.docs;
                      return SizedBox(width: 340,
                          child: DropdownButton<String>(
                            value: tipoQuadraId,
                            hint: Padding(padding:const EdgeInsets.only(left:10,bottom: 15),
                            child: Text('Selecione o tipo de quadra',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ),
                            items: tipos.map((DocumentSnapshot doc) {
                            String nome = doc['nome'];
                            String id = doc['id'];
                            return DropdownMenuItem<String>(
                              value: id,
                              child: Padding(padding: const EdgeInsets.only(left:10,bottom: 15),
                                child: Text(nome,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                            ),)
                              );}).toList(),
                            onChanged: (String? novoTipo) {
                              setState(() {
                                tipoQuadraId = novoTipo;
                              });
                            },
                            isExpanded: true,
                            underline: Container(
                                height: 3,
                                color: Theme.of(context).colorScheme.primary,
                              ),

                          )
                      );
                    }),
              ),
            ],),
            const SizedBox(height: 20,),
            Row(
              children: [
                Padding(padding: const EdgeInsets.only(left: 45,),
                  child: Text('Status',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                const SizedBox(width: 5,),
                Switch(
                  value: status,
                  onChanged: (bool value) {
                    setState(() {
                      status = value;
                    });
                  },
                ),
                const SizedBox(width: 25,),
                buildFilledButton(context, colors, firestore)
              ],
            ),
            const SizedBox(height: 10,),
            CustomButton(height: 85, width: 250, text: "Cadastrar", onclick: create),
          ],
        ),
      ),
    );
  }

  FilledButton buildFilledButton(BuildContext context, AppColors colors, FirestoreService firestore) {
    return FilledButton.icon(
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ListarTipoQuadras()));
                    },
                  label: const Text("Tipo de Quadra"),
                  icon: const Icon(Icons.add),
              );
  }

}