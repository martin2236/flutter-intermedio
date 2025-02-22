import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permissions/presentation/providers/providers.dart';

class PokemonsScreen extends StatelessWidget {
  const PokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PokemonsView(),
    );
  }
}

class PokemonsView extends ConsumerStatefulWidget {
  const PokemonsView({super.key});

  @override
  PokemonsViewState createState() => PokemonsViewState();
}

class PokemonsViewState extends ConsumerState<PokemonsView> {

  final scrollController = ScrollController();

void infiniteScroll(){
  final currenPokemons = ref.read(pokemonsIdsProvider);
  if(currenPokemons.length > 900){
    scrollController.removeListener(infiniteScroll);
    return;
  }
  if((scrollController.position.pixels + 200) > scrollController.position.maxScrollExtent){
    ref.read(pokemonsIdsProvider.notifier).update((state)=>[
      ...state,
      ...List.generate(30, (index) => state.length + index + 1)
      ]);
  }
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(infiniteScroll);
  }
@override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          title: const Text('Pokemons'),
          floating: true,
          backgroundColor: Colors.white.withOpacity(0.8),
        ),
        const _PokemonGrid()
      ],
    );
  }
}

class _PokemonGrid extends ConsumerWidget {
  const _PokemonGrid();

  @override
  Widget build(BuildContext context, ref) {

    final pokemonIds = ref.watch(pokemonsIdsProvider);

    return SliverGrid.builder(
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2
      ), 
      itemCount: pokemonIds.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            context.push('/pokemons/${pokemonIds[index]}');
          },
          child: Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index+1}.png',
          fit: BoxFit.contain,
          ),
        );
      },);
  }
}