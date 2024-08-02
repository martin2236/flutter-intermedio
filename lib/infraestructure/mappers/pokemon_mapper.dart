
import 'package:permissions/infraestructure/models/pokeapi_pokemon_response.dart';

import '../../domain/domain.dart';

class PokemonMapper{
  static Pokemon pokemonToEntitie(Map<String,dynamic> json){
    final pokeapiPokemon = PokeApiPokemonResponse.fromJson(json);

    return Pokemon(
      id: pokeapiPokemon.id, 
      name: pokeapiPokemon.name, 
      spriteFront: pokeapiPokemon.sprites.frontDefault
      );
  }
}