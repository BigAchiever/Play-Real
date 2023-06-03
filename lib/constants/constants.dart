import 'package:appwrite/appwrite.dart';

final client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('6471b5261763b0d1f3d1')
    .setSelfSigned();

// to be used all over the project to access the client
final databases = Databases(client);
final realtime = Realtime(client);
   

const mobileScreenWidth = 450.0;
