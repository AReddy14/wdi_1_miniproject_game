#Creating a character generator. Probably going to just work based off of D&D or another rpg maybe ff tactics
#The game will have to have at least two arrays as part of its design, one to save all PCs and one for NPCs
class Character
	#attr_accessor :hp, :str, :ma, :vit, :dex, :res, :mp
	#I don't want them to be able to just set their stats according to their own whims
	def initialize(hp=1,mp=0,str=0,ma=0,dex=0,vit=0,res=0)
		@hp = hp
		@mp = mp
		@str = str
		@ma = ma
		@dex = dex
		@vit = vit
		@res = res
	end

	def random_stat_distribution
		@str = 3+rand(1..10)
		@vit = 3+rand(1..10)
		@hp = (.5*@str + 2*@vit + 10).to_i
		@ma = 3+rand(1..10)
		@res = 3+rand(1..10)
		@mp = (.5*@ma + 2*@res + 5).to_i
		@dex = 3+rand(1..10)
	end

	def stat_dist_class_archtype(archtype)
		if archtype == "wizard"
			wizard_archtype
		else
			
		end
	end

	def wizard_archtype
		@str = 3+rand(1..5)
		@vit = 3+rand(1..7)
		@hp = (.5*str + 2*vit + 8)
		@ma = 3+rand(5..15)
		@res = 3+rand(5..17)
		@mp = (.5*ma + 2*res + 7)
		@dex = 3+rand(1..7)
	end

	def fighter_archtype
		@str = 3+rand(5..15)
		@vit = 3+rand(3..12)
		@hp = (.5*str + 2*vit + 10)
		@ma = 3+rand(1..7)
		@res = 3+rand(1..8)
		@mp = (.5*ma + 2*res + 5)
		@dex = 3+rand(1..10)
	end

	def rogue_archtype
		@str = 3+rand(3..10)
		@vit = 3+rand(1..8)
		@hp = (.5*str + 2*vit + 8)
		@ma = 3+rand(1..7)
		@res = 3+rand(1..8)
		@mp = (.5*ma + 2*res + 5)
		@dex = 3+rand(5..15)
	end

	def cleric_archtype
		@str = 3+rand(3..10)
		@vit = 3+rand(1..8)
		@hp = (.5*str + 2*vit + 8)
		@ma = 3+rand(5..15)
		@res = 3+rand(5..17)
		@mp = (.5*ma + 2*res + 5)
		@dex = 3+rand(1..10)
	end

	def paladin_archtype
		@str = 3+rand(3..12)
		@vit = 3+rand(5..15)
		@hp = (.5*str + 2*vit + 10)
		@ma = 3+rand(1..7)
		@res = 3+rand(1..8)
		@mp = (.5*ma + 2*res + 5)
		@dex = 3+rand(1..10)
	end

end