import 'package:flutter_riverpod/flutter_riverpod.dart';

final pokemonsIdsProvider = StateProvider<List<int>>((ref){
  //lista generada [1,2,3,4,5,...30];
  return List.generate(30, (index) => index + 1);
});