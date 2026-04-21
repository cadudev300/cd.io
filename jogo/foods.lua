Food = Object.extend(Object)

function Food.new(self, x , y)
	self.x = x
	self.y = y
	self.radius = 10
end 

function Food.update(self, v,  dt)
	if self.x + self.radius >= v.x and
		self.x <= v.x + v.width and
		self.y + self.radius >= v.y and
		self.y <= v.y + v.height then
			self.x = math.random(0, window_width)
			v.life = v.life + 1
			if v.width < 100 then	
				v.width = v.width + 1
				v.height = v.height + 1
			end
	end
end

-- Criando metodo Draw
function Food.draw(self)
	-- Desenhando na tela a comida
	love.graphics.circle('fill', self.x, self.y, self.radius)
end