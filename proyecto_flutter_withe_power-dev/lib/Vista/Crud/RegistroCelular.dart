import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:proyecto_withe_power/Vista/Crud/RegistroUsuario.dart';
import 'package:proyecto_withe_power/Vista/daniel/button_normal_widget.dart';
import 'package:proyecto_withe_power/Vista/daniel/general_widget.dart';
import 'package:proyecto_withe_power/Vista/daniel/validar_codigo.dart';
import '../../Modelo/Mensajes.dart';
import 'package:lottie/lottie.dart';

class RegistroCelular extends StatefulWidget {
  static final String routeName = Mensajes.RUTA_REGISTRO_CELULAR_USUARIO;

  const RegistroCelular({Key? key}) : super(key: key);

  @override
  State<RegistroCelular> createState() => _RegistroCelularState();
}

class _RegistroCelularState extends State<RegistroCelular> {
  TextEditingController telefonoController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  TextEditingController _codigo1Controller = TextEditingController();
  TextEditingController _codigo2Controller = TextEditingController();
  TextEditingController _codigo3Controller = TextEditingController();
  TextEditingController _codigo4Controller = TextEditingController();
  TextEditingController _codigo5Controller = TextEditingController();
  TextEditingController _codigo6Controller = TextEditingController();

  final _formTelefonoKey = GlobalKey<FormState>();
  final _formOPTKey = GlobalKey<FormState>();
  int? _resendToken;
  late User _firebaseUser;
  String _status = "";

  late PhoneAuthCredential _phoneAuthCredential;
  String _verificationId = "";
  int _code = 0;

  TextEditingController textEditingController = TextEditingController();

  bool hasError = false;
  late Timer _timer;
  int _start = 60;
  bool isLoading = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            isLoading = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  void _handleError(e) {
    messageSuccessInfoSnackBar(context, e.message);
    print("ERROR DE MENSAJE " + e.message);
    setState(() {
      _status += e.message + '\n';
    });
  }

  Future<void> _getFirebaseUser() async {
    _firebaseUser = await FirebaseAuth.instance.currentUser!;
    setState(() {
      _status =
          (_firebaseUser == null) ? 'Not Logged In\n' : 'Already LoggedIn\n';
    });
  }

  /// phoneAuthentication works this way:
  ///     AuthCredential is the only thing that is used to authenticate the user
  ///     OTP is only used to get AuthCrendential after which we need to authenticate with that AuthCredential
  ///
  /// 1. User gives the phoneNumber
  /// 2. Firebase sends OTP if no errors occur
  /// 3. If the phoneNumber is not in the device running the app
  ///       We have to first ask the OTP and get `AuthCredential`(`_phoneAuthCredential`)
  ///       Next we can use that `AuthCredential` to signIn
  ///    Else if user provided SIM phoneNumber is in the device running the app,
  ///       We can signIn without the OTP.
  ///       because the `verificationCompleted` callback gives the `AuthCredential`(`_phoneAuthCredential`) needed to signIn
  Future<void> _login() async {
    /// This method is used to login the user
    /// `AuthCredential`(`_phoneAuthCredential`) is needed for the signIn method
    /// After the signIn method from `AuthResult` we can get `FirebaserUser`(`_firebaseUser`)

    try {
      await FirebaseAuth.instance
          .signInWithCredential(_phoneAuthCredential)
          .then((UserCredential authRes) {
        _firebaseUser = authRes.user!;
        print(_firebaseUser.toString());

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RegistroUsuario(
                  celular: telefonoController.text,
                )));
        messageSuccessRegisterSnackBar(context, "CODIGO VALIDO");

      }).catchError((e) => _handleError(e));
      setState(() {
        _status += 'Signed In\n';
      });
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _submitPhoneNumber() async {
    /// NOTE: Either append your phone number country code or add in the code itself
    /// Since I'm in India we use "+91 " as prefix `phoneNumber`
    String phoneNumber = telefonoController.text.toString().trim();
    print(phoneNumber);

    /// The below functions are the callbacks, separated so as to make code more redable
    void verificationCompleted(PhoneAuthCredential phoneAuthCredential) {
      print('verificationCompleted');
      setState(() {
        _status += 'verificationCompleted\n';
      });
      _phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);
    }

    void verificationFailed(FirebaseAuthException error) {
      print('verificationFailed');
      _handleError(error);
    }

    void codeSent(String verificationId, [int? code]) {
      print('codeSent');
      _verificationId = verificationId;
      print(verificationId);
      _code = code!;
      print(code.toString());
      setState(() {
        _status += 'Code Sent\n';
      });
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
      setState(() {
        _status += 'codeAutoRetrievalTimeout\n';
      });
      print(verificationId);
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      /// Make sure to prefix with your country code
      phoneNumber: phoneNumber,

      /// `seconds` didn't work. The underlying implementation code only reads in `millisenconds`
      timeout: const Duration(seconds: 30),

      /// If the SIM (with phoneNumber) is in the current device this function is called.
      /// This function gives `AuthCredential`. Moreover `login` function can be called from this callback
      /// When this function is called there is no need to enter the OTP, you can click on Login button to sigin directly as the device is now verified
      verificationCompleted: verificationCompleted,

      /// Called when the verification is failed
      verificationFailed: verificationFailed,

      /// This is called after the OTP is sent. Gives a `verificationId` and `code`
      codeSent: codeSent,

      /// After automatic code retrival `tmeout` this function is called
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    ); // All the callbacks are above
  }

  Future<bool> sendOTP({required String phone}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
        _resendToken = resendToken;
      },
      timeout: const Duration(seconds: 30),
      forceResendingToken: _resendToken,
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = _verificationId;
      },
    );
    debugPrint("_verificationId: $_verificationId");
    return true;
  }

  void _submitOTP() {
    /// get the `smsCode` from the user
    _otpController.text = _codigo1Controller.text +
        _codigo2Controller.text +
        _codigo3Controller.text +
        _codigo4Controller.text +
        _codigo5Controller.text +
        _codigo6Controller.text;
    String smsCode = _otpController.text.toString().trim();

    /// when used different phoneNumber other than the current (running) device
    /// we need to use OTP to get `phoneAuthCredential` which is inturn used to signIn/login
    _phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);

    _login();
  }

  void _reset() {
    telefonoController.clear();
    _otpController.clear();
    setState(() {
      _status = "";
    });
  }

  void _displayUser() {
    setState(() {
      _status += '$_firebaseUser\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: _code == 0
              ? Form(
                  key: _formTelefonoKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Lottie.asset('assets/images/cellphone.json'),
                      Text(
                        "Registrate",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Se te enviará un SMS para verificarlo",
                        style: GoogleFonts.openSans(color: Colors.black38),
                      ),
                      const SizedBox(
                        height: 30,
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
                          telefonoController.text = phone.completeNumber;
                          print(telefonoController.text);
                        },
                        onCountryChanged: (country) {
                          print('Country changed to: ${country.name}');
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: ButtonNormalWidget(
                            text: "Confirmar Celular",
                            onPressed: () {
                              if (telefonoController.text.isEmpty) {
                                messageSuccessInfoSnackBar(
                                    context, "Debe Ingresar un N° de telefono");
                              } else if (telefonoController.text.length < 12) {
                                messageSuccessInfoSnackBar(context,
                                    "Debe Ingresar un N° de telefono de 9 dígitos");
                              } else {
                                _submitPhoneNumber();
                                startTimer();
                              }
                              /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegistroUsuario(
                                      celular: telefonoController.text)));*/
                            }),
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Lottie.asset('assets/images/verificarotp.json'),
                    Text(
                      "Introduce código de",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Text(
                      "verficación",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          "Lo enviamos al",
                          style: GoogleFonts.openSans(color: Colors.black38),
                        ),
                        telefonoController.text.isNotEmpty
                            ? Expanded(
                                child: Text(
                                  telefonoController.text.toString(),
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black38),
                                ),
                              )
                            : const Text("")
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        validar_codigo(
                            codigo: "1", controller: _codigo1Controller),
                        validar_codigo(
                            codigo: "2", controller: _codigo2Controller),
                        validar_codigo(
                            codigo: "3", controller: _codigo3Controller),
                        validar_codigo(
                            codigo: "4", controller: _codigo4Controller),
                        validar_codigo(
                            codigo: "5", controller: _codigo5Controller),
                        validar_codigo(
                            codigo: "6", controller: _codigo6Controller),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    _start != 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Reenviar Codigo en: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _start.toString(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Tienes problemas con el codigo?",
                                  style: GoogleFonts.openSans(
                                      color: Colors.black38),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isLoading = true;
                                    _start = 60;
                                    startTimer();
                                  });
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    sendOTP(phone: telefonoController.text);
                                    _codigo1Controller.clear();
                                    _codigo2Controller.clear();
                                    _codigo3Controller.clear();
                                    _codigo4Controller.clear();
                                    _codigo5Controller.clear();
                                    _codigo6Controller.clear();
                                  },
                                  child: Center(
                                    child: Text(
                                      "Enviar un nuevo código",
                                      style: GoogleFonts.openSans(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                    const SizedBox(height: 25),
                    isLoading
                        ? const CircularProgressIndicator()
                        : Center(
                            child: ButtonNormalWidget(
                                text: "Validar Codigo",
                                onPressed: () {
                                  _submitOTP();
                                  /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegistroUsuario(
                                    celular: telefonoController.text)));*/
                                }),
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}
