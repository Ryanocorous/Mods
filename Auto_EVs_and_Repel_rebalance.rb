#HEY ALL! This mod makes wings give 255 EVs for the category they improve.
#Additionally, repels are rebalanced but this is optional. See below:

#Options
#To set the options for repels, simply change the values after
#For example, to change:

#Repel to 100

#Simply change the value of repel below (after the = ) to 100.

#So "Repel_steps = 150" would become "Repel_steps = 100"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

Fusion_incense_steps = 100

Repel_steps = 150

Super_repel_steps = 225

Max_repel_steps = 300

# Change the above numbers to the options you want. Have fun!. #

# Code:


ItemHandlers::UseInField.add(:FUSIONREPEL, proc { |item|
  $game_switches[SWITCH_FORCE_ALL_WILD_FUSIONS] = true
  $game_switches[SWITCH_USED_AN_INCENSE] = true
  next pbRepel(item, Fusion_incense_steps)
})

ItemHandlers::UseInField.add(:REPEL, proc { |item|
  next pbRepel(item, Repel_steps)
})

ItemHandlers::UseInField.add(:SUPERREPEL, proc { |item|
  next pbRepel(item, Super_repel_steps)
})

ItemHandlers::UseInField.add(:MAXREPEL, proc { |item|
  next pbRepel(item, Max_repel_steps)
})


ItemHandlers::UseOnPokemon.add(:HEALTHWING, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :HP, 252, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1}'s HP increased.", pkmn.name))
  pkmn.changeHappiness("wing")
  next true
})

ItemHandlers::UseOnPokemon.add(:MUSCLEWING, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :ATTACK, 252, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Attack increased.", pkmn.name))
  pkmn.changeHappiness("wing")
  next true
})

ItemHandlers::UseOnPokemon.add(:RESISTWING, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :DEFENSE, 252, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Defense increased.", pkmn.name))
  pkmn.changeHappiness("wing")
  next true
})

ItemHandlers::UseOnPokemon.add(:GENIUSWING, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :SPECIAL_ATTACK, 252, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Special Attack increased.", pkmn.name))
  pkmn.changeHappiness("wing")
  next true
})

ItemHandlers::UseOnPokemon.add(:CLEVERWING, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :SPECIAL_DEFENSE, 252, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Special Defense increased.", pkmn.name))
  pkmn.changeHappiness("wing")
  next true
})

ItemHandlers::UseOnPokemon.add(:SWIFTWING, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :SPEED, 252, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Speed increased.", pkmn.name))
  pkmn.changeHappiness("wing")
  next true
})
