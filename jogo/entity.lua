local Entity = Object.extend(Object)

function Entity.new(self,x , y, width, height, speed)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.speed = speed
	self.score = 0
	self.life = 100
	self.damage = 10
end
local List_Of_Bullets = {}
sound_of_bullet = love.audio.newSource("Assets/sounds/tiro_8bit.wav", "static")
sound_of_explosion = love.audio.newSource('Assets/sounds/explosao_8bit.wav', "static") 
function Entity.keypressed(self)
	local bullet = {x = self.x+self.width, y = self.y+self.height/2, width = 5, height = 5, speed = 300}
	table.insert(List_Of_Bullets, bullet)
end

function Entity.update( self, v, dt )
	-- Sistema de colisao com a Tela no eixo x
	if self.x <= 0 then
		self.x = self.x - self.x
	elseif self.x + self.width >= window_width  then
		self.x = window_width - self.width
	end
	-- sistema de colisao com a Tela no eixo y
	if self.y <= 0 then
		self.y = self.y - self.y
	elseif self.y + self.height >= window_height then
		self.y = window_height - self.height
	end
	-- atualiza e movimenta as 'balas'
	for i,v in ipairs( List_Of_Bullets ) do
		v.x = v.x + v.speed * dt
		-- Sistema de colisao com as 'balas'
		if v.x + v.width >= self.x and
			self.x + self.width >= v.x and
			v.y + v.height >= self.y and
			self.y + self.height >= v.y then 
				-- se player se colidir com  a bala perde 10 de vida
				self.life = self.life - self.damage
				-- remove da tabela List_Of_Bullets uma 'bala' bullet
				table.remove(List_Of_Bullets, i)
		end   
	end
		
	-- Sistema de Pontuação
	if self.life <= 0 then
			v.score = v.score + 1
	end
	-- Sistema de renascimento dos Jogadores
	if self.life <= 0 then
		sound_of_explosion:play()
		self.x = window_width / 2
		self.y = window_height / 2
		self.life = 100
	end

end

function Entity.draw( self )
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
	-- atualiza e desenha as 'balas'
	for i,v in ipairs( List_Of_Bullets ) do
		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle('fill', v.x, v.y, v.width, v.height)
	end
end
return Entity