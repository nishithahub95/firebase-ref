
class Questions{
  final String id;
  final String title;
  final Map<String,bool>options;

  Questions({required this.id, required this.title, required this.options});
@override
  String toString() {
    // TODO: implement toString

    return 'Questions(id: $id, title: $title, options: $options)';
  }

}