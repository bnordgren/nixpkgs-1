{stdenv, fetchurl, ant, unzip}:

stdenv.mkDerivation {
  name = "mysql-connector-java-5.1.24";
  builder = ./builder.sh;

  src = fetchurl {
    url = http://cdn.mysql.com/Downloads/Connector-J/mysql-connector-java-5.1.24.zip;
    sha256 = "0rhd76nqpn0vz2bafwkf3ny3dnm99z044vwas83ffnhx04zsv4f9";
  };

  buildInputs = [ unzip ant ];
}
