// Function to join a game session
import 'package:appwrite/appwrite.dart';
import 'package:play_real/models/player.dart';
import '../constants/constants.dart';
import '../dialog/widgets/difficult_button.dart';

final gameCollectionId = "647774e068f032e52a51";
final databaseId = "64777457efa83eda9359";
final movesCollectionId = "647afc3f9d1db01bbf5f";
final movesDatabase = '64777457efa83eda9359';
// Function to create a new game session
Future<Map<String, String>> createGameSession(
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
  final movesResponse = await gameDatabase.createDocument(
    collectionId: movesCollectionId,
    data: {
      "current_gameId": gameId,
      "player1Position": 1,
      "player2Position": 0,
      "number_of_players": numberOfPlayers,
    },
    databaseId: databaseId,
    documentId: ID.unique(),
  );
  final movesId = movesResponse.data['\$id'];

  return {
    "gameId": gameId,
    "movesId": movesId,
  };
}

Future<String> joinGameSession(
  String gameSessionId,
  String playerId2,
  int player1Position,
  int player2Position,
  String movesId,
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

  // Create or update the document in the "Moves" collection for the joined game session
  final movesResponse = await gameDatabase.updateDocument(
    collectionId: movesCollectionId,
    documentId: movesId,
    data: {
      "player1Position": player1Position,
      "player2Position": player2Position,
      "current_gameId": gameSessionId,
      "number_of_players": 2,
    },
    databaseId: databaseId,
  );
  return movesResponse.data['\$id'];
}

// Function to get game session details
Future<Map<String, dynamic>> getGameSession(String gameSessionId) async {
  final gameDatabase = databases;

  // Fetch the game session details from the "Game" collection
  final gameResponse = await gameDatabase.getDocument(
    collectionId: gameCollectionId,
    documentId: gameSessionId,
    databaseId: databaseId,
  );

  // Fetch the game moves document from the "Moves" collection
  final movesResponse = await gameDatabase.listDocuments(
    collectionId: movesCollectionId,
    queries: [
      Query.equal("current_gameId", gameSessionId),
    ],
    databaseId: databaseId,
  );

  final gameData = gameResponse.data;
  final movesData = movesResponse.documents.isNotEmpty
      ? movesResponse.documents.first.data
      : null;

  if (movesData != null) {
    gameData['player1Position'] = movesData['player1Position'];
    gameData['player2Position'] = movesData['player2Position'];
  }

  return gameData;
}

// check if the game session is active and compare the teamcode to join the game
Future getGameSessionIdFromTeamCode(String teamCode) async {
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

Future<String> getMovesDocumentId(String movesDocId) async {
  final database = databases;
  final response = await database.listDocuments(
    collectionId: movesCollectionId,
    queries: [
      Query.equal("current_gameId", movesDocId),
    ],
    databaseId: databaseId,
  );

  if (response.documents.isNotEmpty) {
    return response.documents.first.data['\$id'];
  }
  return response.documents.first.data['\$id'];
}
