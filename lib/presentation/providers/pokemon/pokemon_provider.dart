

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permissions/domain/domain.dart';
import 'package:permissions/infraestructure/repository/pokemons_repository_imp.dart';

final pokemonsRepositoryProvider = Provider<PokemonsRepository>((ref){
  return PokemonsRepositoryImp();
});

final pokemonProvider = FutureProvider.family<Pokemon,String>((ref,id) async{
  final pokemonRepository = ref.watch(pokemonsRepositoryProvider);

  final (pokemon, errorMessage) = await pokemonRepository.getPokemon(id);

  if(pokemon != null) return pokemon;
  
  throw errorMessage;
});