import 'package:appwrite/appwrite.dart';

final client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('6471b5261763b0d1f3d1')
    .setSelfSigned();

final databases = Databases(client);

final document = databases.createDocument(
    databaseId: '64777457efa83eda9359',
    documentId: ID.unique(),
    data: {},
    collectionId: '647774e068f032e52a51');

const mobileScreenWidth = 450.0;
