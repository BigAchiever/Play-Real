// Function to join a game session
import 'package:appwrite/appwrite.dart';
import '../constants/constants.dart';
import '../dialog/widgets/difficult_button.dart';

final gameCollectionId = "647774e068f032e52a51";
final databaseId = "64777457efa83eda9359";
final movesCollectionId = "647afc3f9d1db01bbf5f";
final movesDatabase = '64777457efa83eda9359';
// Function to create a new game session
Future<String> createGameSession(
  String uid,
  String teamcode,
  int numberOfPlayers,
  DifficultyLevel difficulty,
  int gridSize,
) async {
  final gameDatabase = databases;

  // Create a document in the "Game" collection
  final gameResponse = await gameDatabase.createDocument(
    collectionId: gameCollectionId,
    data: {
      "playerId1": uid,
      "status": "waiting",
      "teamcode": teamcode,
      "playerId2": "not joined",
      "numberOfPlayers": numberOfPlayers,
      "difficulty": difficulty.toString().split('.').last,
      "gridSize": gridSize,
    },
    databaseId: databaseId,
    documentId: ID.unique(),
  );

  final gameId = gameResponse.data['\$id'];

  // Create a document in the "Moves" collection
  await gameDatabase.createDocument(
    collectionId: movesCollectionId,
    data: {
      "current_gameId": gameId,
      "current-player-position":
          1, // Set the initial position for the current player
    },
    databaseId: databaseId,
    documentId: ID.unique(),
  );

  return gameId;
}

Future<void> joinGameSession(
  String gameSessionId,
  String playerId2,
) async {
  final gameDatabase = databases;

  // Update the document in the "Game" collection
  await gameDatabase.updateDocument(
    collectionId: gameCollectionId,
    documentId: gameSessionId,
    data: {
      "playerId2": playerId2,
      "status": "active",
    },
    databaseId: databaseId,
  );

  // Create a document in the "Moves" collection for the joined game session
  await gameDatabase.createDocument(
    collectionId: movesCollectionId,
    data: {
      "current_gameId": gameSessionId,
      "current-player-position": 1,
    },
    databaseId: databaseId,
    documentId: ID.unique(),
  );
}

// Function to get game session details
Future<Map<String, dynamic>> getGameSession(String gameSessionId) async {
  final gameDatabase = databases;

  final response = await gameDatabase.listDocuments(
    collectionId: movesCollectionId,
    queries: [
      Query.equal('current_gameId', gameSessionId),
    ],
    databaseId: databaseId,
  );

  if (response.documents.isNotEmpty) {
    final movesData = response.documents.first.data;

    final gameResponse = await gameDatabase.getDocument(
      collectionId: gameCollectionId,
      documentId: gameSessionId,
      databaseId: databaseId,
    );

    final gameData = gameResponse.data;
    gameData["current_player_position"] = movesData["current_player_position"];
    return gameData;
  }

  throw Exception("Game session not found");
}

// check if the game session is active and compare the teamcode to join the game
Future<String?> getGameSessionIdFromTeamCode(String teamCode) async {
  final database = databases;
  final response = await database.listDocuments(
    collectionId: gameCollectionId,
    queries: [
      Query.equal("teamcode", teamCode),
    ],
    databaseId: databaseId,
  );

  if (response.documents.isEmpty) {
    return null; // No game session found with the given team code
  }

  return response.documents.first.data['\$id'];
  // return id and document
}
