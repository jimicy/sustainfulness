import 'dart:math';
import 'package:hydrated_bloc/hydrated_bloc.dart';

enum EnergyElement { water, fire, wood, metal, earth }

const assetPaths = {
  EnergyElement.water: 'assets/images/element_icon_water.png',
  EnergyElement.fire: 'assets/images/element_icon_fire.png',
  EnergyElement.wood: 'assets/images/element_icon_wood.png',
  EnergyElement.metal: 'assets/images/element_icon_metal.png',
  EnergyElement.earth: 'assets/images/element_icon_earth.png',
};

class DailyElementState {
  DailyElementState({required this.element, required this.date});
  final EnergyElement element;
  final DateTime date;
}

// Hold a state representing the random element to be revealed.
class DailyElementCubit extends HydratedCubit<DailyElementState> {
  DailyElementCubit()
      : super(
          DailyElementState(
            element: EnergyElement.values[Random().nextInt(5)],
            date: DateTime.now(),
          ),
        );

  void setNewDailyElement() {
    emit(
      DailyElementState(
        element: EnergyElement.values[Random().nextInt(5)],
        date: DateTime.now(),
      ),
    );
  }

  String get elementAssetPath => assetPaths[state.element]!;

  bool get atLeastOneDayHasPassed {
    final now = DateTime.now();
    final lastDate = state.date;
    return now.difference(lastDate).inDays > 0;
  }

  @override
  DailyElementState fromJson(Map<String, dynamic> json) {
    final element = EnergyElement.values[json['element'] as int];
    final date = DateTime.parse(json['date'] as String);
    return DailyElementState(element: element, date: date);
  }

  @override
  Map<String, dynamic>? toJson(DailyElementState state) =>
      {'element': state.element.index, 'date': state.date.toIso8601String()};
}
