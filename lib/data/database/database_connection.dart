import 'package:mysql1/mysql1.dart';

class DatabaseConn {
  static String host = 'localhost',
      user = 'ryu',
      password = '1q2w3e',
      db = 'test';
  static int port = 3306;

  DatabaseConn();

  static Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);
    return await MySqlConnection.connect(settings);
  }
}
