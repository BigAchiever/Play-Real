import 'package:nanoid/nanoid.dart';

// Generating team code
String generateTeamCode() {
  const codeLength = 6;

  // random team code
  final teamCode = nanoid(codeLength);

  return teamCode;
}
