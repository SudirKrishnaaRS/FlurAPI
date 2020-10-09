class Note {
  String title;
  String email;
  int id;
  String phone;
  String website;


  Note(this.title, this.email,this.id,this.phone,this.website);

  Note.fromJson(Map<String, dynamic> json) {
    title = json['name'];
    email = json['email'];
    id=json['id'];
    phone=json['phone'];
    website=json['website'];

  }
}