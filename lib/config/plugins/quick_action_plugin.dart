import 'package:permissions/config/router/app_router.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickActionPlugin {
  static registerAction(){
   const  QuickActions quickActions =  QuickActions();
    quickActions.initialize((shortcutType) {
      print('ESTE ES EL SHORCUT TYPE: $shortcutType');
      switch (shortcutType) {
        case 'acelerometro':
        router.push('/acelerometro');
          break;
        case 'biometricos':
        router.push('/biometricos');
          break;
        case 'pokemons':
        router.push('/pokemons');
          break;
        case 'bulbasaur':
        router.push('/pokemons/1');
          break;
        default:
      }
    });
  //* el nombre de los iconos debe ser igual al de el type
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: 'acelerometro', localizedTitle: 'Acelerometro', icon: 'acelerometro'),
      const ShortcutItem(type: 'biometricos', localizedTitle: 'Biometricos', icon: 'biometricos'),
      const ShortcutItem(type: 'pokemons', localizedTitle: 'Pokemons', icon: 'pokemons'),
      const ShortcutItem(type: 'bulbasaur', localizedTitle: 'Bulbasaur', icon: 'bulbasaur'),
    ]);
  }
}