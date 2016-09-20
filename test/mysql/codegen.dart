import 'package:furlong/furlong.dart';
import 'package:sqljocky/sqljocky.dart';
import 'package:test/test.dart';
import 'create_pool.dart';

main() async {
  group("codegen", runTests(await createPool()));
}

runTests(ConnectionPool pool) {
  return () {
    group("sample", () {
      test("users schema", () async {
        var migrator = new MySqlMigrator();

        migrator.create("user", (table) {
          table.id();
          table.string("username");
          table.string("email");
          table.string("password");
          table.string("confirmation_code");
          table.boolean("confirmed");
          table.text("bio").nullable = true;
          table.date("some_date").defaultValue = new DateTime.now();
          table.dateTime("created_at");
          table.dateTime("updated_at");
          table.enumerator("letter", ["a", "b", "c"]).defaultValue = "b";
        });

        var query = migrator.queries.first.toSql();
        print("Query: $query");
      });
    });

    group("int", () {
      test("auto_increment", () async {
        var migrator = new MySqlMigrator();

        migrator.create("foo", (MySqlTableSchema table) {
          var _int = table.primaryKey = table.integer("id", autoIncrement: true);

          expect(_int.autoIncrement, equals(true));
          expect(_int.name, equals("id"));
          expect(_int.nullable, equals(false));
          expect(_int.size, equals(4));
        });

        var query = migrator.queries.first.toSql();
        print("Query: $query");
        expect(query, contains("auto_increment"));
        expect(query, contains("not null"));
        expect(query, contains("PRIMARY KEY(`id`)"));
      });
    });

    group("text", () {
      test("size", () {
        var migrator = new MySqlMigrator();

        migrator.create("foo", (MySqlTableSchema table) {
          table.string("bar", size: 34).nullable = true;
        });

        var query = migrator.queries.first.toSql();
        print("Query: $query");
        expect(query, contains("VARCHAR(34)"));
        expect(query.contains("not null"), equals(false));
      });
    });
  };
}
