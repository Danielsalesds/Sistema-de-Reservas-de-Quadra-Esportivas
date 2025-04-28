// import 'package:flutter/cupertino.dart';
// import 'LoginPage.dart';
// import 'RegisterPage.dart';
//
//
// class LoginOrRegisterPage extends StatefulWidget{
//   const LoginOrRegisterPage({super.key});
//
//   @override
//   State<StatefulWidget> createState() => LoginOrRegisterPageState();
//
// }
//
// class LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
//   bool shouldShowLoginPage = true;
//
//   void togglePages() {
//     setState(() {
//       shouldShowLoginPage = !shouldShowLoginPage;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return shouldShowLoginPage
//         ? LoginPage(
//       onTap: togglePages,
//     )
//         : RegisterPage(
//       onTap: togglePages,
//     );
//   }
// }