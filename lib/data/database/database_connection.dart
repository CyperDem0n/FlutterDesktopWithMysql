import 'package:mysql1/mysql1.dart';

class DatabaseConn {
  static String host = 'host',
      user = 'dbuser',
      password = 'dbpassword',
      db = 'dbname';
  static int port = yourportgoeshere;

  DatabaseConn();

  static Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);
    return await MySqlConnection.connect(settings);
  }
}
