import 'dart:math';
import 'package:hydrated_bloc/hydrated_bloc.dart';

enum EnergyElement { water, fire, wood, metal, earth }

const assetPaths = {
  EnergyElement.water: 'assets/images/elements/icons/water.png',
  EnergyElement.fire: 'assets/images/elements/icons/fire.png',
  EnergyElement.wood: 'assets/images/elements/icons/wood.png',
  EnergyElement.metal: 'assets/images/elements/icons/metal.png',
  EnergyElement.earth: 'assets/images/elements/icons/earth.png',
};

const bgAssetPaths = {
  EnergyElement.water: 'assets/images/elements/bg/water.jpg',
  EnergyElement.fire: 'assets/images/elements/bg/fire.jpg',
  EnergyElement.wood: 'assets/images/elements/bg/wood.jpg',
  EnergyElement.metal: 'assets/images/elements/bg/metal.jpg',
  EnergyElement.earth: 'assets/images/elements/bg/earth.jpg',
};

const cardUris = {
  EnergyElement.water: [
    'https://storage.googleapis.com/global-citizen-assets/card_water1.png',
    'https://storage.googleapis.com/global-citizen-assets/card_water2.png',
    'https://storage.googleapis.com/global-citizen-assets/card_water3.png',
    'https://storage.googleapis.com/global-citizen-assets/card_water4.png',
    'https://storage.googleapis.com/global-citizen-assets/card_water5.png',
    'https://storage.googleapis.com/global-citizen-assets/card_water6.png',
    'https://storage.googleapis.com/global-citizen-assets/card_water7.png',
    'https://storage.googleapis.com/global-citizen-assets/card_water8.png',
    'https://storage.googleapis.com/global-citizen-assets/card_water9.png',
    'https://storage.googleapis.com/global-citizen-assets/card_water10.png',
  ],
  EnergyElement.fire: [
    'https://storage.googleapis.com/global-citizen-assets/card_fire1.png',
    'https://storage.googleapis.com/global-citizen-assets/card_fire2.png',
    'https://storage.googleapis.com/global-citizen-assets/card_fire3.png',
    'https://storage.googleapis.com/global-citizen-assets/card_fire4.png',
    'https://storage.googleapis.com/global-citizen-assets/card_fire5.png',
    'https://storage.googleapis.com/global-citizen-assets/card_fire6.png',
    'https://storage.googleapis.com/global-citizen-assets/card_fire7.png',
    'https://storage.googleapis.com/global-citizen-assets/card_fire8.png',
    'https://storage.googleapis.com/global-citizen-assets/card_fire9.png',
    'https://storage.googleapis.com/global-citizen-assets/card_fire10.png',
  ],
  EnergyElement.wood: [
    'https://storage.googleapis.com/global-citizen-assets/card_wood1.png',
    'https://storage.googleapis.com/global-citizen-assets/card_wood2.png',
    'https://storage.googleapis.com/global-citizen-assets/card_wood3.png',
    'https://storage.googleapis.com/global-citizen-assets/card_wood4.png',
    'https://storage.googleapis.com/global-citizen-assets/card_wood5.png',
    'https://storage.googleapis.com/global-citizen-assets/card_wood6.png',
    'https://storage.googleapis.com/global-citizen-assets/card_wood7.png',
    'https://storage.googleapis.com/global-citizen-assets/card_wood8.png',
    'https://storage.googleapis.com/global-citizen-assets/card_wood9.png',
    'https://storage.googleapis.com/global-citizen-assets/card_wood10.png',
  ],
  EnergyElement.metal: [
    'https://storage.googleapis.com/global-citizen-assets/card_metal1.png',
    'https://storage.googleapis.com/global-citizen-assets/card_metal2.png',
    'https://storage.googleapis.com/global-citizen-assets/card_metal3.png',
    'https://storage.googleapis.com/global-citizen-assets/card_metal4.png',
    'https://storage.googleapis.com/global-citizen-assets/card_metal5.png',
    'https://storage.googleapis.com/global-citizen-assets/card_metal6.png',
    'https://storage.googleapis.com/global-citizen-assets/card_metal7.png',
    'https://storage.googleapis.com/global-citizen-assets/card_metal8.png',
    'https://storage.googleapis.com/global-citizen-assets/card_metal9.png',
    'https://storage.googleapis.com/global-citizen-assets/card_metal10.png',
  ],
  EnergyElement.earth: [
    'https://storage.googleapis.com/global-citizen-assets/card_earth1.png',
    'https://storage.googleapis.com/global-citizen-assets/card_earth2.png',
    'https://storage.googleapis.com/global-citizen-assets/card_earth3.png',
    'https://storage.googleapis.com/global-citizen-assets/card_earth4.png',
    'https://storage.googleapis.com/global-citizen-assets/card_earth5.png',
    'https://storage.googleapis.com/global-citizen-assets/card_earth6.png',
    'https://storage.googleapis.com/global-citizen-assets/card_earth7.png',
    'https://storage.googleapis.com/global-citizen-assets/card_earth8.png',
    'https://storage.googleapis.com/global-citizen-assets/card_earth9.png',
    'https://storage.googleapis.com/global-citizen-assets/card_earth10.png',
  ],
};

class DailyElementState {
  DailyElementState(
      {required this.element, required this.date, required this.cardUri});
  final EnergyElement element;
  final DateTime date;
  final String cardUri;
}

EnergyElement randomElement = EnergyElement.values[Random().nextInt(5)];
String randomCardUri =
    cardUris[randomElement]![Random().nextInt(cardUris[randomElement]!.length)];

// Hold a state representing the random element to be revealed.
class DailyElementCubit extends HydratedCubit<DailyElementState> {
  DailyElementCubit()
      : super(
          DailyElementState(
            element: randomElement,
            cardUri: randomCardUri,
            date: DateTime.now(),
          ),
        );

  void setNewDailyElement() {
    EnergyElement newRandomElement = EnergyElement.values[Random().nextInt(5)];
    String newRandomCardUri = cardUris[newRandomElement]![
        Random().nextInt(cardUris[newRandomElement]!.length)];

    emit(
      DailyElementState(
        element: newRandomElement,
        cardUri: newRandomCardUri,
        date: DateTime.now(),
      ),
    );
  }

  String get elementAssetPath => assetPaths[state.element]!;

  String get elementBgAssetPath => bgAssetPaths[state.element]!;

  bool get atLeastOneDayHasPassed {
    final now = DateTime.now();
    final lastDate = state.date;
    return now.difference(lastDate).inDays > 0;
  }

  @override
  DailyElementState fromJson(Map<String, dynamic> json) {
    final element = EnergyElement.values[json['element'] as int];
    final date = DateTime.parse(json['date'] as String);
    final cardUri = json['cardUri'] as String;
    return DailyElementState(element: element, date: date, cardUri: cardUri);
  }

  @override
  Map<String, dynamic>? toJson(DailyElementState state) => {
        'element': state.element.index,
        'date': state.date.toIso8601String(),
        'cardUri': state.cardUri
      };
}
