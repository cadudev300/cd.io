window_width= love.graphics.getWidth()
window_height= love.graphics.getHeight()
print(window_width, window_height)
function love.load()
	music = love.audio.newSource("Assets/sounds/musica_loop_8bit.wav", "stream")
	music:setLooping(true)
	music:setVolume(0.01)
	music:play()
	Object = require "classic"
	local Entity = require "entity"
	require "foods"
	-- Criando duas instancias da classe Entity
	player1 = Entity(0, 100, 50, 50, 200)
	player2 = Entity(750, 100, 50, 50, 200)
	-- criando 10 instancias para food
	list_of_Foods = {}
	for c=1,10 do
		food = Food(math.random(0, window_width), math.random(0, window_height))
		list_of_Foods[c] = food
		print(list_of_Foods[c])
	end
	joystickcount  =  love.joystick.getJoystickCount()
	print(joystickcount)
end

function love.keypressed(key, c)
	if key == 'q' then
		sound_of_bullet:play()
		player1.keypressed(player1, player2)
	elseif key == 'p' then
		
		player2.keypressed(player2, player1)
	end
end

function isButtonPressed(joystick, button)
	return joystick:isDown(button)
end

function love.joystickpressed( joystick, button )
	local joysticks = love.joystick.getJoysticks()
	
	if joystick == joysticks[1] and button == 6 then
		sound_of_bullet:play()
		player1.keypressed(player1, player2)
	end

	if joystick == joysticks[2] and button == 6 then
		sound_of_bullet:play()
		player1.keypressed(player2, player1)
	end
end

function love.update( dt )
	
	-- Movimento do Player 1 e Player2 com controle.
	-- cria uma lista Que Armazena os joysticks conectados.
	local joysticks = love.joystick.getJoysticks()
	-- se existir mais de 0 joysticks ao totoal da lista
	if #joysticks > 0 then
		-- Armazena o primeiro joystick a uma variavel local j
		j = joysticks[1]
		if isButtonPressed(j, 1) then
			-- Move o Player para cima
			player1.y = player1.y  - player1.speed * dt
		elseif isButtonPressed(j, 3) then
			-- Move o player1 para baixo
			player1.y = player1.y + player1.speed * dt
		end

		if isButtonPressed(j, 2) then
			-- Move o Player para direita
			player1.x = player1.x  + player1.speed * dt
		elseif isButtonPressed(j, 4) then
			-- Move o player1 para esquerda
			player1.x = player1.x - player1.speed * dt
		end

		if #joysticks > 1 then
			local j = joysticks[2]
			-- se o Botao 2 do joystick 2 for pressionado
			if isButtonPressed(j, 1) then
				-- Move o Player2 para cima
				player2.y = player2.y  - player2.speed * dt
			elseif isButtonPressed(j, 3) then
				-- Move o player2 para baixo
				player2.y = player2.y + player2.speed * dt
			end

			if isButtonPressed(j, 2) then
				-- Move o Player2 para direita
				player2.x = player2.x  + player2.speed * dt
			elseif isButtonPressed(j, 4) then
				-- Move o player2 para esquerda
				player2.x = player2.x - player2.speed * dt
			end
		end
	end

	-- Chamando metodo Update da instancia player1
	player1.update(player1, player2, dt)
	
	-- movimento do player 1 no teclado
	if love.keyboard.isDown('w') then
		player1.y = player1.y - player1.speed * dt
	elseif love.keyboard.isDown('s') then
		player1.y = player1.y + player1.speed * dt
	end

	if love.keyboard.isDown('a') then
		player1.x = player1.x - player1.speed * dt
	elseif love.keyboard.isDown('d') then
		player1.x = player1.x + player1.speed * dt
	end

	-- Chamando metodo update da instancia player2
	player2.update(player2, player1, dt)
	
	-- Movimento do player2
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

	-- Testa Colisao com Ambos os Jogadores
	for c=1, #list_of_Foods do
		list_of_Foods[c]:update(player1, dt)
	end

	for c=1, #list_of_Foods do
		list_of_Foods[c]:update(player2, dt)
	end

end

function love.draw()
	-- deifine cor amarela para o player
	love.graphics.setColor(255, 215, 0)
	-- Chamando metodo draw para o player 
	player1.draw(player1)
	-- deifine cor verde para o player2
	love.graphics.setColor(0, 255, 0)
	-- Chamando metodo draw para player2
	player2.draw(player2)
	
	love.graphics.setColor(0, 0, 20)
	for c=1,#list_of_Foods	do
		list_of_Foods[c]:draw()
	end
	
	-- UI player 1
	love.graphics.setColor(1, 1, 1)
	love.graphics.print('Player1: ')
	love.graphics.print('life : ' .. player1.life, 0, 20)
	love.graphics.print('score : ' .. player1.score, 0, 40)
	-- UI player2
	love.graphics.print('Player2: ', 750)
	love.graphics.print('life: ' .. player2.life, 740, 20)
	love.graphics.print('score: ' .. player2.score, 740, 40)

	-- Background Color
	love.graphics.setBackgroundColor(0, 0, 0.1)
end