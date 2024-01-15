# Instructions: 
# How to edit
# It is recommended you leave the values as they are.
# Change the number immedietly after the = sign. Read the comments (anything wrote after #) before changing or you might break the game.

#standard balls multiplier
great = 1.75			# Increased to 1.75
ultra = 2.25			# Increased to 2.25

#safari multiplier
safari = 2				# Catch rate of safari ball. Standard is 1x to 1.5x

#heal balls
heal = 1.25				# Catchrate of healball


#premier
premier = 1.1 			# This is the multiplier.
premierflat = 16.2 		# This is the additive catch rate. This makes the ball good against legendaries.

# EXPLANATION OF PREMIERBALL
# --------------------------
# Now with these stats, premierball is increased from x1 to (x1.1 + 19.7)
# If we used mewtwo as an example with a catchrate of 3 (like most legendaries):
# It's 3 x 1.1 + 16.2 = 19.5.
# this is essentially 5.5x catch rate, making premier ball the best ball in this situation.
# --------------------------

#netball
net = 4					# Catchrate of water+bug pokemon

#diveball
dive = 4				# Catchrate of undersea pokemon

#nestball
nestmaxlevel = 50 		# This determines what level the nest ball works below. So under level 45 nestball has increased catchrate.
nestconstant = 80 		# This is a constant to work out the catch rate. Higher = higher catch rate. range is 50-120
nestdivider = 14   		# (80 - pokemon level) / divider = catch rate. don't touch it if you don't understand.

#repeatball
repeat = 5				# The catchrate after 5 pokemon caught.

#timerball
timermultiplier = 0.2	# added catch rate per round
timerconstant = 2 	# Starting catch rate
#catchrate 6 after 20 turns
#catchrate 5 after 15 turns. 
#catchrate 4 after 10 turns
#catchrate 3 after 5 turns

#quickball
quickball = 6
#6 catchrate on first turn

#duskball
dusk = 4.5

#fastball
speedbase = 3 			# NOT catchrate. This is a multiplier for speed categories. Don't change it by much.

heavyball = 10			# NOT catchrate. This is a multiplier for heavy categories. Don't change it by much.

#levelball
levelballmultiplier = 2	# NOT catchrate. This is a multiplier for level categories. Don't change it by much.

#loveball
lovecatch = 8			# Catchrate multiplier for love balls. Your pokemon have a chance to be gay. Only certain pokemon are gay. They are gay every time they catch.


 




BallHandlers::ModifyCatchRate.add(:GREATBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  next catchRate*great
})

BallHandlers::ModifyCatchRate.add(:ULTRABALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  next catchRate*ultra
})

BallHandlers::ModifyCatchRate.add(:HEALBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  next catchRate*heal
})

BallHandlers::ModifyCatchRate.add(:SAFARIBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  next catchRate*safari
})

BallHandlers::ModifyCatchRate.add(:PREMIERBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  next catchrate*premier+premierflat
})

BallHandlers::ModifyCatchRate.add(:NETBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  multiplier = net
  catchRate *= multiplier if battler.pbHasType?(:BUG) || battler.pbHasType?(:WATER)
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:DIVEBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  catchRate *= dive if battle.environment == :Underwater
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:NESTBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  if battler.level <= nestmaxlevel
    catchRate *= [(nestconstant - battler.level) / nestdivider, 6].min
  end
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:REPEATBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  multiplier = repeat
  catchRate *= multiplier if battle.pbPlayer.owned?(battler.species)
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:TIMERBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  multiplier = [timerconstant + (timermultiplier * battle.turnCount), 6].min
  catchRate *= multiplier
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:DUSKBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  multiplier = dusk
  catchRate *= multiplier if battle.time==2
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:QUICKBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  catchRate *= quickball if battle.turnCount==0
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:FASTBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  baseStats = battler.pokemon.baseStats
  baseSpeed = baseStats[:SPEED]
  catchRate *= speedbase if baseSpeed >= 70
  catchRate *= speedbase * 1.2 if baseSpeed >= 80
  catchRate *= speedbase * 1.4 if baseSpeed >= 90
  catchRate *= speedbase * 1.7 if baseSpeed >= 100
  catchRate *= speedbase * 1.8 if baseSpeed >= 110
  catchRate *= speedbase * 1.9 if baseSpeed >= 120
  catchRate *= speedbase * 2 if baseSpeed >= 130
  catchRate *= speedbase * 3 if baseSpeed >= 140
  next [catchRate, 255].min
})

BallHandlers::ModifyCatchRate.add(:LEVELBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  maxlevel = 0
  battle.eachSameSideBattler do |b|
    maxlevel = b.level if b.level>maxlevel
  end
  if maxlevel>=battler.level*4;    catchRate *= (4 * levelballmultiplier)
  elsif maxlevel>=battler.level*2; catchRate *= (3 * levelballmultiplier)
  elsif maxlevel>=battler.level*2; catchRate *= (2 * levelballmultiplier)
  elsif maxlevel>battler.level;    catchRate *= levelballmultiplier
  end
  next [catchRate,255].min
})

BallHandlers::ModifyCatchRate.add(:LUREBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  multiplier = (Settings::NEW_POKE_BALL_CATCH_RATES) ? 5 : 3
  catchRate *= multiplier if GameData::EncounterType.get($PokemonTemp.encounterType).type == :fishing
  next [catchRate,255].min
})

BallHandlers::ModifyCatchRate.add(:HEAVYBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  next 0 if catchRate==0
  weight = battler.pbWeight
  if Settings::NEW_POKE_BALL_CATCH_RATES
    if weight>=3000;    catchRate += (heavyball * 4)
    elsif weight>=2000; catchRate += (heavyball * 3)
    elsif weight<1000;  catchRate += heavyball
    end
  else
    if weight>=4096;    catchRate += (heavyball * 5)
    elsif weight>=3072; catchRate += (heavyball * 4)
    elsif weight>=2048; catchRate += (heavyball * 3)
    else;               catchRate += heavyball
    end
  end
  catchRate = [catchRate,1].max
  next [catchRate,255].min
})

BallHandlers::ModifyCatchRate.add(:LOVEBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  battle.eachSameSideBattler do |b|
    next if b.species!=battler.species
    next if b.gender==2 || battler.gender==2
    next if b.gender==battler.gender && battler.pokemon.personalID % 10 != 0
	next if pbWeight % 1
    catchRate *= lovecatch
    break
  end
  next [catchRate,255].min
})




BallHandlers::ModifyCatchRate.add(:MOONBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  moon_stone = GameData::Item.try_get(:MOONSTONE)
  if moon_stone && battler.pokemon.species_data.family_item_evolutions_use_item?(moon_stone.id)
    catchRate *= 4
  end
  next [catchRate, 255].min
})

BallHandlers::ModifyCatchRate.add(:SPORTBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  next catchRate*1.5
})

BallHandlers::ModifyCatchRate.add(:DREAMBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  catchRate *= 4 if battler.status == :SLEEP
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:BEASTBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  if ultraBeast
    catchRate *= 5
  else
    catchRate /= 10
  end
  next catchRate
})

#GENDER BALL (24) - Changed gender
BallHandlers::OnCatch.add(:GENDERBALL,proc{|ball,battle,pokemon|
if pokemon.gender == 0 
  pokemon.makeFemale 
elsif  pokemon.gender == 1 
  pokemon.makeMale
end
})

#Boost ball for traded exp. Buffed to make legendaries a bit easier to catch
BallHandlers::ModifyCatchRate.add(:TRADEBALL,proc{|ball,catchRate,battle,pokemon|
  catchRate=(catchRate*0.8).floor(6)
next catchRate
})
BallHandlers::OnCatch.add(:TRADEBALL,proc{|ball,battle,pokemon|
  pokemon.obtain_method = 2
})

#Buffed from 0.6 of a pokeball to 0.8 of a pokeball. Added a floor of 9 so legendaries aren't impossible.
BallHandlers::ModifyCatchRate.add(:ABILITYBALL,proc{|ball,catchRate,battle,pokemon|
  catchRate=(catchRate*0.8)
next catchRate
})
BallHandlers::OnCatch.add(:ABILITYBALL,proc{|ball,battle,pokemon|
  species = getSpecies(dexNum(pokemon))
  pokemon.ability= species.hidden_abilities[-1]
})


#I made the ball much more likely to catch, but less likely to apply pokerus. 20% chance of pokerus.
BallHandlers::ModifyCatchRate.add(:VIRUSBALL,proc{|ball,catchRate,battle,pokemon|
  catchRate=(catchrate*10)+20
next catchRate
})


BallHandlers::OnCatch.add(:VIRUSBALL,proc{|ball,battle,pokemon|
  chance = rand(1..10)
  if chance <= 5
    pokemon.givePokerus
  end
})

#It doesn't actually make the pokemon shiny, so I rebalanced this to be 1.25 catchrate
BallHandlers::ModifyCatchRate.add(:SHINYBALL,proc{|ball,catchRate,battle,pokemon|
  catchRate=(catchRate*1.25).floor(1)
next catchRate
})
BallHandlers::OnCatch.add(:SHINYBALL,proc{|ball,battle,pokemon|
  pokemon.glitter=true
})

#perfect ball. Old catch rate 0.1 current catch rate 0.05 + 4. Buffed IVs.
BallHandlers::ModifyCatchRate.add(:PERFECTBALL,proc{|ball,catchRate,battle,pokemon|
  multiplier = (catchRate*0.05).floor(1) 
  catchRate = multiplier + 4
next catchRate
})
#Perfect ball is changed to be 1-5 IVs at near perfect instead of 1-2 perfect IVs
BallHandlers::OnCatch.add(:PERFECTBALL,proc{|ball,battle,pokemon|
  stats = [:ATTACK, :SPECIAL_ATTACK, :SPECIAL_DEFENSE, :SPEED, :DEFENSE, :HP]
  first = rand(5)
  second = rand(5)
  third = rand(5)
  fourth = rand(5)
  fifth = rand(5)
  pokemon.iv[stats[first]] = rand(20...31)
  pokemon.iv[stats[second]] = rand(20...31)
  pokemon.iv[stats[third]] = rand(20...31)
  pokemon.iv[stats[fourth]] = rand(20...31)
  pokemon.iv[stats[fifth]] = rand(20...31)  
})

#===============================================================================
# OnCatch
#===============================================================================
BallHandlers::OnCatch.add(:HEALBALL,proc { |ball,battle,pkmn|
  pkmn.heal
})

BallHandlers::OnCatch.add(:FRIENDBALL,proc { |ball,battle,pkmn|
  pkmn.happiness = 200
})
