class GetUserAuthDetails
{
  late final  id;
  late final  emailId;
  late final  password;
  late final  createdAt;

  GetUserAuthDetails.fromJson(Map<dynamic,dynamic> json)
  {
    id=json["_id"];
    emailId=json["emailId"];
    password=json["password"];
    createdAt=json["createdAt"];

  }
}