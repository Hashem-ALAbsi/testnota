// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Widget/textfilder.dart';

class fmsingin extends StatefulWidget {
  const fmsingin({super.key});

  @override
  State<fmsingin> createState() => _fmsinginState();
}

class _fmsinginState extends State<fmsingin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Form(
                key: formstate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 100,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[800],
                            borderRadius: BorderRadius.circular(70),
                          ),
                          child: Image.asset(
                            "assets/images/hunterr.png",
                            height: 80,
                            fit: BoxFit.fill,
                          )),
                    ),
                    Container(height: 20),
                    Text(
                      "Sign up",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Container(height: 10),
                    Text("Login to use App",
                        style: TextStyle(color: Colors.grey)),
                    Container(height: 20),
                    Text(
                      "Email",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(height: 10),
                    CustmerTextFail(
                        hinttext: "Enter Your Email",
                        mycontroller: email,
                        validator: (p0) {
                          if (p0 == "") {
                            return "Enter Email Please";
                          }
                        }),
                    Container(height: 20),
                    Text(
                      "Password",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(height: 10),
                    CustmerTextFail(
                        hinttext: "Enter Your Password",
                        mycontroller: password,
                        validator: (p0) {
                          if (p0 == "") {
                            return "Enter Password Please";
                          }
                        }),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      alignment: Alignment.topRight,
                      child: Text(
                        "Forget Password ?",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.deepPurple[800],
                textColor: Colors.white,
                onPressed: () async {
                  if (formstate.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      Navigator.of(context).pushReplacementNamed("homepage");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'The password provided is too weak',
                        ).show();
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                        // ignore: use_build_context_synchronously
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: "Error",
                            desc: "The account already exists for that email");
                      }
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'Enter All Infromicion',
                    ).show();
                  }
                },
                child: Text("Sign up"),
              ),
              Container(height: 20),
              Text(
                "OR Sign up",
                textAlign: TextAlign.center,
              ),
              Container(
                height: 20,
              ),
              MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.red[800],
                textColor: Colors.white,
                onPressed: () {},
                child: Text("signup With Google"),
              ),
              Container(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed("fmlogin");
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Do Have An Account ? ",
                        ),
                        TextSpan(
                            text: "Log in",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                                fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
