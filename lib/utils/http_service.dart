import 'dart:io';
import 'package:http/io_client.dart';

//     class Singleton {
//        static final HttpClient client = HttpClient()
//     ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
//   static final Singleton _singleton = Singleton._internal();

//   factory Singleton() {
//     return _singleton;
//   }

//   Singleton._internal();
// }

class SingletonHttp {
  static final SingletonHttp _singleton = new SingletonHttp._internal();
  bool trustSelfSigned;
  HttpClient httpClient;
  IOClient ioClient;

  factory SingletonHttp() {
    return _singleton;
  }

  SingletonHttp._internal() {
     // initialization logic here
    trustSelfSigned = true;
     httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
       ioClient = new IOClient(httpClient);
  }

  IOClient getIoc() {
    return ioClient;
  }

   // rest of the class
}

// class SingletonHttp {
//   static SingletonHttp _instance;
//   static HttpClient httpClient;

//   SingletonHttp._internal() {
//     httpClient = HttpClient()
//       ..badCertificateCallback =
//           ((X509Certificate cert, String host, int port) => true);
//   }

//   static SingletonHttp getClient() {
//     if (_instance == null) {
//       _instance = SingletonHttp._internal();
//     }

//   }}