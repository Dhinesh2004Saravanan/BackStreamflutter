
class CollectionDetails
{

  late String name;
  late String type;

  CollectionDetails.fromJson(Map<dynamic ,dynamic> json)
  {

    name=json['name'];
    type=json['type'];


  }
}