class Ticket {
  final String name;
  final String cpf;
  final String email;
  final String area;

  Ticket({
    required this.name,
    required this.cpf,
    required this.email,
    required this.area,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'cpf': cpf,
    'email': email,
    'area': area,
  };

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    name: json['name'],
    cpf: json['cpf'],
    email: json['email'],
    area: json['area'],
  );
}
