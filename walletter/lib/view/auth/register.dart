import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletter/logic/manage_auth/auth_bloc.dart';
import 'package:walletter/logic/manage_auth/auth_event.dart';
import 'package:walletter/view/auth/login.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final RegisterUser registerData = new RegisterUser();
  //RegisterForm registerForm = new RegisterForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Olá u\$er,",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Registre-se aqui para continuar!",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade400),
                    ),
                    SizedBox(
                      height: 75,
                    ),
                  ],
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Informações cadastrais",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      registrationInfos(),
                      Divider(
                        height: 100,
                      ),
                      Text(
                        "Outras informações",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      personalInfos(),
                      SizedBox(
                        height: 30,
                      ),
                      submitButton(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                loginNavigation(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget personalInfos() {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Text(
              "Você possui dependentes?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            mySwitchDependents(),
          ],
        ),
        Row(
          children: [
            Text(
              "Você possui cartão de crédito?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            mySwitchCreditCard(),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Text(
              "Idade: ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "${registerData.sliderValue.floor()}",
              style: TextStyle(
                  color: Colors.greenAccent.shade700,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              " anos",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
        mySlider(),
        SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Text(
              "Informe sua renda mensal:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 7,
        ),
        Row(
          children: [myRadio(1), Text("Menos que R\$ 1.000,00")],
        ),
        Row(
          children: [myRadio(2), Text("Entre R\$ 1.000,00 e R\$ 2.500,00")],
        ),
        Row(
          children: [myRadio(3), Text("Entre R\$ 2.500,00 e R\$ 5.000,00")],
        ),
        Row(
          children: [myRadio(4), Text("Entre R\$ 5.000,00 e R\$ 10.000,00")],
        ),
        Row(
          children: [myRadio(5), Text("Mais que R\$ 10.000,00")],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Text(
              "Selecione os bens que possui:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 7,
        ),
        Row(
          children: [myCheckboxCasa(), Text("Casa própria")],
        ),
        Row(
          children: [myCheckboxCarro(), Text("Automóvel")],
        ),
        Row(
          children: [myCheckboxMoto(), Text("Motocicleta")],
        ),
        Row(
          children: [myCheckboxBicicleta(), Text("Bicicleta")],
        ),
      ],
    );
  }

  Widget registrationInfos() {
    return Column(
      children: [
        // Nome completo
        TextFormField(
          style: TextStyle(fontSize: 15, color: Colors.black87),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: "Nome completo",
            labelStyle: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w600),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(width: 2, color: Colors.greenAccent.shade700),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          validator: (String inValue) {
            if (inValue.length == 0) {
              return "Insira seu nome completo";
            }
            return null;
          },
          onSaved: (String inValue) {
            registerData.fullName = inValue;
          },
        ),
        SizedBox(
          height: 16,
        ),
        // Email
        TextFormField(
          style: TextStyle(fontSize: 15, color: Colors.black87),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: "Email",
            labelStyle: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w600),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(width: 2, color: Colors.greenAccent.shade700),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          validator: (String inValue) {
            if (inValue.length == 0) {
              return "Insira seu email";
            }
            return null;
          },
          onSaved: (String inValue) {
            registerData.username = inValue;
          },
        ),
        SizedBox(
          height: 16,
        ),
        // Senha
        TextFormField(
          obscureText: true,
          style: TextStyle(fontSize: 15, color: Colors.black87),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: "Senha",
            labelStyle: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w600),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(width: 2, color: Colors.greenAccent.shade700),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          validator: (String inValue) {
            if (inValue.length == 0) {
              return "Insira uma senha";
            }
            return null;
          },
          onSaved: (String inValue) {
            registerData.password = inValue;
          },
        ),
      ],
    );
  }

  Widget mySwitchDependents() {
    return Switch(
      activeColor: Colors.greenAccent.shade700,
      value: registerData.switchDependents,
      onChanged: (bool inValue) {
        setState(() {
          registerData.switchDependents = inValue;
        });
      },
    );
  }

  Widget mySwitchCreditCard() {
    return Switch(
      activeColor: Colors.greenAccent.shade700,
      value: registerData.switchCreditCard,
      onChanged: (bool inValue) {
        setState(() {
          registerData.switchCreditCard = inValue;
        });
      },
    );
  }

  Widget mySlider() {
    return Slider(
      activeColor: Colors.greenAccent.shade700,
      divisions: 100,
      value: registerData.sliderValue,
      onChanged: (double inValue) {
        setState(() {
          registerData.sliderValue = inValue;
        });
      },
      min: 0,
      max: 100,
    );
  }

  Widget myRadio(int value) {
    return Radio(
      activeColor: Colors.greenAccent.shade700,
      value: value,
      groupValue: registerData.radioValue,
      onChanged: (int inValue) {
        setState(() {
          registerData.radioValue = inValue;
        });
      },
    );
  }

  Widget myCheckboxCasa() {
    return Checkbox(
      activeColor: Colors.greenAccent.shade700,
      value: registerData.checkBoxCasa,
      onChanged: (bool value) {
        setState(() {
          registerData.checkBoxCasa = value;
        });
      },
    );
  }

  Widget myCheckboxCarro() {
    return Checkbox(
      activeColor: Colors.greenAccent.shade700,
      value: registerData.checkBoxCarro,
      onChanged: (bool value) {
        setState(() {
          registerData.checkBoxCarro = value;
        });
      },
    );
  }

  Widget myCheckboxMoto() {
    return Checkbox(
      activeColor: Colors.greenAccent.shade700,
      value: registerData.checkBoxMoto,
      onChanged: (bool value) {
        setState(() {
          registerData.checkBoxMoto = value;
        });
      },
    );
  }

  Widget myCheckboxBicicleta() {
    return Checkbox(
      activeColor: Colors.greenAccent.shade700,
      value: registerData.checkBoxBicicleta,
      onChanged: (bool value) {
        setState(() {
          registerData.checkBoxBicicleta = value;
        });
      },
    );
  }

  Widget submitButton() {
    return Container(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (formKey.currentState.validate()) {
            await showDialog(
              context: formKey.currentContext,
              builder: (_) => generateConfirmationDialog(),
              barrierDismissible: false,
              useRootNavigator: false,
            );
            // if (formKey.currentState.validate()) {
            //   formKey.currentState.save();
            //   registerData.doSomething();
            //   registerData.confirmed = false;
            //   //Navigator.pop(context);
            // }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red.shade600,
                duration: Duration(seconds: 2),
                content: Text("Ainda faltam algumas informações..."),
                action: SnackBarAction(
                  label: "OK",
                  onPressed: () {
                    print("Funcionou");
                  },
                ),
              ),
            );
          }
        },
        child: Text(
          "CADASTRAR",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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

  Widget generateConfirmationDialog() {
    return AlertDialog(
      title: Text(
        "Finalizar cadastro",
      ),
      content: Text(
        "Realmente deseja realizar seu cadastro?",
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            registerData.confirmed = true;
            formKey.currentState.save();
            Navigator.of(context).pop();
            BlocProvider.of<AuthBloc>(context).add(registerData);
          },
          child: Text("Sim"),
          style: ElevatedButton.styleFrom(
            primary: Colors.greenAccent.shade400,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            registerData.confirmed = false;
            Navigator.of(context).pop();
          },
          child: Text("Não"),
          style: ElevatedButton.styleFrom(
            primary: Colors.redAccent.shade400,
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget loginNavigation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Já sou membro. ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(context, '/');
            },
            child: Text(
              "Entrar!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent.shade700),
            ),
          )
        ],
      ),
    );
  }
}
