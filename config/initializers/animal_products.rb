module AnimalProducts
  # Note: Some words may look weird because the endings have been omitted
  # to account for both singular and plural versions.
  # Ex: anchov works for anchovy and anchovies.

  ANTI_VEGETARIAN = ['anchov', 'bacon', 'beef', 'bison', 'calamari', 'chicken',
    'clam', 'cod', 'duck', 'fish', 'goose', 'halibut', 'ham', 'hen', 'lamb',
    'liver', 'lobster', 'oyster', 'pheasant', 'pork', 'poultry', 'salmon',
    'sardine', 'scallop', 'shrimp', 'steak', 'tilapia', 'tripe', 'tuna',
    'turkey', 'veal', 'venison'
  ]

  ANTI_VEGAN = ['anchov', 'asiago', 'bacon', 'beef', 'bison', 'brie',
    'calamari', 'camembert', 'cheddar', 'chevre', 'chicken', 'clam', 'cod',
    'duck', 'egg', 'feta', 'fish', 'goose', 'gorgonzola', 'gouda', 'gruyere',
    'halibut', 'halloumi', 'ham', 'havarti', 'hen', 'honey', 'lamb', 'liver',
    'lobster', 'monterey jack', 'mozzarella', 'oyster', 'parmesan', 'pecorino',
    'pepper jack', 'pheasant', 'pork', 'poultry', 'provolone', 'ricotta',
    'salmon', 'sardine', 'scallop', 'shrimp', 'steak', 'tilapia', 'tripe',
    'tuna', 'turkey', 'veal', 'venison', 'yolk'
  ]

end

# use regex to check independent of letter case

# TO DO:
# In queries controller (after store) compare results
# against lists according to health param
#
# filter_hits: add argument on query_results (animal_hits), add argument
# on controller call (list of recipes to be filtered)
