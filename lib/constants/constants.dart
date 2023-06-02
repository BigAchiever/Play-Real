import 'package:appwrite/appwrite.dart';

final client = Client()
    .setEndpoint('PROJECT_ENDPOINT')
    .setProject('PROJECT_ID')
    .setSelfSigned();

final databases = Databases(client);



const mobileScreenWidth = 450.0;
