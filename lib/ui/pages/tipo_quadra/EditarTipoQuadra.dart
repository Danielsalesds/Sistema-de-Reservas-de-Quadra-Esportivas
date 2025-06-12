import 'package:clube/ui/widgets/CustomAppBar.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:clube/ui/widgets/CustomFAB.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/FirestoreService.dart';
import '../../widgets/CustomButton.dart';
import '../../widgets/CustomTextFormField.dart';
import '../../widgets/ErroDialog.dart';
import '../../widgets/SucessDialog.dart';

class EditarTipoQuadra extends StatefulWidget{
  final String nome, id;


  const EditarTipoQuadra({super.key, required this.nome, required this.id,});
  @override
  State<StatefulWidget> createState() => EditarTipoQuadraState();

}

class EditarTipoQuadraState extends State<EditarTipoQuadra> {
  final nomeTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() {
    setState(() {
      nomeTextController.text = widget.nome;
    });
  }

  void edit() async{
    try {
      final firestore = Provider.of<FirestoreService>(context, listen: false);
      String nomeNormalizado = removeDiacritics(nomeTextController.text.trim().toLowerCase());
      final t = await firestore.isNomeDisponivelTipo(nomeTextController.text);
      if(!t){
        if(!mounted) return;
        showErrorDialog(context,'Já existe quadra com esse nome. Adicione um nome diferente');
        return;
      }
      firestore.editTipoQuadra({
        'nome': nomeTextController.text,
        'nomeNormalizado': nomeNormalizado
      }, widget.id);
      if(!mounted) return;
      showSucessDialog(context, "O tipo de quadra foi editado!");
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Editar tipo quadra'),
        bottomNavigationBar: const CustomBottomBar(),
        floatingActionButton: const CustomFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SingleChildScrollView(
          child: Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 50, left: 35),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Informações do tipo de quadra",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 5, left: 35),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text("Altere as informações do tipo abaixo",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),)
                    ],
                  ),
                ),
                const SizedBox(height: 50,),
                Row(
                  children: [
                    Expanded(child: CustomTextFormField(
                      label: "Nome", controller: nomeTextController,),),
                  ],
                ),
                const SizedBox(height: 50,),
                CustomButton(
                    height: 85, width: 250, text: "Atualizar", onclick: edit),
              ]
          ),
        )
    );
  }
}