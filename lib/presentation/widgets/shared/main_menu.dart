import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItem{
final String title;
final IconData icon;
final String route;

  MenuItem( this.title,  this.icon,  this.route);
}

final menuItems = <MenuItem>[
  MenuItem('Giroscopio', Icons.downloading, '/giroscopio'),
  MenuItem('Acelerometro', Icons.speed, '/acelerometro'),
  MenuItem('Magnetometro', Icons.explore_outlined, '/magnetometro'),
  
  MenuItem('Giroscopio bola', Icons.sports_baseball_outlined, '/giroscopio-bola'),
  MenuItem('Brujula', Icons.explore, '/brujula'),
  MenuItem('Pokemons', Icons.catching_pokemon, '/pokemons'),
  MenuItem('Biometricos', Icons.fingerprint_outlined, '/biometricos'),
  MenuItem('Badge', Icons.notification_important, '/badge'),
];

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children:menuItems.map((menuItem) => _HomeMenueItem(menuItem: menuItem)).toList()
      );
  }
}

class _HomeMenueItem extends StatelessWidget {
  final MenuItem menuItem;
  final List<Color> bgColors;
  const _HomeMenueItem({ 
    required this.menuItem,  
    this.bgColors = const <Color>[Colors.lightBlue, Colors.blue]
    });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: (){
        context.push(menuItem.route);
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: bgColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(menuItem.icon,color: Colors.white,size: 40,),
            const SizedBox(height: 10,),
            Text(menuItem.title, style: text.labelSmall!.copyWith(color: Colors.white),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}