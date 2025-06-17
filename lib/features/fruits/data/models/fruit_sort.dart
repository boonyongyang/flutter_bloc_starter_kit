import 'fruit_model.dart';

enum FruitSort {
  name('Name (A-Z)'),
  sugar('Sugar (High to Low)'),
  sugarLow('Sugar (Low to High)'),
  protein('Protein (High to Low)'),
  fat('Fat (High to Low)'),
  calories('Calories (High to Low)');

  final String label;
  const FruitSort(this.label);

  int compare(Fruit a, Fruit b) {
    switch (this) {
      case FruitSort.name:
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      case FruitSort.sugar:
        return b.nutritions.sugar.compareTo(a.nutritions.sugar);
      case FruitSort.sugarLow:
        return a.nutritions.sugar.compareTo(b.nutritions.sugar);
      case FruitSort.protein:
        return b.nutritions.protein.compareTo(a.nutritions.protein);
      case FruitSort.fat:
        return b.nutritions.fat.compareTo(a.nutritions.fat);
      case FruitSort.calories:
        return b.nutritions.calories.compareTo(a.nutritions.calories);
    }
  }
}
