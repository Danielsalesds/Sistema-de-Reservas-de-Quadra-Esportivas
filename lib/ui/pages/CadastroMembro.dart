
import 'package:clube/services/FirestoreService.dart';
import 'package:clube/ui/widgets/ErroDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../widgets/CustomAppBar.dart';
import '../widgets/CustomBottomBar.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomFAB.dart';
import '../widgets/CustomTelFormField.dart';
import '../widgets/CustomTextFormField.dart';
import '../widgets/SucessDialog.dart';
import 'ReservaQuadraScreen.dart';

class CadastroMembro extends StatefulWidget{
  

  const CadastroMembro({super.key});

  @override
  State<StatefulWidget> createState() => CadastroMembroPageState();

}
class CadastroMembroPageState extends State<CadastroMembro>{
  bool _isLoading = false;
  final emailTextController = TextEditingController();
  final senhaTextController = TextEditingController();
  final nomeTextController = TextEditingController();
  final telefoneTextController = TextEditingController();

  String _selecionado = 'Membro';
  String createPass(String nome){
    for(int i=0;i<nome.length;i++){
      if(nome[i]==' '){
        return '${nome.substring(0,i)}@Aa123';
      }
    }
    return '$nome@Aa123';
  }
  void signUp() async{
    if (nomeTextController.text.isEmpty || emailTextController.text.isEmpty || telefoneTextController.text.isEmpty) {
      showErrorDialog(context, 'Preencha todos os campos!');
      return;
    }

    final firestore = Provider.of<FirestoreService>(context, listen:false);
    setState(() {
      _isLoading = true;
    });
    try{
          String senha = createPass(nomeTextController.text);
          print(senha);
          await firestore.createMembro(nomeTextController.text,
          emailTextController.text, telefoneTextController.text, _selecionado,senha);
          if (!mounted) return;
          showSucessDialog(context,"O usuário ${nomeTextController.text} foi cadastrado com sucesso");
    }catch (e){
      showErrorDialog(context, e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Cadastrar',),
        bottomNavigationBar: const CustomBottomBar(),
        floatingActionButton: CustomFAB(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReservaQuadraScreen()),
              );
            }
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: true,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(),)
          : SingleChildScrollView(
            child: Column( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10,),
                 Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),child:ClipOval(child:Image.asset('assets/user-group.png',width: 250,height: 200,fit: BoxFit.cover),),
                        ),
                      ]
                  ),
                Text("Cadastrar Novo Membro",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(child: CustomTextFormField(label: "Nome completo", controller: nomeTextController,),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(child: CustomTelFormField(label: "Telefone", controller: telefoneTextController),),

                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(child: CustomTextFormField(label: "Email", controller: emailTextController), ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(value:  'Admin', groupValue: _selecionado, onChanged:(value){
                      setState(() {
                        _selecionado = value!;
                      });
                    }),
                    Text("Admin",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(width: 50,),
                    Radio<String>(value: 'Membro', groupValue: _selecionado, onChanged:(value){
                      setState(() {
                        _selecionado = value!;
                      });
                    }),
                    Text("Membro",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                CustomButton(height: 85, width: 250, text: "Cadastrar", onclick: signUp),
              ],
            ),
          )

    );
  }

}