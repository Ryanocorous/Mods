#HEY ALL! This mod makes wings give 255 EVs for the category they improve.
#Additionally, repels are rebalanced but this is optional. See below:

#OPTIONS BELOW#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

Fusion_incense_steps = 100

Repel_steps = 150

Super_repel_steps = 225

Max_repel_steps = 300

# Change the above numbers to the options you want. Have fun!. #

#Wing options:

wingraise = 16 # to allow EVs to be raised in marginal amounts.

vitaminraise = 252 # full EVs.

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
  if pbRaiseEffortValues(pkmn, :HP, wingraise, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1}'s HP increased.", pkmn.name))
  pkmn.changeHappiness("wing")
  next true
})

ItemHandlers::UseOnPokemon.add(:MUSCLEWING, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :ATTACK, wingraise, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Attack increased.", pkmn.name))
  pkmn.changeHappiness("wing")
  next true
})

ItemHandlers::UseOnPokemon.add(:RESISTWING, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :DEFENSE, wingraise, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Defense increased.", pkmn.name))
  pkmn.changeHappiness("wing")
  next true
})

ItemHandlers::UseOnPokemon.add(:GENIUSWING, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :SPECIAL_ATTACK, wingraise, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Special Attack increased.", pkmn.name))
  pkmn.changeHappiness("wing")
  next true
})

ItemHandlers::UseOnPokemon.add(:CLEVERWING, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :SPECIAL_DEFENSE, wingraise, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Special Defense increased.", pkmn.name))
  pkmn.changeHappiness("wing")
  next true
})

ItemHandlers::UseOnPokemon.add(:SWIFTWING, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :SPEED, wingraise, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Speed increased.", pkmn.name))
  pkmn.changeHappiness("wing")
  next true
})

ItemHandlers::UseOnPokemon.add(:PROTEIN, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :ATTACK, vitaminraise, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Attack maxed out.", pkmn.name))
  pkmn.changeHappiness("vitamin")
  next true
})

ItemHandlers::UseOnPokemon.add(:IRON, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :DEFENSE, vitaminraise, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Defense maxed out.", pkmn.name))
  pkmn.changeHappiness("vitamin")
  next true
})

ItemHandlers::UseOnPokemon.add(:CALCIUM, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :SPECIAL_ATTACK, vitaminraise, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Special Attack maxed out.", pkmn.name))
  pkmn.changeHappiness("vitamin")
  next true
})


ItemHandlers::UseOnPokemon.add(:ZINC, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :SPECIAL_DEFENSE, vitaminraise, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Special Defense maxed out.", pkmn.name))
  pkmn.changeHappiness("wing")
  next true
})

ItemHandlers::UseOnPokemon.add(:CARBOS, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :SPEED, vitaminraise, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbDisplay(_INTL("{1}'s Speed maxed out.", pkmn.name))
  pkmn.changeHappiness("wing")
  next true
})


ItemHandlers::UseOnPokemon.add(:HPUP, proc { |item, pkmn, scene|
  if pbRaiseEffortValues(pkmn, :HP, vitaminraise, false) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1}'s HP maxed out.", pkmn.name))
  pkmn.changeHappiness("vitamin")
  next true
})
