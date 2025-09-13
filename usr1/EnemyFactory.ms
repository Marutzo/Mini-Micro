EnemyFighter = { "Enemies": [] }

EnemyFighter.Create = function(shotStrength=1, cargo=null)
	e = new self
	e.shotStrength = shotStrength
	if not cargo isa list or cargo == null then cargo = []
	e.cargo = [] + cargo
	self.Enemies.push e
	return e
end function

EnemyFighter.onDestroy = function(self)
	print "Enemy Fighter destroyed: " + self.shotStrength + "; " + self.cargo
	EnemyFighter.Enemies.remove EnemyFighter.Enemies.indexOf(self)
end function

for i in range (0, 2)
	EnemyFighter.Create i+1, [i]
end for

while EnemyFighter.Enemies.len != 0
	EnemyFighter.Enemies[0].onDestroy
end while