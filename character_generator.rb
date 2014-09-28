require 'pry'
#Creating a character generator. Probably going to just work based off of D&D or another rpg maybe ff tactics
#The game will have to have at least two arrays as part of its design, one to save all PCs and one for NPCs
class Game
	attr_accessor :characters
	def initialize
		@characters = [] #this is intended to give the player the ability to switch characters mid-game and play as that character
		@damage = 0
	end

	def damage_taken(attacker, defender)#take in the str of the attacker and the vit of the defender. damage shall be calculated by str - vit, if that is <= 0 the damage shall be 1. 
		if (attacker - defender) <= 0
			@damage += 1
		else
			@damage = @damage + (attacker - defender)
		end
		#This will be recorded in the same instance that It is called. 
	end

	def display_damage
		puts "Damage: " + @damage.to_s
	end

	def heal(base)#cleric exclusive right now.
		#I want it to heal for half of the magic stat
		@damage = @damage - base/2
	end
	#remember that the monster replaces itself everytime it is created. 
end
class Character < Game
	#attr_accessor :hp, :str, :ma, :vit, :dex, :res, :mp
	#I don't want them to be able to just set their stats according to their own whims
	def initialize(hp=1,mp=0,str=0,ma=0,dex=0,vit=0,res=0)#just literally sets up everything
		@hp = hp
		@mp = mp
		@str = str
		@ma = ma
		@dex = dex
		@vit = vit
		@res = res
		@job = "none"
		@lvl = 1
		@name = "random extra #386"
	end

	def random_stat_distribution#this is intended to allow the player to pick have a generic path where they don't specialize. I might just comment this section out though. 
		@str = 3+rand(1..10)
		@vit = 3+rand(1..10)
		@hp = (@str/2 + 2*@vit + 10)
		@ma = 3+rand(1..10)
		@res = 3+rand(1..10)
		@mp = (@ma/2 + 2*@res + 5)
		@dex = 3+rand(1..10)
	end

	def stat_dist_class_archtype(archtype)
		if archtype == "wizard"
			wizard_archtype
		elsif archtype == "cleric"
			cleric_archtype
		elsif archtype == "fighter"
			fighter_archtype
		elsif archtype == "rogue"
			rogue_archtype
		elsif archtype == "paladin"
			paladin_archtype
		end
	end

	#the archtypes are here in character to make it easier for me to use it to change NPC's to run off the same archtypes if I get away from using a generic monster. 
	def wizard_archtype
		@str = 3+rand(1..5)
		@vit = 3+rand(1..7)
		@hp = (@str/2 + 2*@vit + 8)
		@ma = 3+rand(5..15)
		@res = 3+rand(5..17)
		@mp = (@ma/2 + 2*@res + 7)
		@dex = 3+rand(1..7)
		@job = "Wizard"
	end

	def fighter_archtype
		@str = 3+rand(5..15)
		@vit = 3+rand(3..12)
		@hp = (@str/2 + 2*@vit + 10)
		@ma = 3+rand(1..7)
		@res = 3+rand(1..8)
		@mp = (@ma/2 + 2*@res + 5)
		@dex = 3+rand(1..10)
		@job = "Fighter"
	end

	def rogue_archtype
		@str = 3+rand(3..10)
		@vit = 3+rand(1..8)
		@hp = (@str/2 + 2*@vit + 8)
		@ma = 3+rand(1..7)
		@res = 3+rand(1..8)
		@mp = (@ma/2 + 2*@res + 5)
		@dex = 3+rand(5..15)
		@job = "Rogue"
	end

	def cleric_archtype
		@str = 3+rand(3..10)
		@vit = 3+rand(1..8)
		@hp = (@str/2 + 2*@vit + 8)
		@ma = 3+rand(5..15)
		@res = 3+rand(5..17)
		@mp = (@ma/2 + 2*@res + 5)
		@dex = 3+rand(1..10)
		@job = "Cleric"
	end

	def paladin_archtype
		@str = 3+rand(3..12)
		@vit = 3+rand(5..15)
		@hp = (@str/2 + 2*@vit + 10)
		@ma = 3+rand(1..7)
		@res = 3+rand(1..8)
		@mp = (@ma/2 + 2*@res + 5)
		@dex = 3+rand(1..10)
		@job = "Paladin"
	end
end

class PlayerCharacter < Character

	def change_name
		puts "Enter your character name."
		@name = gets.chomp
	end

	def level_up
		if @job == "Paladin"
			@str = @str + rand(1..3)
			@vit = @vit + rand(2..3)
			@hp = @hp + rand(5..10)
			@ma = @ma + rand(0..2)
			@res = @res + rand(1..3)
			@mp = @mp + rand(1..5)
			@dex = @dex + rand(1..3)
		elsif @job == "Cleric"
			@str = @str + rand(1..3)
			@vit = @vit + rand(1..3)
			@hp = @hp + rand(5..7)
			@ma = @ma + rand(2..3)
			@res = @res + rand(2..3)
			@mp = @mp + rand(3..7)
			@dex = @dex + rand(1..3)
		elsif @job == "Rogue"
			@str = @str + rand(1..3)
			@vit = @vit + rand(1..3)
			@hp = @hp + rand(5..6)
			@ma = @ma + rand(0..2)
			@res = @res + rand(1..3)
			@mp = @mp + rand(1..5)
			@dex = @dex + rand(2..3)
		elsif @job == "Fighter"
			@str = @str + rand(2..3)
			@vit = @vit + rand(1..3)
			@hp = @hp + rand(5..10)
			@ma = @ma + rand(0..2)
			@res = @res + rand(1..3)
			@mp = @mp + rand(1..5)
			@dex = @dex + rand(1..3)
		elsif @job == "Wizard"
			@str = @str + rand(1..3)
			@vit = @vit + rand(1..3)
			@hp = @hp + rand(5..10)
			@ma = @ma + rand(2..3)
			@res = @res + rand(1..3)
			@mp = @mp + rand(3..7)
			@dex = @dex + rand(1..3)
		end
		@lvl += 1 #for the NPC's there lvl will be based upon the player level. Probably equal or 1 behind. For enemy lvls I'll probably just multiply the stat increase for 1 lvl by the number of levels the monster has risen above lvl 1. 
	end

	def show_stats
		puts @name
		puts "LVL: " + @lvl.to_s
		puts "Class: " + @job.to_s
		puts "HP: " + @hp.to_s
		puts "MP: " + @mp.to_s
		puts "Str: " + @str.to_s
		puts "Dex: " + @dex.to_s
		puts "Vit: " + @vit.to_s
		puts "Ma: " + @ma.to_s
		puts "Res: " + @res.to_s
	end

end

class NonPlayerCharacter < Character

	def choose_monster_name
		chooser = rand(1..3)
		if chooser == 1
			@name = "Goblin"
		elsif chooser == 2
			@name = "Dire Wolf"
		elsif chooser == 3
			@name = "Revenant"
		else
			@name = "Error"
		end
	end

	def adjust_monster_level(p_lvl)#intended formula is basically the original stat plus the difference in levels between lvl 1 monster and player times the random distribution I'm setting up for the monster lvl up. 
	#problem: The way this is written if I try to adjust the level of the monster after the first time the monster will get ridiculously strong unless the player is still lvl 2 or 1...
		random_stat_distribution #attempting to fix the above.
		@str = @str + (p_lvl - 1) * rand(1..3)
		@vit = @vit + (p_lvl - 1) * rand(1..3)
		@hp = @hp + (p_lvl - 1) * rand(5..10)
		@ma = @ma + (p_lvl - 1) * rand(0..1)
		@res = @res + (p_lvl - 1) * rand(1..3)
		@mp = @mp + (p_lvl - 1) * rand(1..5)
		@dex = @dex + (p_lvl - 1) * rand(1..3)
	end
end

play_again = true
game_1 = Game.new

while play_again
	puts "Welcome to Battle Arena Omega Triple Xtra Large. Here you get to battle your character against a monster. Good luck and have fun."

	puts "Do you want to create a new character?(y/n)"
	create = gets.chomp.downcase

	if create == "y"
		game_1.characters << PlayerCharacter.new
		game_1.characters[0].change_name
		puts "What class are you using? Paladin, Fighter, Rogue, Wizard or Cleric?"
		chosen_class  = gets.chomp.downcase
		game_1.characters[0].stat_dist_class_archtype(chosen_class)
	elsif create == "n"
		
	else
		puts "Error. You must input y or n to say yes or no."
	end

	puts "Do you want to play again?(y/n)"
	repeat = gets.chomp.downcase

	if repeat == "n"
		play_again = false
	elsif repeat == "y"
		play_again = true
	else
		puts "something has gone wrong"
		exit	
	end
end

#the code below is just for help testing, will be commented out in final version or in turned in version
# character_1 = PlayerCharacter.new
# character_1.paladin_archtype

# game_1 = Game.new
# game_1.characters << character_1

# monster_1 = NonPlayerCharacter.new

binding.pry