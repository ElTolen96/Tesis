import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:proyecto_withe_power/Controlador/servicios/api_services.dart';
import 'package:proyecto_withe_power/Controlador/servicios/reniec_api_service.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Modelo/RENIECDni.dart';
import 'package:proyecto_withe_power/Modelo/Respuesta.dart';
import 'package:proyecto_withe_power/Modelo/Usuario.dart';
import 'package:proyecto_withe_power/Vista/daniel/textfield_normal_Icons_widget.dart';
import 'package:proyecto_withe_power/Vista/daniel/textfield_password_normal_Icons_widget.dart';

import '../../Controlador/navegacion.dart';
import '../daniel/dropdown_button2.dart';
import '../daniel/general_widget.dart';

class RegistroUsuario extends StatefulWidget {
  static final String routeName = Mensajes.RUTA_REGISTROUSUARIO;
  String? celular;

  RegistroUsuario({required this.celular});

  @override
  _RegistroUsuarioState createState() => _RegistroUsuarioState();
}

TextEditingController dn = TextEditingController();
TextEditingController pass = TextEditingController();
TextEditingController use = TextEditingController();

String DN = "";
String US = "";
String PAS = "";

//Users users = Users(0, '', '', '');
class _RegistroUsuarioState extends State<RegistroUsuario> {
  int _currentStep = 0;

  StepperType stepperType = StepperType.horizontal;
  final GlobalKey<FormFieldState> _keySexo = GlobalKey<FormFieldState>();
  final APIServices _apiServices = APIServices();
  GlobalKey<FormState> _formDatosPersonalesKey = GlobalKey<FormState>();

  final _formCuentaKey = GlobalKey<FormState>();

  final ReniecAPIService _reniecAPIService = ReniecAPIService();
  ReniecDNIModel? reniecDNIModel;

  TextEditingController fechaNacimientoController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController telefonoNuevoController = TextEditingController();
  TextEditingController sexoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passworConfirmdController = TextEditingController();
  String sexo = "";
  RespuestaModel? respuestaModel;
  List<String> sexItems = [
    "MASCULINO",
    "FEMENINO",
  ];

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    if (_currentStep == 0) {
      if (_formDatosPersonalesKey.currentState!.validate()) {
        if (telefonoNuevoController.text.length < 12) {
          messageSuccessInfoSnackBar(
              context, "Debe Ingresar un N° de telefono de 9 dígitos");
        } else if (telefonoNuevoController.text.length > 12) {
          messageSuccessInfoSnackBar(
              context, "Solo debe Ingresar un N° de telefono de 9 dígitos");
        }else{
          _currentStep += 1;
          setState(() {});
        }
      } else {
        messageSuccessInfoSnackBar(context, "Debe ingresar todos los datos");
      }
    }

    if (_currentStep == 1) {
      if (_formCuentaKey.currentState!.validate()) {
        UsuarioModel usuarioModel = UsuarioModel(
            docTipo: "DNI",
            docNumero: dniController.text,
            apellidos: apellidoController.text,
            nombres: nombreController.text,
            genero: sexo,
            telefono: telefonoNuevoController.text,
            fechaNacimiento: fechaNacimientoController.text,
            email: emailController.text,
            userName: "--",
            clave: passwordController.text,
            imagen: "--",
            idTipoRegistro: 2);

        if (passwordController.text == passworConfirmdController.text) {
          postRegistrarUsuario(usuarioModel);
          setState(() {});
        } else {
          messageSuccessInfoSnackBar(context, "Las contraseñas no son iguales");
        }
      } else {
        messageSuccessInfoSnackBar(context, "Debe ingresar todos los datos");
      }
    }
    //_currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  postRegistrarUsuario(UsuarioModel usuarioModel) async {
    _apiServices.postRegistrarUsuario(usuarioModel).then((value) {
      respuestaModel = value;
      if (respuestaModel!.resultado == "1") {
        messageSuccessRegisterSnackBar(context, respuestaModel!.mensaje);
        Navegacion.ir_LOGINUSUARIO(context);
      } else if (respuestaModel!.resultado == "2") {
        messageSuccessInfoSnackBar(context, respuestaModel!.mensaje);
      } else if (respuestaModel!.resultado == "3") {
        messageSuccessInfoSnackBar(context, respuestaModel!.mensaje);
      }

      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dniController.addListener(() {
      getDatosDNI();
    });
  }

  getDatosDNI() {
    if (dniController.text.length > 7) {
      _reniecAPIService.getReniecDNI(dniController.text).then((value) {
        reniecDNIModel = value;
        apellidoController.text =
            "${reniecDNIModel!.apellidoPaterno} ${reniecDNIModel!.apellidoMaterno}";
        nombreController.text = reniecDNIModel!.nombres!;
        setState(() {});
      });
    }
  }

  bool validar1 = false;
  bool validar2 = false;
  bool validar3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                controlsBuilder: (context, _) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: continued,
                          child: Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Color(0XFF4760FF),
                                borderRadius: BorderRadius.circular(14)),
                            child: Center(
                                child: Text(
                              "Siguiente",
                              style: GoogleFonts.openSans(
                                  fontSize: 16, color: Colors.white),
                            )),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: cancel,
                          child: Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Color(0XFF4760FF),
                                borderRadius: BorderRadius.circular(14)),
                            child: Center(
                                child: Text(
                              "Cancelar",
                              style: GoogleFonts.openSans(
                                  fontSize: 16, color: Colors.white),
                            )),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                steps: <Step>[
                  Step(
                    title: const Text('Datos Personales'),
                    content: Column(
                      children: <Widget>[
                        Form(
                          key: _formDatosPersonalesKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ingresa tus datos",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Necesitamos que completes los datos para acceder a nuestros servicios.",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  color: Colors.black38,
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextFieldNormalIconWidget(
                                hintText: 'DNI',
                                controller: dniController,
                                active: false,
                                maxLength: 8,
                                icons: Icons.credit_card_outlined,
                                textInputType: TextInputType.number,
                                onTap: () {},
                              ),
                              TextFieldNormalIconWidget(
                                hintText: 'Nombres',
                                controller: nombreController,
                                active: true,
                                icons: Icons.person_sharp,
                                onTap: () {},
                              ),
                              TextFieldNormalIconWidget(
                                hintText: 'Apellidos',
                                controller: apellidoController,
                                active: true,
                                icons: Icons.person_sharp,
                                onTap: () {},
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              DropdownButtonFormField2(
                                key: _keySexo,
                                focusColor: Color(0XFFF0F0F0),
                                selectedItemHighlightColor: Color(0XFFF0F0F0),
                                decoration: InputDecoration(
                                  //Add isDense true and zero Padding.
                                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  filled: true,
                                  hoverColor: Color(0XFFF0F0F0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFF0F0F0), width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderSide: const BorderSide(
                                        color: Color(0XFFF0F0F0), width: 2.0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderSide: const BorderSide(
                                        color: Color(0XFFF0F0F0), width: 2.0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFF0F0F0), width: 2.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderSide: const BorderSide(
                                        color: Color(0XFFF0F0F0), width: 2.0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusColor: Colors.red,
                                  fillColor: Color(0XFFF0F0F0),
                                  //Add more decoration as you want here
                                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  'Selecciona el Sexo',
                                  style: TextStyle(fontSize: 14),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0XFFF0F0F0)),
                                items: sexItems
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Por favor selecciona el sexo';
                                  }
                                },
                                onChanged: (value) {
                                  sexo = value as String;
                                  sexoController.text = value as String;
                                  setState(() {});
                                },
                                onSaved: (value) {
                                  sexo = value as String;
                                  print(sexo);
                                  sexoController.text = value as String;
                                  setState(() {});
                                },
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              IntlPhoneField(
                                searchText: "Buscar Pais",
                                initialCountryCode: "PE",
                                disableLengthCheck: true,
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "Telefono",
                                  hintStyle: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  filled: true,
                                  fillColor: Color(0XFFF0F0F0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onChanged: (phone) {
                                  telefonoNuevoController.text =
                                      phone.completeNumber;
                                  print(telefonoNuevoController.text.length);
                                },
                                onCountryChanged: (country) {
                                  print('Country changed to: ${country.name}');
                                },
                              ),
                              TextFieldNormalIconWidget(
                                controller: fechaNacimientoController,
                                active: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      locale: const Locale("es", "ES"),
                                      context: context,
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                              primary: Color(0xFF4760FF),
                                              // header background color
                                              onPrimary: Colors.black,
                                              // header text color
                                              onSurface: Colors
                                                  .black, // body text color
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                primary: Colors
                                                    .black, // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1940),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    // print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('yyyy/MM/dd')
                                            .format(pickedDate);
                                    //   print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    fechaNacimientoController.text =
                                        formattedDate; //set output date to TextField value.
                                    setState(() {});
                                  } else {}
                                },
                                hintText: 'Fecha de Nacimiento',
                                icons: Icons.date_range,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text('Crear Cuenta'),
                    content: Column(
                      children: <Widget>[
                        Form(
                          key: _formCuentaKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            children: [
                              Text(
                                "Indícanos tu correo y contraseña",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Para poder tener acceso a nuestra aplicación.",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  color: Colors.black38,
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              TextFieldNormalIconWidget(
                                hintText: 'Correo Electronico',
                                active: false,
                                icons: Icons.email,
                                textInputType: TextInputType.emailAddress,
                                controller: emailController,
                                onTap: () {},
                              ),
                              TextFieldPasswordNormalIconWidget(
                                hintText: 'Contraseña',
                                active: false,
                                icons: Icons.lock,
                                controller: passwordController,
                              ),
                              TextFieldPasswordNormalIconWidget(
                                hintText: 'Confirmar Contraseña',
                                active: false,
                                icons: Icons.lock,
                                controller: passworConfirmdController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: HorizontalStepper(
                steps: [
                  HorizontalStep(
                    title: "Datos Personales",
                    widget: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formDatosPersonalesKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ingresa tus datos",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Necesitamos que completes los datos para acceder a nuestros servicios.",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  color: Colors.black38,
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              TextFieldNormalIconWidget(
                                hintText: 'DNI',
                                controller: dniController,
                                active: false,
                                maxLength: 8,
                                icons: Icons.credit_card_outlined,
                                textInputType: TextInputType.number,
                                onTap: () {},
                              ),
                              TextFieldNormalIconWidget(
                                hintText: 'Nombres',
                                controller: nombreController,
                                active: true,
                                icons: Icons.person_sharp,
                                onTap: () {},
                              ),
                              TextFieldNormalIconWidget(
                                hintText: 'Apellidos',
                                controller: apellidoController,
                                active: true,
                                icons: Icons.person_sharp,
                                onTap: () {},
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              DropdownButtonFormField2(
                                key: _keySexo,
                                focusColor: Color(0XFFF0F0F0),
                                selectedItemHighlightColor: Color(0XFFF0F0F0),
                                decoration: InputDecoration(
                                  //Add isDense true and zero Padding.
                                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  filled: true,
                                  hoverColor: Color(0XFFF0F0F0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFF0F0F0), width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderSide: const BorderSide(
                                        color: Color(0XFFF0F0F0), width: 2.0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderSide: const BorderSide(
                                        color: Color(0XFFF0F0F0), width: 2.0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFF0F0F0), width: 2.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderSide: const BorderSide(
                                        color: Color(0XFFF0F0F0), width: 2.0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusColor: Colors.red,
                                  fillColor: Color(0XFFF0F0F0),
                                  //Add more decoration as you want here
                                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  'Selecciona el Sexo',
                                  style: TextStyle(fontSize: 14),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0XFFF0F0F0)),
                                items: sexItems
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Por favor selecciona el sexo';
                                  }
                                },
                                onChanged: (value) {
                                  value = sexo;

                                  if(dniController.text.isNotEmpty  ||
                                      nombreController.text.isNotEmpty ||
                                      apellidoController.text.isNotEmpty  ||
                                      sexo != "" ||
                                      dateInput.text.isNotEmpty
                                  ){
                                    validar1 = true;
                                  }
                                  setState(() {});
                                },
                                onSaved: (value) {
                                  sexo = value as String;
                                  sexoController.text = value;

                                  if(dniController.text.isNotEmpty  ||
                                      nombreController.text.isNotEmpty ||
                                      apellidoController.text.isNotEmpty  ||
                                      sexo != "" ||
                                      dateInput.text.isNotEmpty
                                  ){
                                    validar1 = true;
                                  }
                                  setState(() {});
                                },
                              ),
                              TextFieldNormalIconWidget(
                                controller: dateInput,
                                active: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      locale: const Locale("es", "ES"),
                                      context: context,
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: const ColorScheme.light(
                                              primary: Color(
                                                  0xFF4760FF), // header background color
                                              onPrimary: Colors
                                                  .black, // header text color
                                              onSurface: Colors
                                                  .black, // body text color
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                primary: Colors
                                                    .black, // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1940),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    dateInput.text =
                                        formattedDate; //set output date to TextField value.

                                    if(dniController.text.isNotEmpty  ||
                                        nombreController.text.isNotEmpty ||
                                        apellidoController.text.isNotEmpty  ||
                                        sexo != "" ||
                                        dateInput.text.isNotEmpty
                                    ){
                                      validar1 = true;
                                    }
                                    setState(() {
                                      print(validar1);
                                    });
                                  } else {
                                    if(dniController.text.isNotEmpty  ||
                                        nombreController.text.isNotEmpty ||
                                        apellidoController.text.isNotEmpty  ||
                                        sexo != "" ||
                                        dateInput.text.isNotEmpty
                                    ){
                                      validar1 = true;
                                    }

                                    if(_formDatosPersonalesKey.currentState!.validate()){
                                      validar1 = true;
                                    }
                                    setState(() {
                                      print(validar1);
                                    });
                                  }
                                },
                                hintText: 'Fecha de Nacimiento',
                                icons: Icons.date_range,
                              ),
                              /*    Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextFieldNormalIconWidget(
                                    hintText: 'Dia',
                                    active: false,
                                    icons: Icons.calendar_today_outlined,
                                  ),
                                  TextFieldNormalWidget(
                                    hintText: 'Mes',
                                    active: false,
                                  ),
                                  TextFieldNormalWidget(
                                    hintText: 'Año',
                                    active: false,
                                  ),
                                  //TextFieldNormalWidget(hintText: 'Genero', active: false, icons: Icons.person_sharp,width: 30),
                                ],
                              ),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                    isValid: true
                  ),
                  HorizontalStep(
                    title: "Crear Cuenta",
                    widget: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formCuentaKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            children: [
                              Text(
                                "Indícanos tu correo y contraseña",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Para poder tener acceso a nuestra aplicación.",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  color: Colors.black38,
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              TextFieldNormalIconWidget(
                                hintText: 'Correo Electronico',
                                active: false,
                                icons: Icons.email,
                                textInputType: TextInputType.emailAddress,
                                controller: emailController,
                                onTap: (){

                                },
                              ),
                              TextFieldPasswordNormalIconWidget(
                                hintText: 'Contraseña',
                                active: false,
                                icons: Icons.lock,
                                controller: passwordController,
                              ),
                              TextFieldPasswordNormalIconWidget(
                                hintText: 'Confirmar Contraseña',
                                active: false,
                                icons: Icons.lock,
                                controller: passworConfirmdController,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    isValid: true,
                  ),
                ],
                selectedColor:  Color(0xFF4760FF),
                unSelectedColor: Colors.grey.shade400,
                leftBtnColor:  Color(0xffEA7F8B),
                rightBtnColor:  Color(0xFF4760FF),
                selectedOuterCircleColor:  Color(0xFF40A8F4),
                type: Type.TOP,
                circleRadius: 30,
                onComplete: () {
                  UsuarioModel usuarioModel = UsuarioModel(
                      docTipo: "DNI",
                      docNumero: dniController.text,
                      apellidos: apellidoController.text,
                      nombres: nombreController.text,
                      genero: sexo,
                      telefono: widget.celular,
                      fechaNacimiento: dateInput.text,
                      ciudad: "Trujillo",
                      direccion: "Trujillo",
                      codigoPostal: "--",
                      email: emailController.text,
                      userName: "--",
                      clave: passwordController.text,
                      imagen: "--",
                      idRol: 1,
                      idEmpresa: 1,
                      idTipoRegistro: 1);

                  if(dniController.text.isEmpty  ||
                      nombreController.text.isEmpty ||
                      apellidoController.text.isEmpty  ||
                      dateInput.text.isEmpty ||
                      widget.celular!.isEmpty  ||
                      emailController.text.isEmpty  ||
                      passwordController.text.isEmpty  ||
                      passworConfirmdController.text.isEmpty
                  ){
                    print(sexo);
                    messageSuccessInfoSnackBar(context, "Debe completar todos los campos");
                  }else{
                    if (passwordController.text == passworConfirmdController.text) {
                      postRegistrarUsuario(usuarioModel);
                      setState(() {

                      });
                      messageSuccessRegisterSnackBar(context, "Se registró correctamente");
                    } else {
                      messageSuccessInfoSnackBar(context, "Las contraseñas no son iguales");
                    }
                  }

                },
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }*/
}
