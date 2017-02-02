# furlong
[SQLJocky](https://github.com/jamesots/sqljocky) migration tool.
Will eventually work with [SQLJocky2](https://github.com/VenChat/sqljocky2).

# Todo
* Alterations
* Model generators
* More examples
* Use `inflection` package for pluralization

# Examples

```dart
class SongMigration extends Migration {
  // Name of class to generate
  @override
  String get name => "Song";

  @override
  Future create(Migrator migrator) async {
    await migrator.create("songs", (TableSchema table) {
      table.primaryKey = table.integer("id", autoIncrement: true);
      
      table.string("artist_id");
      table.string("title");
      table.string("desc").nullable = true;
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