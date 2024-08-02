import 'package:permissions/domain/domain.dart';
import 'package:permissions/infraestructure/datasources/pokemon_datasource_imp.dart';

class PokemonsRepositoryImp implements PokemonsRepository{

final PokemonsDatasource datasource;

PokemonsRepositoryImp({PokemonsDatasource? datasource})
: datasource = datasource ?? PokemonDatasourceImp();

  @override
  Future<(Pokemon?, String)> getPokemon(String id) {
    return datasource.getPokemon(id);
  }

}