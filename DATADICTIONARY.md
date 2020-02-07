The final dataset contains over 400 rows, each representing a single Pokémon, and 110 columns, each representing a characteristic of a Pokémon. The columns contain the following information.

* NumGal (numeric): ID number in the Galar Pokédex
* NumNat (numeric): ID number in the National Pokédex
* Name (character): Name of the Pokémon
* CanDynamax (logical): Whether the Pokémon can Dynamax
* CaptureRate (numeric): Capture rate of the Pokémon
* BaseEggSteps (numeric): Base number of steps required to hatch the Pokémon’s eggs
* PctM / PctF (numeric): Percentage (Pct) of males (M) and females (F) in the species. If the Pokémon is genderless, a value of 0 is given for both males and females.
* Height (numeric): Height of the Pokémon, in meters (m)
* Weight (numeric): Weight of the Pokémon, in kilograms (kg)
* Variant (character): Name of the Pokémon variant, if any. If not a variant, a value of “Normal” is given. Since some characteristics of variants differ from their non-variants, each variant is placed on its own row in the dataset.
* Type1 / Type2 (character): Primary type (Type1) and secondary type (Type2), if any, of the Pokémon. If no secondary type exists, a value of “None” is given for Type2.
* WkNorm:WkFairy (numeric): Weakness multipliers (damage taken by the Pokémon when attacked by a move of a given type) for all types (Normal, Fire, Water, Electric, Grass, Ice, Fighting, Poison, Ground, Flying, Psychic, Bug, Rock, Ghost, Dragon, Dark, Steel, Fairy)
* BaseTotal (numeric): Sum of the Pokémon’s base stats (hit points, attack, defense, special attack, special defense, speed)
* BaseHp:BaseSpd (numeric): Base stats (hit points = Hp, attack = Atk, defense = Def, special attack = SpAtk, special defense = SpDef, speed = Spd) of the Pokémon
* HinHpMin50:HinSpdMax50 (numeric): Mimimum (Min) or maximum (Max) value for the given stat (Hp, Atk, Def, SpAtk, SpDef, Spd) at level 50 with a hindering nature (Hin)
* HinHpMin100:HinSpdMax100 (numeric): Mimimum (Min) or maximum (Max) value for the given stat (Hp, Atk, Def, SpAtk, SpDef, Spd) at level 100 with a hindering nature (Hin)
* NeuHpMin50:NeuSpdMax50 (numeric): Mimimum (Min) or maximum (Max) value for the given stat (Hp, Atk, Def, SpAtk, SpDef, Spd) at level 50 with a neutral nature (Neu)
* NeuHpMin100:NeuSpdMax100 (numeric): Mimimum (Min) or maximum (Max) value for the given stat (Hp, Atk, Def, SpAtk, SpDef, Spd) at level 100 with a neutral nature (Neu)
* BenHpMin50:BenSpdMax50 (numeric): Mimimum (Min) or maximum (Max) value for the given stat (Hp, Atk, Def, SpAtk, SpDef, Spd) at level 50 with a beneficial nature (Ben)
* BenHpMin100:BenSpdMax100 (numeric): Mimimum (Min) or maximum (Max) value for the given stat (Hp, Atk, Def, SpAtk, SpDef, Spd) at level 100 with a beneficial nature (Ben)
