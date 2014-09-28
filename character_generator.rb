require 'pry'
#Creating a character generator. Probably going to just work based off of D&D or another rpg maybe ff tactics
#The game will have to have at least two arrays as part of its design, one to save all PCs and one for NPCs
class Game
	def initialize
		@character_list = [] #this is intended to give the player the ability to switch characters mid-game and play as that character
	end
end
class Character
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
end

class NonPlayerCharacter < Character
	def initialize
		super()
		random_stat_distribution #decided to use this for generic monster stats; testing my understanding of inheritance too.
	end
	def adjust_monster_level(p_lvl)#intended formula is basically the original stat plus the difference in levels between lvl 1 monster and player times the random distribution I'm setting up for the monster lvl up. 
	#problem: The way this is written if I try to adjust the level of the monster after the first time the monster will get ridiculously strong unless the player is still lvl 2 or 1...
		@str = @str + (p_lvl - 1) * rand(1..3)
		@vit = @vit + (p_lvl - 1) * rand(1..3)
		@hp = @hp + (p_lvl - 1) * rand(5..10)
		@ma = @ma + (p_lvl - 1) * rand(2..3)
		@res = @res + (p_lvl - 1) * rand(1..3)
		@mp = @mp + (p_lvl - 1) * rand(3..7)
		@dex = @dex + (p_lvl - 1) * rand(1..3)
	end
end

#the code below is just for help testing, will be commented out in final version or in turned in version
character_1 = PlayerCharacter.new
character_1.paladin_archtype

monster_1 = NonPlayerCharacter.new

binding.pry