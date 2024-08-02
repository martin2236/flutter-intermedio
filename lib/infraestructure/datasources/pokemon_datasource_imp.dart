
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:permissions/domain/domain.dart';
import 'package:permissions/infraestructure/mappers/pokemon_mapper.dart';

class PokemonDatasourceImp implements PokemonsDatasource{
  final Dio dio;

    PokemonDatasourceImp() 
    : dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {

    try {
      final resp =await dio.get('/pokemon/$id');
      final pokemon = PokemonMapper.pokemonToEntitie(resp.data);
      return (pokemon, 'Datos obtenidos con éxito');
    } catch (e) {
      return (null, 'no se pudo obtener el pokemon $e');
    }
  }

}