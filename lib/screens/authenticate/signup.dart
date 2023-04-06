import 'package:farmmitra/screens/authenticate/signin.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
           child: Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 40),
               child: SingleChildScrollView(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     SizedBox(
                       height: MediaQuery.of(context).size.height*0.17,
                     ),
                     Text("Let's create an account for you"),
                     SizedBox(
                       height: 20,
                     ),
                     Row(
                       children: [
                         Text('Sign Up', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900,color: Colors.orange),),
                       ],
                     ),
                     SizedBox(
                       height: 10,
                     ),
                     Container(
                       height: MediaQuery.of(context).size.height*0.35,
                       width: 294,
                       decoration: BoxDecoration(
                         border: Border.all(width: 1, color: Colors.blue),
                       ),
                       child: Padding(
                         padding: const EdgeInsets.fromLTRB(8, 13, 8,8 ),
                         child: Column(
                           children: [
                             Row(
                               children: [
                                 SizedBox(
                                   width: 5,
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text('Enter your mobile number'),
                                 ),
                               ],
                             ),
                             Container(
                               width: 238,
                               height: 43,
                               decoration: BoxDecoration(
                                 border: Border.all(width: 1, color: Colors.blue)
                               ),
                               child: TextField(
                                 decoration: InputDecoration(
                                   border: InputBorder.none

                                 ),
                               ),
                             ),
                             SizedBox(
                               height: 30,
                             ),
                             Container(
                               width: 146,
                               height: 49,
                               child: ElevatedButton(onPressed: () { },
                                 child: Text('Send OTP', style: TextStyle(
                                     color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16
                                 ),),
                                 style: ElevatedButton.styleFrom(
                                     backgroundColor: Colors.green[700],
                                     elevation: 0,
                                     shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(15),
                                         side: BorderSide(width: 1, color: Colors.blue)
                                     )
                                 ),),
                             ),
                             Row(
                               children: [
                                 SizedBox(
                                   width: 5,
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text('Enter OTP'),
                                 ),
                               ],
                             ),
                             Container(
                               width: 238,
                               height: 43,
                               decoration: BoxDecoration(
                                   border: Border.all(width: 1, color: Colors.blue)
                               ),
                               child: TextField(
                                 decoration: InputDecoration(
                                     border: InputBorder.none

                                 ),
                               ),
                             )
                           ],
                         ),
                       ),
                     ),
                     SizedBox(
                       height: 15,
                     ),
                     Container(
                       width: 146,
                       height: 49,
                       child: ElevatedButton(onPressed: () { },
                         child: Text('Continue', style: TextStyle(
                           color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16
                         ),),
                         style: ElevatedButton.styleFrom(
                             backgroundColor: Colors.green[700],
                           elevation: 0,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15),
                             side: BorderSide(width: 1, color: Colors.blue)
                           )
                         ),),
                     ),
                     SizedBox(
                       height: 20,
                     ),
                     Text('Already have an account?', style: TextStyle(fontSize: 18),),
                     TextButton(onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                     }, child: Text('Log In',style: TextStyle(fontSize: 20, color: Colors.orange), ))
                   ],
                 ),
               ),
             ),
           ), 
          ),
      ),
    );
  }
}
