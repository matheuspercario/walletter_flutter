import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/logic/manage_auth/auth_bloc.dart';
import 'package:walletter/logic/manage_auth/auth_event.dart';
import 'package:walletter/view/auth/register.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final LoginUser loginData = new LoginUser(); // evento

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    'assets/images/money_logo.png',
                    fit: BoxFit.contain,
                    height: 50,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Walletter",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                ],
              ),
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    usernameTextField(),
                    SizedBox(
                      height: 16,
                    ),
                    passwordTextField(),
                    SizedBox(
                      height: 30,
                    ),
                    submitButton(context),
                  ],
                ),
              ),
              registerNavigation(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget registerNavigation(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Novo usuário?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/register');
            },
            child: Text(
              " Registre-se aqui!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent.shade700),
            ),
          )
        ],
      ),
    );
  }

  Widget submitButton(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // if (formKey.currentState.validate()) {
          //   formKey.currentState.save();
          //   loginForm.doSomething();
          //   // Navigator.pushReplacementNamed(context, '/homepage');
          //   // Navigator.pushNamed(context, '/homepage');
          // } else {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       backgroundColor: Colors.red.shade600,
          //       duration: Duration(seconds: 2),
          //       content: Text("Email e/ou senha inválidos!"),
          //       action: SnackBarAction(
          //         label: "OK",
          //         onPressed: () {
          //           print("Funcionou");
          //         },
          //       ),
          //     ),
          //   );
          // }
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            BlocProvider.of<AuthBloc>(context).add(loginData);
          }
        },
        child: Text(
          "LOGIN",
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 7,
          primary: Colors.greenAccent.shade700,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(40),
          ),
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(fontSize: 18, color: Colors.black87),
      validator: (String inValue) {
        if (inValue.length < 10) {
          return "Mínimo de 10 letras";
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(left: 25, right: 25),
        hintText: "Senha",
        hintStyle: TextStyle(fontSize: 18, color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: BorderSide(
            color: Colors.greenAccent.shade700,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      onSaved: (String inValue) {
        loginData.password = inValue;
      },
    );
  }

  Widget usernameTextField() {
    return TextFormField(
      style: TextStyle(fontSize: 18, color: Colors.black87),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(left: 25, right: 25),
        labelText: "Email",
        labelStyle: TextStyle(fontSize: 18, color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: BorderSide(
            color: Colors.greenAccent.shade700,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      validator: (String inValue) {
        if (inValue.length == 0) {
          return "Insira um nome de usuário";
        }
        return null;
      },
      onSaved: (String inValue) {
        loginData.username = inValue;
      },
    );
  }
}
