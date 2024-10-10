// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testnota/Widget/textfilder.dart';

class fmlogin extends StatefulWidget {
  const fmlogin({super.key});

  @override
  State<fmlogin> createState() => _fmloginState();
}

class _fmloginState extends State<fmlogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return; //==================
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    //Navigator.of(context).pushReplacementNamed("homepage");
    Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
  }

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
                      "Login",
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
                      },
                    ),
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
                    InkWell(
                      onTap: () async {
                        if (email.text == "") {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'Plese Enter Your Email',
                          ).show();
                          return;
                        }
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'Done',
                          desc: 'Done Send Massage',
                        ).show();
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email.text);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 20),
                        alignment: Alignment.topRight,
                        child: Text(
                          "Forget Password ?",
                          style: TextStyle(fontSize: 14),
                        ),
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
                          .signInWithEmailAndPassword(
                              email: email.text, password: password.text);
                      Navigator.of(context).pushReplacementNamed("homepage");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'No user found for that email',
                        ).show();
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Wrong password provided for that user',
                        ).show();
                      }
                    }
                  } else {
                    print("enter information");
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'Enter All Infromicion',
                    ).show();
                  }
                },
                child: Text("LogIn"),
              ),
              Container(height: 20),
              Text(
                "OR Login",
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
                onPressed: () {
                  signInWithGoogle();
                },
                child: Text("LogIn With Google"),
              ),
              Container(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed("fmsingin");
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't Have An Account ? ",
                        ),
                        TextSpan(
                            text: "Register",
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

// showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   title: Text("Error"),
//                                   content: Text("Plese Enter email"),
//                                   actions: [
//                                     MaterialButton(
//                                       onPressed: () {},
//                                       child: Text("OK"),
//                                     ),
//                                     MaterialButton(
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                       },
//                                       child: Text("Cencel"),
//                                     ),
//                                   ],
//                                 );
//                               });
