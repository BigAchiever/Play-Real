// Function to join a game session
import 'package:appwrite/appwrite.dart';
import '../constants/constants.dart';

final gameCollectionId = "647774e068f032e52a51";
final databaseId = "64777457efa83eda9359";
// Function to create a new game session
Future<String> createGameSession(String playerId) async {
  final database = databases;

  final response = await database.createDocument(
    collectionId: gameCollectionId,
    // json data to be stored in the document
    data: {
      "playerId": playerId,
      "status": "waiting",
    },
    databaseId: databaseId,
    documentId: ID.unique(),
  );

  return response.data['\$id'];
}

Future<void> joinGameSession(String gameSessionId, String playerId) async {
  final database = databases;
  await database.updateDocument(
    collectionId: gameCollectionId,
    documentId: gameSessionId,
    data: {"playerId": playerId, "status": "active"},
    databaseId: databaseId,
  );
}

// Function to get game session details
Future<Map<String, dynamic>> getGameSession(String gameSessionId) async {
  final database = databases;
  final collectionId = gameCollectionId;

  final response = await database.getDocument(
    collectionId: collectionId,
    documentId: gameSessionId,
    databaseId: databaseId,
  );

  return response.data;
}
