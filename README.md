# furlong
[SQLJocky](https://github.com/jamesots/sqljocky) migration tool.
Will eventually work with [SQLJocky2](https://github.com/VenChat/sqljocky2).

# Todo
* All field specifications
* Command-line executable
* Grinder examples
* More examples
* Use `inflection` package for pluralization

# Examples

```dart
class SongMigration extends Migration {
  @override
  String get name => "Songs table";

  @override
  Future create(Migrator migrator) async {
    await migrator.create("songs", (TableSchema table) {
      table.primaryKey = table.integer("id", autoIncrement: true);
      
      table.varChar("artist_id");
      table.varChar("title");
      table.varChar("desc").nullable = true;
      table.timeStamp("created_at");
      table.timeStamp("updated_at");
    });
  }

  @override
  Future destroy(Migrator migrator) async {
    await migrator.drop(["songs"]);
  }
}
```