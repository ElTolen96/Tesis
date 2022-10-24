import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proyecto_withe_power/Modelo/Evento.dart';
import 'package:proyecto_withe_power/Modelo/Notificacion.dart';
import 'package:sqflite/sqflite.dart';

class DBWhitePower {
  Database? _myBookDataBase;

  static final DBWhitePower db = DBWhitePower._();

  DBWhitePower._();

  Future<Database?> getDatabase() async {
    if (_myBookDataBase != null) return _myBookDataBase;
    _myBookDataBase = await initDB();
    return _myBookDataBase;
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "WhitePowerDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE EVENTO("
            "IdEvento TEXT PRIMARY KEY, "
            "IdSede TEXT, "
            "Titulo TEXT, "
            "Descripcion TEXT, "
            "Aforo TEXT, "
            "Fecha TEXT, "
            "Hora TEXT, "
            "UsuarioCreacion TEXT, "
            "UsuarioModiElimini TEXT, "
            "FechaEventoModi TEXT, "
            "FechaCreacion TEXT, "
            "UrlImagen TEXT, "
            "Flag TEXT, "
            "Activo TEXT, "
            "Sede TEXT, "
            "CiudadSede TEXT, "
            "DireccionSede TEXT, "
            "Longitud TEXT, "
            "Latitud TEXT, "
            "ZonaGeneral TEXT, "
            "ZonaVip TEXT, "
            "ZonaBox TEXT, "
            "Favorito TEXT);");

        await db.execute("CREATE TABLE NOTIFICACION("
            "IdNotificacion TEXT PRIMARY KEY, "
            "IdUsuario TEXT, "
            "IdVenta TEXT, "
            "Descripcion TEXT, "
            "Estado TEXT, "
            "FechaVenta TEXT, "
            "Monto TEXT, "
            "Zona TEXT, "
            "Leido TEXT);");

      },
    );
  }

  //Listar Libros
  Future<List> getEventosRaw() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> res = await db!.rawQuery("SELECT * FROM EVENTO");
    print(res);
    return res;
  }

  Future<List<EventoModel>> getEventos() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> res = await db!.query("EVENTO");
    List<EventoModel> eventos =
        res.map<EventoModel>((item) => EventoModel.fromJson(item)).toList();
    print(eventos);
    return eventos;
  }

  Future<List<EventoModel>> getEventosFavourites() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> res =
        await db!.query("EVENTO", where: "Favorito = 'true'");
    List<EventoModel> eventos =
        res.map<EventoModel>((item) => EventoModel.fromJson(item)).toList();
    print(eventos);
    return eventos;
  }

  //Insertar Eventos

  Future<int> insertAllEventoRaw(EventoModel eventoModel) async {
    final db = await getDatabase();
    int res = await db!.rawInsert(
        "INSERT INTO EVENTO(IdEvento, IdSede, Titulo, Descripcion,"
            " Aforo, Fecha, Hora, UsuarioCreacion, UsuarioModiElimini, FechaEventoModi,"
            "FechaCreacion, UrlImagen, Flag, Activo, Sede, CiudadSede, DireccionSede, "
            "Longitud, Latitud, ZonaGeneral, ZonaVip, ZonaBox) VALUES "
            "('${eventoModel.idEvento}','${eventoModel.idSede}', '${eventoModel.titulo}', "
            "'${eventoModel.descripcion}','${eventoModel.aforo}','${eventoModel.fecha}', "
            "'${eventoModel.hora}','${eventoModel.usuarioCreacion}','${eventoModel.usuarioModiElimini}',"
            "'${eventoModel.fechaEventoModi}','${eventoModel.fechaCreacion}','${eventoModel.urlImagen}',"
            "'${eventoModel.flag}', '${eventoModel.activo}', '${eventoModel.sede}', "
            "'${eventoModel.ciudadSede}', '${eventoModel.direccionSede}', '${eventoModel.longitud}', "
            "'${eventoModel.latitud}', '${eventoModel.zonaGeneral}', '${eventoModel.zonaVip}', "
            " '${eventoModel.zonaBox}')");
            //"'${eventoModel.precioGeneral}', '${eventoModel.precioVip}','${eventoModel.precioBox}')");
    return res;
  }

  Future<int> insertBook(EventoModel eventoModel) async {
    final db = await getDatabase();
    int res = await db!.insert(
      "EVENTO",
      eventoModel.toJson(),
    );
    return res;
  }

  Future<int> updateEvento(EventoModel eventoModel) async {
    final db = await getDatabase();
    var row = {
      'IdSede'     : eventoModel.idSede,
      'Titulo'  : eventoModel.titulo,
      'Descripcion' : eventoModel.descripcion,
      'Aforo' : eventoModel.aforo,
      'Fecha' : eventoModel.fecha,
      'Hora' : eventoModel.hora,
      'UrlImagen' : eventoModel.urlImagen,
      'Flag' : eventoModel.flag,
      'Activo' : eventoModel.activo,
      'Sede' : eventoModel.sede,
      'CiudadSede' : eventoModel.ciudadSede,
      'DireccionSede' : eventoModel.direccionSede,
      'Longitud' : eventoModel.longitud,
      'Latitud' : eventoModel.latitud,
      'ZonaGeneral' : eventoModel.zonaGeneral,
      'ZonaBox' : eventoModel.zonaBox,
      'ZonaVip' : eventoModel.zonaVip,
    };

    int updateCount = await db!.update("EVENTO", row,
        where: 'IdEvento = ?', whereArgs: [eventoModel.idEvento]);
    return updateCount;
  }

  Future<int> updateStateBook(EventoModel eventoModel) async {
    final db = await getDatabase();
    int updateCount = await db!.update("EVENTO", {'Favorito': 'false'},
        where: 'IdEvento = ?', whereArgs: [eventoModel.idEvento]);
    return updateCount;
  }

  Future<int> updateBook(EventoModel eventoModel) async {
    final db = await getDatabase();
    int result = await db!.update(
      'EVENTO',
      eventoModel.toJson(),
      where: "id = ?",
      whereArgs: [eventoModel.idEvento],
    );
    return result;
  }

  Future<int> updateIsNotFavouriteEvento(String? id) async {
    final db = await getDatabase();
    int result = await db!.update(
      'EVENTO',
      {'Favorito': 'false'},
      where: "IdEvento = ?",
      whereArgs: [id],
    );
    return result;
  }

  Future<int> updateIsFavouriteEvento(String? id) async {
    final db = await getDatabase();
    int result = await db!.update(
      'EVENTO',
      {'Favorito': 'true'},
      where: "IdEvento = ?",
      whereArgs: [id],
    );
    return result;
  }

  Future<void> deleteEvento(int? id) async {
    final db = await getDatabase();
    await db!.delete(
      'EVENTO',
      where: "IdEvento = ?",
      whereArgs: [id],
    );
  }

  //INSERTAR NOTIFICACIONES

  Future<int> insertAllNotificacionRaw(NotificacionModel notificacionModel) async {
    final db = await getDatabase();
    int res = await db!.rawInsert(
        "INSERT INTO NOTIFICACION(IdNotificacion, IdUsuario, IdVenta, "
            "Descripcion, Estado, FechaVenta, Monto, Zona) VALUES "
            "('${notificacionModel.idNotificacion}','${notificacionModel.idUsuario}',"
            " '${notificacionModel.idVenta}', '${notificacionModel.descripcion}',"
            "'${notificacionModel.estado}','${notificacionModel.fechaVenta}', "
            "'${notificacionModel.monto}','${notificacionModel.zona}')");
    //"'${eventoModel.precioGeneral}', '${eventoModel.precioVip}','${eventoModel.precioBox}')");
    return res;
  }

  Future<int> updateNotificacion(NotificacionModel notificacionModel) async {
    final db = await getDatabase();
    var row = {
      'IdUsuario'     : notificacionModel.idUsuario,
      'IdVenta'  : notificacionModel.idVenta,
      'Descripcion' : notificacionModel.descripcion,
      'Estado' : notificacionModel.estado,
      'FechaVenta' : notificacionModel.fechaVenta,
      'Monto' : notificacionModel.monto,
      'Zona' : notificacionModel.zona,
    };
    int updateCount = await db!.update("NOTIFICACION", row,
        where: 'IdNotificacion = ?', whereArgs: [notificacionModel.idNotificacion]);
    return updateCount;
  }

  //LISTAR NOTIFICACIONES
  Future<List<NotificacionModel>> getNotificaciones() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> res =
    await db!.query("NOTIFICACION", where: "Leido is null");
    List<NotificacionModel> notificaciones =
    res.map<NotificacionModel>((item) => NotificacionModel.fromJson(item)).toList();
    return notificaciones;
  }


  //LISTAR NOTIFICACIONES LEIDAS
  Future<List<NotificacionModel>> getNotificacionesLeidas() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> res =
    await db!.query("NOTIFICACION", where: "Leido = 'true'");
    List<NotificacionModel> notificaciones =
    res.map<NotificacionModel>((item) => NotificacionModel.fromJson(item)).toList();
    return notificaciones;
  }

  //CONFIRMAR LECTURA NOTIFICACION
  Future<int> updateLecturaNotificacion(String? id) async {
    final db = await getDatabase();
    int result = await db!.update(
      'NOTIFICACION',
      {'Leido': 'true'},
      where: "IdNotificacion = ?",
      whereArgs: [id],
    );
    return result;
  }

  Future<int> deleteNotificacion(String? id) async {
    final db = await getDatabase();
    int result = await db!.update(
      'NOTIFICACION',
      {'Leido': 'false'},
      where: "IdNotificacion = ?",
      whereArgs: [id],
    );
    return result;
  }



}
