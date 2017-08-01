module AnimalProducts
  # Note: Some words may look weird because the endings have been omitted
  # to account for both singular and plural versions.
  # Ex: anchov works for anchovy and anchovies.

  ANTI_VEGETARIAN = ['thyme','anchov', 'bacon', 'beef', 'bison', 'calamari', 'chicken',
    'clam', 'cod', 'duck', 'fish', 'goose', 'halibut', 'ham', 'hen', 'lamb',
    'liver', 'lobster', 'oyster', 'pheasant', 'pork', 'poultry', 'salmon',
    'sardine', 'scallop', 'shrimp', 'steak', 'tilapia', 'tripe', 'tuna',
    'turkey', 'veal', 'venison'
  ]

  ANTI_VEGAN = ['asiago', 'brie', 'camembert', 'cheddar', 'chevre', 'egg',
    'feta', 'gorgonzola', 'gouda', 'gruyere', 'halloumi', 'havarti', 'honey',
    'monterey jack', 'mozzarella', 'parmesan', 'pecorino', 'pepper jack',
    'provolone', 'ricotta', 'yolk'
  ]
end

# use regex to check independent of letter case

# TO DO:
# In queries controller (after store) compare results
# against lists according to health param
#
# filter_hits: add argument on query_results (animal_hits), add argument
# on controller call (list of recipes to be filtered)
