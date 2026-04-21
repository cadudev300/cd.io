player = {}
player.x = 0
player.y = 100
player.width = 50
player.height = 50
player.speed = 200
player.score = 0

player2 = {}
player2.x = 750
player2.y = 100
player2.width = 50
player2.height = 50
player2.speed = 200
player2.score = 0

food = {}
food.x = math.random(0, 500)
food.y = math.random(0, 250)
food.raio = 20
list_of_bullets = {}
list_of_bullets2 = {}

function love.load()
	love.window.setTitle('Pega-Pega')
	window_width = love.graphics.getWidth()
end
-- verifica se a tecla foi pressionada e atira
function love.keypressed(key)
	if key == 'space' then
		bullet = {
			x = player.x,
			y = player.y,
			width = 5,
			height = 5
		}
		table.insert(list_of_bullets, bullet)
	end

	if key == 'm' then
		bullet2 = {
			x = player2.x,
			y = player2.y,			
			width = 5,
			height = 5
		}
		table.insert(list_of_bullets2, bullet2)
	end
end

function love.update( dt )
	-- player um movimento
	if love.keyboard.isDown('w') then
		player.y = player.y - player.speed * dt
	elseif love.keyboard.isDown('s') then
		player.y = player.y + player.speed * dt
	end

	if love.keyboard.isDown('a') then
		player.x = player.x - player.speed * dt
	elseif love.keyboard.isDown('d') then
		player.x = player.x + player.speed * dt
	end

	-- player dois movimento
	if love.keyboard.isDown('up') then
		player2.y = player2.y - player2.speed * dt
	elseif love.keyboard.isDown('down') then
		player2.y = player2.y + player2.speed * dt
	end

	if love.keyboard.isDown('left') then
		player2.x = player2.x - player2.speed * dt
	elseif love.keyboard.isDown('right') then
		player2.x = player2.x + player2.speed * dt
	end
	-- player 1 colisao
	if player.x + player.width >= food.x and
		player.x < food.x + food.raio and
		player.y + player.height >= food.y and
		player.y <= food.y + food.raio then
			food.x = math.random(0, 500)
			food.y = math.random(0, 500)
			player.score = player.score + 1
			if(player.width <= 100) and (player.height <= 100) then
				player.width = player.width + 10
				player.height = player.height + 10
			end
	end

	-- player 2 colisao
	if player2.x + player2.width >= food.x and
		player2.x < food.x + food.raio and
		player2.y + player2.height >= food.y and
		player2.y <= food.y + food.raio then
			food.x = math.random(0, 500)
			food.y = math.random(0, 500)
			player2.score = player2.score + 1
			if(player2.width <= 100) and (player2.height <= 100) then
				player2.width = player2.width + 10
				player2.height = player2.height + 10
			end
	end

	-- movimento bullet player 1
	for i,v in ipairs(list_of_bullets) do
		if player.x < player2.x then	
			v.x = v.x + 10
		else
			v.x = v.x - 10
		end
		if v.x >= love.graphics.getWidth() then
			table.remove(list_of_bullets, i)
		elseif v.x <= 0 then
			table.remove(list_of_bullets, i)
		end
		if v.x + v.width >= player2.x and
			v.x <= player2.x + player2.width and
			v.y + v.height >= player2.y and
			v.y <= player2.y + player2.height and
			player2.score >= 0 then
				player2.width = player2.width - 10
				player2.height = player2.height - 10
				player2.score = player2.score - 1
				table.remove(list_of_bullets, i)
		end

	end
	-- movimento bullet player 2
	for i,v in ipairs(list_of_bullets2) do
		if player2.x < player.x then	
			v.x = v.x + 10
		else
			v.x = v.x - 10
		end
		if v.x >= love.graphics.getWidth() then
			table.remove(list_of_bullets2, i)
		elseif v.x <= 0 then
			table.remove(list_of_bullets2, i)
		end
		if v.x + v.width >= player.x and
			v.x <= player.x + player.width and
			v.y + v.height >= player.y and
			v.y <= player.y + player.height and
			player.score >= 0 then
				player.width = player.width - 10
				player.height = player.height - 10
				player.score = player.score - 1
				table.remove(list_of_bullets2, i)
		end
	end
end
function love.draw()
	love.graphics.setColor(255, 215, 0)
	love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
	love.graphics.setColor(0, 255, 0)
	love.graphics.rectangle('fill', player2.x, player2.y, player2.width, player2.height)
	love.graphics.setColor(0, 0, 255)
	love.graphics.circle('fill', food.x, food.y, food.raio)
	love.graphics.setColor(1, 1, 1)
	for i,v in ipairs(list_of_bullets) do
		love.graphics.rectangle('fill', v.x, v.y, v.width, v.height)
	end
	for i,v in ipairs(list_of_bullets2) do
		love.graphics.rectangle('fill', v.x, v.y, v.width, v.height)
	end
	love.graphics.print('Player Score: ' .. player.score)
	love.graphics.print('Player2 Score: ' .. player2.score, 0, 20)
	if player.width < 50 or player2.width < 50 then
		if player.width < player2.width then
			love.graphics.print('Player 2 Ganhou', 400, 300)
		else
			love.graphics.print('Player 1 Ganhou', 400, 300)
		end
	end
end
