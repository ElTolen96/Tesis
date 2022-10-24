import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:proyecto_withe_power/Modelo/RENIECDni.dart';

import 'constants.dart';

class ReniecAPIService{

  Future<ReniecDNIModel> getReniecDNI(String dni) async {
    ReniecDNIModel reniecDNIModel = ReniecDNIModel();

    String path = "$pathProductionDNI/$dni?token=$token";
    Uri _uri = Uri.parse(path);
    http.Response response = await http.get(_uri);

    try{
      if(response.statusCode == 200){
        Map<String, dynamic> myMap = json.decode(response.body);
        reniecDNIModel = ReniecDNIModel.fromJson(myMap);
        return reniecDNIModel;
      }
    }
    on TimeoutException catch(e){
      return Future.error(e);
    }

    on SocketException catch(e){ //Esto es cuando no hay internet
      return Future.error(e);
    }

    on Error catch(e){
      return Future.error(e);
    }

    on Exception catch(e){ // only executed if error is of type Exception
      return Future.error(e);
    }
    return reniecDNIModel;
  }

  /*
  Future<ReniecRUCModel> getReniecRUC(String ruc) async {
    ReniecRUCModel reniecRUCModel = ReniecRUCModel();

    String path = "$pathProductionRUC/$ruc?token=$token";
    Uri _uri = Uri.parse(path);
    http.Response response = await http.get(_uri);

    try{
      if(response.statusCode == 200){
        Map<String, dynamic> myMap = json.decode(response.body);
        reniecRUCModel = ReniecRUCModel.fromJson(myMap);
        return reniecRUCModel;
      }
    }
    on TimeoutException catch(e){
      return Future.error(e);
    }

    on SocketException catch(e){ //Esto es cuando no hay internet
      return Future.error(e);
    }

    on Error catch(e){
      return Future.error(e);
    }

    on Exception catch(e){ // only executed if error is of type Exception
      return Future.error(e);
    }
    return reniecRUCModel;
  }
*/

}