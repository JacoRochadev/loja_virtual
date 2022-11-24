class CepAbertoAdress {
  final double latitude;
  final double longitude;
  final double altitude;
  final String logradouro;
  final String bairro;
  final String cep;
  final Cidade cidade;
  final Estado estado;

  CepAbertoAdress({
    this.latitude,
    this.longitude,
    this.altitude,
    this.logradouro,
    this.bairro,
    this.cep,
    this.cidade,
    this.estado,
  });

  factory CepAbertoAdress.fromMap(Map<String, dynamic> map) {
    return CepAbertoAdress(
      latitude: double.tryParse(map['latitude'] as String),
      longitude: double.tryParse(map['longitude'] as String),
      altitude: map['altitude'] as double,
      logradouro: map['logradouro'] as String,
      bairro: map['bairro'] as String,
      cep: map['cep'] as String,
      cidade: Cidade.fromMap(map['cidade'] as Map<String, dynamic>),
      estado: Estado.fromMap(map['estado'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'CepAbertoAdress(latitude: $latitude, longitude: $longitude, altitude: $altitude, logradouro: $logradouro, bairro: $bairro, cep: $cep, cidade: $cidade, estado: $estado)';
  }
}

class Cidade {
  int ddd;
  String ibge;
  String nome;

  Cidade({this.ddd, this.ibge, this.nome});

  Cidade.fromMap(Map<String, dynamic> map) {
    ddd = map['ddd'] as int;
    ibge = map['ibge'] as String;
    nome = map['nome'] as String;
  }

  @override
  String toString() {
    return 'Cidade(ddd: $ddd, ibge: $ibge, nome: $nome)';
  }
}

class Estado {
  String sigla;

  Estado({this.sigla});

  Estado.fromMap(Map<String, dynamic> map) {
    sigla = map['sigla'] as String;
  }

  @override
  String toString() {
    return 'Estado(sigla: $sigla)';
  }
}
