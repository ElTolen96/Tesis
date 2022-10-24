import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Modelo/Respuesta.dart';
import 'package:proyecto_withe_power/Vista/daniel/textfield_normal_Icons_widget.dart';

import '../../Controlador/preferencias_usuario.dart';
import '../../Controlador/servicios/api_services.dart';
import '../../Controlador/servicios/reniec_api_service.dart';
import '../../Modelo/Perfil.dart';
import '../../Modelo/Persona.dart';
import '../../Modelo/RENIECDni.dart';
import '../../Modelo/Usuario.dart';
import '../daniel/dropdown_button2.dart';
import '../daniel/general_widget.dart';

class EditarUsuario extends StatefulWidget {
  static final String routeName = Mensajes.RUTA_EDITUSUARIO;

  EditarUsuario({Key? key});

  @override
  _EditarUsuarioState createState() => _EditarUsuarioState();
}

class _EditarUsuarioState extends State<EditarUsuario> {
  PreferenciasUsuario _prefs = PreferenciasUsuario();
  final APIServices _apiServices = APIServices();
  final ReniecAPIService _reniecAPIService = ReniecAPIService();
  final GlobalKey<FormFieldState> _keySexo = GlobalKey<FormFieldState>();
  final _formDatosPersonalesKey = GlobalKey<FormState>();
  String idUsuario = "";

  TextEditingController dateInput = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController sexoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  String sexo = "";
  String dniInicio = "";

  List<PersonaModel> perfilModel = [ ];

  List<String> sexItems = [
    "MASCULINO",
    "FEMENINO",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dniController.addListener(() {
      getDatosDNI();
    });
    idUsuario = _prefs.IdUsuario;
    getListarUsuario(idUsuario);
    //sexoController = TextEditingController(text:_prefs.usuarioGenero);
  }

  getListarUsuario(String idUsuario) async {
    _apiServices.getListarUsuarioEspecifico(idUsuario).then((value) {
      perfilModel = value;
      dateInput = TextEditingController(text: '${perfilModel.first.fechaNacimiento.day}-${perfilModel.first.fechaNacimiento.month}-${perfilModel.first.fechaNacimiento.year}');
      nombreController = TextEditingController(text: perfilModel.first.nombres);
      apellidoController = TextEditingController(text: perfilModel.first.apellidos);
      telefonoController = TextEditingController(text: perfilModel.first.telefono);
      sexo = perfilModel.first.genero;
      //dniController = TextEditingController(text: perfilModel.first.docNumero);
      dniInicio = perfilModel.first.docNumero;
      dniController.text = perfilModel.first.docNumero;
      setState(() {});
    });
  }

  RespuestaModel? respuestaModel;
  postEditarUsuario(UsuarioModel usuarioModel) async {
    _apiServices.postEditarUsuario(usuarioModel).then((value) {
      respuestaModel = value;
      messageSuccessInfoSnackBar(context, respuestaModel!.mensaje);
      Navegacion.ir_Inicio(context);
      setState(() {});
    });
  }
  ReniecDNIModel? reniecDNIModel;
  getDatosDNI() {
    if (dniController.text.length > 7) {
      _reniecAPIService.getReniecDNI(dniController.text).then((value) {
        reniecDNIModel = value;
        apellidoController.text =
        "${reniecDNIModel!.apellidoPaterno} ${reniecDNIModel!.apellidoMaterno}";
        nombreController.text = reniecDNIModel!.nombres!;
        print("hola");
        print(reniecDNIModel!.nombres!);
        print("${reniecDNIModel!.apellidoPaterno} ${reniecDNIModel!.apellidoMaterno}");
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: _formDatosPersonalesKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navegacion.ir_Inicio(context);
                        },
                        child: Icon(Icons.arrow_back_rounded),
                      ),
                      Center(
                        child: Text(
                          "Informacion",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
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
                        hintText: 'Nombre',
                        active: true,
                        icons: Icons.person,
                        controller: nombreController,
                        onTap: () {},
                      ),
                      TextFieldNormalIconWidget(
                        hintText: 'Apellidos',
                        active: true,
                        icons: Icons.person,
                        controller: apellidoController,
                        onTap: () {},
                      ),
                      TextFieldNormalIconWidget(
                        hintText: 'Telefono',
                        active: false,
                        icons: Icons.person,
                        controller: telefonoController,
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      DropdownButtonFormField2(
                        key: _keySexo,
                        value: sexo.isNotEmpty ? sexo : null,
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
                        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
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
                          //Do something when changing the item if you want.

                          sexo = value as String;
                          print(sexo);
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
                                    colorScheme: ColorScheme.light(
                                      primary: Color(
                                          0xFF4760FF), // header background color
                                      onPrimary:
                                          Colors.black, // header text color
                                      onSurface: Colors.black, // body text color
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary:
                                            Colors.black, // button text color
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
                            //print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy/MM/dd').format(pickedDate);
                            print(formattedDate); //formatted date output using intl package =>  2021-03-16
                            dateInput.text =
                                formattedDate; //set output date to TextField value.
                            setState(() {
                            });
                          } else {}
                        },
                        hintText: 'Fecha de Nacimiento',
                        icons: Icons.date_range,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  UsuarioModel usuarioModel = UsuarioModel(
                      IdUsuario: idUsuario,
                      docNumero: dniController.text,
                      apellidos: apellidoController.text,
                      nombres: nombreController.text,
                      genero: sexo,
                      fechaNacimiento: dateInput.text,
                    docTipo: "DNI",
                    telefono: telefonoController.text,
                    email: _prefs.usuarioEmail
                  );
                  postEditarUsuario(usuarioModel);
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                      color: Color(0XFF4760FF),
                      borderRadius: BorderRadius.circular(48.0)),
                  child: Center(
                    child: Text(
                      "Guardar",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
