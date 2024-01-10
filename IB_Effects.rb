#===============================================================================
# UseInBattle handlers
# For items used directly or on an opposing battler
# Changes to Pokedoll, fluffytail, etc.
#===============================================================================
ItemHandlers::UseInBattle.add(:GUARDSPEC,proc { |item,battler,battle|
  battler.pbOwnSide.effects[PBEffects::Mist] = 5
  battle.pbDisplay(_INTL("{1} became shrouded in mist!",battler.pbTeam))
  battler.pokemon.changeHappiness("battleitem")
})

ItemHandlers::UseInBattle.add(:POKEDOLL,proc { |item,battler,battle|
  scene.pbDisplay(_INTL("{1} couldn't escape.",name))
})

ItemHandlers::UseInBattle.copy(:POKEDOLL,:FLUFFYTAIL,:POKETOY)

ItemHandlers::UseInBattle.add(:POKEFLUTE,proc { |item,battler,battle|
  battle.eachBattler do |b|
    next if b.status != :SLEEP || b.hasActiveAbility?(:SOUNDPROOF)
    b.pbCureStatus(false)
  end
  battle.pbDisplay(_INTL("Pokemon woke up, and took damage."))
  #  pbBattleHPItem(pokemon,battler,-10%,scene)
  pbBattleHPItem(pokemon,battler,-10,scene)
  pokemon.hp = 1 if pokemon.hp<=0
})

#===============================================================================
# BattleUseOnPokemon handlers
# For items used on Pokémon or on a Pokémon's move
# Changes to hp regain IN BATTLE only.
#===============================================================================
ItemHandlers::BattleUseOnPokemon.add(:POTION,proc { |item,pokemon,battler,choices,scene|
  pbBattleHPItem(pokemon,battler,15,scene)
})

ItemHandlers::BattleUseOnPokemon.copy(:POTION,:BERRYJUICE,:SWEETHEART)
ItemHandlers::BattleUseOnPokemon.copy(:POTION,:RAGECANDYBAR) if !Settings::RAGE_CANDY_BAR_CURES_STATUS_PROBLEMS

ItemHandlers::BattleUseOnPokemon.add(:SUPERPOTION,proc { |item,pokemon,battler,choices,scene|
  pbBattleHPItem(pokemon,battler,35,scene)
})

ItemHandlers::BattleUseOnPokemon.add(:HYPERPOTION,proc { |item,pokemon,battler,choices,scene|
  pbBattleHPItem(pokemon,battler,60,scene)
})

ItemHandlers::BattleUseOnPokemon.add(:MAXPOTION,proc { |item,pokemon,battler,choices,scene|
  pbBattleHPItem(pokemon,battler,100,scene)
})

ItemHandlers::BattleUseOnPokemon.add(:FRESHWATER,proc { |item,pokemon,battler,choices,scene|
  pbBattleHPItem(pokemon,battler,20,scene)
})

ItemHandlers::BattleUseOnPokemon.add(:SODAPOP,proc { |item,pokemon,battler,choices,scene|
  pbBattleHPItem(pokemon,battler,40,scene)
})

ItemHandlers::BattleUseOnPokemon.add(:LEMONADE,proc { |item,pokemon,battler,choices,scene|
  pbBattleHPItem(pokemon,battler,50,scene)
})

ItemHandlers::BattleUseOnPokemon.add(:MOOMOOMILK,proc { |item,pokemon,battler,choices,scene|
  pbBattleHPItem(pokemon,battler,50,scene)
})

ItemHandlers::BattleUseOnPokemon.add(:ORANBERRY,proc { |item,pokemon,battler,choices,scene|
  pbBattleHPItem(pokemon,battler,5,scene)
})

ItemHandlers::BattleUseOnPokemon.add(:SITRUSBERRY,proc { |item,pokemon,battler,choices,scene|
  pbBattleHPItem(pokemon,battler,10,scene)
})

ItemHandlers::BattleUseOnPokemon.add(:AWAKENING,proc { |item,pokemon,battler,choices,scene|
  pokemon.heal_status
  battler.pbCureStatus(false) if battler
  name = (battler) ? battler.pbThis : pokemon.name
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1} woke up and took damage.",name))
#  pbBattleHPItem(pokemon,battler,-10%,scene)
   pbBattleHPItem(pokemon,battler,-10,scene)
   pokemon.hp = 1 if pokemon.hp<=0
})

ItemHandlers::BattleUseOnPokemon.copy(:AWAKENING,:CHESTOBERRY,:BLUEFLUTE)

ItemHandlers::BattleUseOnPokemon.add(:ANTIDOTE,proc { |item,pokemon,battler,choices,scene|
  pokemon.heal_status
  battler.pbCureStatus(false) if battler
  name = (battler) ? battler.pbThis : pokemon.name
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1} was cured of its poisoning but took damage.",name))
  scene.pbDisplay(_INTL("{1} took damage.",name))
#  pbBattleHPItem(pokemon,battler,-10%,scene)
   pbBattleHPItem(pokemon,battler,-10,scene)
   pokemon.hp = 1 if pokemon.hp<=0
})

ItemHandlers::BattleUseOnPokemon.copy(:ANTIDOTE,:PECHABERRY)

ItemHandlers::BattleUseOnPokemon.add(:BURNHEAL,proc { |item,pokemon,battler,choices,scene|
  pokemon.heal_status
  battler.pbCureStatus(false) if battler
  name = (battler) ? battler.pbThis : pokemon.name
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1}'s burn was healed but took damage.",name))
#  pbBattleHPItem(pokemon,battler,-10%,scene)
   pbBattleHPItem(pokemon,battler,-10,scene)
   pokemon.hp = 1 if pokemon.hp<=0
})

ItemHandlers::BattleUseOnPokemon.copy(:BURNHEAL,:RAWSTBERRY)

ItemHandlers::BattleUseOnPokemon.add(:PARALYZEHEAL,proc { |item,pokemon,battler,choices,scene|
  pokemon.heal_status
  battler.pbCureStatus(false) if battler
  name = (battler) ? battler.pbThis : pokemon.name
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1} was cured of paralysis but took damage.",name))
#  pbBattleHPItem(pokemon,battler,-10%,scene)
   pbBattleHPItem(pokemon,battler,-10,scene)
   pokemon.hp = 1 if pokemon.hp<=0
})

ItemHandlers::BattleUseOnPokemon.copy(:PARALYZEHEAL,:PARLYZHEAL,:CHERIBERRY)

ItemHandlers::BattleUseOnPokemon.add(:ICEHEAL,proc { |item,pokemon,battler,choices,scene|
  pokemon.heal_status
  battler.pbCureStatus(false) if battler
  name = (battler) ? battler.pbThis : pokemon.name
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1} was thawed out and took damage.",name))
#  pbBattleHPItem(pokemon,battler,-10%,scene)
   pbBattleHPItem(pokemon,battler,-10,scene)
   pokemon.hp = 1 if pokemon.hp<=0
})

ItemHandlers::BattleUseOnPokemon.copy(:ICEHEAL,:ASPEARBERRY)

ItemHandlers::BattleUseOnPokemon.add(:FULLHEAL,proc { |item,pokemon,battler,choices,scene|
  pokemon.heal_status
  battler.pbCureStatus(false) if battler
  battler.pbCureConfusion if battler
  name = (battler) ? battler.pbThis : pokemon.name
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1} became healthy but took damage.",name))
  #  pbBattleHPItem(pokemon,battler,-5%,scene)
  pbBattleHPItem(pokemon,battler,-5,scene)
  pokemon.hp = 1 if pokemon.hp<=0
})

ItemHandlers::BattleUseOnPokemon.copy(:FULLHEAL,
   :LAVACOOKIE,:OLDGATEAU,:CASTELIACONE,:LUMIOSEGALETTE,:SHALOURSABLE,
   :BIGMALASADA,:LUMBERRY)
ItemHandlers::BattleUseOnPokemon.copy(:FULLHEAL,:RAGECANDYBAR) if Settings::RAGE_CANDY_BAR_CURES_STATUS_PROBLEMS

ItemHandlers::BattleUseOnPokemon.add(:FULLRESTORE,proc { |item,pokemon,battler,choices,scene|
  pokemon.heal_status
  battler.pbCureStatus(false) if battler
  battler.pbCureConfusion if battler
  name = (battler) ? battler.pbThis : pokemon.name
  if pokemon.hp<pokemon.totalhp
    pbBattleHPItem(pokemon,battler,pokemon.totalhp/1.2,scene)
	pokemon.hp = 1 if pokemon.hp<=0
  else
    scene.pbRefresh
    scene.pbDisplay(_INTL("{1} fully healed but suffered some damage.",name))
  end
})

ItemHandlers::BattleUseOnPokemon.add(:REVIVE,proc { |item,pokemon,battler,choices,scene|
  pokemon.hp = pokemon.totalhp/3
  pokemon.hp = 1 if pokemon.hp<=0
  pokemon.heal_status
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1} recovered from fainting!",pokemon.name))
})

ItemHandlers::BattleUseOnPokemon.add(:MAXREVIVE,proc { |item,pokemon,battler,choices,scene|
  pokemon.hp = pokemon.totalhp/1.5
  pokemon.hp = 1 if pokemon.hp<=0
  pokemon.heal_status
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1} recovered from fainting!",pokemon.name))
})

ItemHandlers::BattleUseOnPokemon.add(:ENERGYPOWDER,proc { |item,pokemon,battler,choices,scene|
  if pbBattleHPItem(pokemon,battler,30,scene)
    pokemon.changeHappiness("powder")
  end
})

ItemHandlers::BattleUseOnPokemon.add(:ENERGYROOT,proc { |item,pokemon,battler,choices,scene|
  if pbBattleHPItem(pokemon,battler,60,scene)
    pokemon.changeHappiness("energyroot")
  end
})

ItemHandlers::BattleUseOnPokemon.add(:HEALPOWDER,proc { |item,pokemon,battler,choices,scene|
  pokemon.heal_status
#  pbBattleHPItem(pokemon,battler,-10%,scene)
  pbBattleHPItem(pokemon,battler,-10,scene)
  pokemon.hp = 1 if pokemon.hp<=0
  battler.pbCureStatus(false) if battler
  battler.pbCureConfusion if battler
  pokemon.changeHappiness("powder")
  name = (battler) ? battler.pbThis : pokemon.name
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1} became healthy.",name))
})

ItemHandlers::BattleUseOnPokemon.add(:REVIVALHERB,proc { |item,pokemon,battler,choices,scene|
  pokemon.hp = pokemon.totalhp/4
  pokemon.hp = 1 if pokemon.hp<=0
  pokemon.heal_status
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1} recovered from fainting!",pokemon.name))
})

ItemHandlers::BattleUseOnPokemon.add(:ETHER,proc { |item,pokemon,battler,choices,scene|
  idxMove = choices[3]
  pbBattleRestorePP(pokemon,battler,idxMove,5)
  scene.pbDisplay(_INTL("PP was restored."))
})

ItemHandlers::BattleUseOnPokemon.copy(:ETHER,:LEPPABERRY)

ItemHandlers::BattleUseOnPokemon.add(:MAXETHER,proc { |item,pokemon,battler,choices,scene|
  idxMove = choices[3]
  pbBattleRestorePP(pokemon,battler,idxMove,10)
  scene.pbDisplay(_INTL("PP was partly restored."))
})

ItemHandlers::BattleUseOnPokemon.add(:ELIXIR,proc { |item,pokemon,battler,choices,scene|
  for i in 0...pokemon.moves.length
    pbBattleRestorePP(pokemon,battler,i,5)
  end
  scene.pbDisplay(_INTL("PP was restored by 5."))
})

ItemHandlers::BattleUseOnPokemon.add(:MAXELIXIR,proc { |item,pokemon,battler,choices,scene|
  for i in 0...pokemon.moves.length
    pbBattleRestorePP(pokemon,battler,i,10)
  end
  scene.pbDisplay(_INTL("PP was restored by 10."))
})
