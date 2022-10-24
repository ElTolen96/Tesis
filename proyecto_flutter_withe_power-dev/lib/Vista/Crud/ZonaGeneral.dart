import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imageview360/imageview360.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Modelo/Evento.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Modelo/Zona.dart';
import 'package:proyecto_withe_power/Vista/daniel/ButtonCardSelection.dart';
import 'package:proyecto_withe_power/Vista/daniel/ReadMoreLessWidget.dart';
import 'package:proyecto_withe_power/Vista/daniel/add_cart_form_widget.dart';
import 'package:proyecto_withe_power/Vista/daniel/datos_Evento.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';
import '../../Controlador/servicios/api_services.dart';
import '../daniel/dropdown_button2.dart';
import '../daniel/general_widget.dart';

class ZonaGeneral extends StatefulWidget {
  static final String routeName = Mensajes.RUTA_ZONAGENERAL;

  ZonaGeneral({Key? key});

  @override
  _ZonaGeneralState createState() => _ZonaGeneralState();
}

class _ZonaGeneralState extends State<ZonaGeneral> {
  String cantPersonas = "80";
  String montoPagar = "0.00";
  EventoModel? eventoModelSeleccionado;

  showShoppingCardForm(BuildContext context, String monto, EventoModel eventoModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.8),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddCartFormWidget(
            eventoModel: eventoModel,
            title: "Número de entradas",
            type: false,
            monto: monto,
            zona: zonaModel.first,
            collection: "collection", onTap: (){
            //Navegacion.ir_DetalleCompra(context);
          },
          ),
        );
      },
    );
  }
  final GlobalKey<FormFieldState> _keyEvento = GlobalKey<FormFieldState>();
  final APIServices _apiServices = APIServices();
  bool isLoading = false;
  String idEvento = "";
  String fechaEvento = "";
  String HoraEvento = "";
  TextEditingController eventoController = TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateImageList(context));
    super.initState();
    getListarZona();
    getListarEventos();
    
  }
  List<EventoModel> eventosItems = [];

  getListarEventos() async {

    _apiServices.getEventos().then((value) {
      for (var element in value) {
        if(element.zonaGeneral != "0.00"){
          eventosItems.add(element);
        }
      }

      setState(() {});
    });
  }


  List<ZonaModel> zonaModel = [];
  getListarZona(){
    isLoading = true;
    _apiServices.getZona("3").then((value) {
      zonaModel = value;
      isLoading = false;
      setState(() {
        print(zonaModel.first.nombre);
      });
    });
  }

  bool imagePrecached = false;
  List<ImageProvider> imageList = <ImageProvider>[];

  void updateImageList(BuildContext context) async {
    imageList.add(const AssetImage('assets/images/general.jpeg'));
    //* To precache images so that when required they are loaded faster.
    await precacheImage(const AssetImage('assets/images/general.jpeg'), context);
    setState(() {
      imagePrecached = true;
    });
  }


  
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return isLoading ? Container(
      color: Colors.white60,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ): Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RawMaterialButton(
                  constraints: BoxConstraints(minWidth: 45.0, minHeight: 15.0),
                  onPressed: () {
                    Navegacion.ir_Inicio(context);
                  },
                  fillColor: Color(0xffFFFFFF),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 20.0,
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                ),
              ),
              SizedBox(
                width: _width * 0.6,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RawMaterialButton(
                  constraints: BoxConstraints(minWidth: 45.0, minHeight: 15.0),
                  onPressed: () {},
                  fillColor: Color(0xffFFFFFF),
                  child: Icon(
                    Icons.favorite,
                    size: 20.0,
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                ),
              ),
            ],
            floating: false,
            pinned: false,
            //title: Text("Flexible space title"),
            expandedHeight: _height * 0.4,
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                  child: FadeInImage(
                    image: NetworkImage(
                        "https://www.diariodenavarra.es/uploads/2020/06/12/60b02695de2c9.jpeg"),
                    placeholder: NetworkImage(
                        "https://www.diariodenavarra.es/uploads/2020/06/12/60b02695de2c9.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                  ),
                  bottom: -7,
                  left: 0,
                  right: 0,
                )
              ],
            ),
          ),
          SliverFillRemaining(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 24.0, left: 24.0, bottom: 24.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        zonaModel.first.nombre,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "80",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(fontSize: 16),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Personas asistirán:",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                                fontSize: 16, color: Color(0xffBCBABE)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Descripción del evento",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ReadMoreText(
                        zonaModel.first.descripcion,
                        trimLines: 2,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: ' Leer mas',
                        trimExpandedText: ' Leer menos',
                        moreStyle: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4760FF)),
                        lessStyle: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4760FF)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      DropdownButtonFormField2(
                        key: _keyEvento,
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
                          'Selecciona el Evento',
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
                        items: eventosItems
                            .map((item) => DropdownMenuItem<String>(
                          value: item.idEvento.toString(),
                          child: item.titulo.isNotEmpty ? Text(
                            item.titulo  ,
                            style:  TextStyle(
                              fontSize: 14,
                            ),
                          ): Text(""),
                        ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor selecciona el evento';
                          }
                        },
                        onChanged: (value) {
                          //Do something when changing the item if you want.

                          idEvento = value as String;
                          eventosItems.forEach((element) {
                            if(idEvento == element.idEvento){
                              eventoModelSeleccionado = element;
                              String languageCode = Localizations.localeOf(context).languageCode;
                              String formattedDate = DateFormat.yMMMMEEEEd(languageCode).format(element.fecha);
                              fechaEvento = formattedDate;
                              HoraEvento = element.hora;
                              cantPersonas = element.aforo;
                              montoPagar = element.zonaVip;
                            }
                          });
                          eventoController.text = value as String;

                          setState(() {});
                        },
                        onSaved: (value) {
                          idEvento = value as String;
                          print(idEvento);
                          eventoController.text = value as String;
                          setState(() {});
                        },
                      ),
                      DatosEvento(
                        iconData: Icons.location_on,
                        titutlo1: "Laredo, Trujillo",
                        titutlo2: "Calle San Antonio #343",
                      ),
                     fechaEvento.isNotEmpty ?  DatosEvento(
                       iconData: Icons.calendar_today_rounded,
                       titutlo1: fechaEvento.toUpperCase(),
                       titutlo2: HoraEvento,
                     ) : Text(""),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          "Conoce la zona  y ten una experiencia 360°",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              fontSize: 16, color: Color(0xffBCBABE)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ImageView360(
                        key: UniqueKey(),
                        imageList: imageList,
                        autoRotate: true,                                           //Optional
                        rotationCount: 2,                                           //Optional
                        rotationDirection: RotationDirection.anticlockwise,         //Optional
                        frameChangeDuration: Duration(milliseconds: 50),            //Optional
                        swipeSensitivity: 2,                                        //Optional
                        allowSwipeToRotate: true,                                   //Optional
                        onImageIndexChanged: (currentImageIndex) {                  //Optional
                          print("currentImageIndex: $currentImageIndex");
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ButtonCardSelection(
                        isIconData: true,
                        iconData: Icons.shopping_cart,
                        isAmount: true,
                        total: "S/ $montoPagar",
                        texto: "Pagar entradas",
                        onTap: (){
                          if(montoPagar == "0.00"){
                            messageSuccessInfoSnackBar(context, "Debe seleccionar el evento");
                          }else{
                            showShoppingCardForm(context, montoPagar, eventoModelSeleccionado!);
                          }
                        }, background: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
