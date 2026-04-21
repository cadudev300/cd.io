window_width= love.graphics.getWidth()
window_height= love.graphics.getHeight()
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
end

function love.keypressed(key)
	if key == 'q' then
		sound_of_bullet:play()
		player1.keypressed(player1)
	elseif key == 'p' then
		sound_of_bullet:play()
		player2.keypressed(player2)
	end
end

function love.update( dt )
	--music:play()
	-- Chamando metodo Update para a  instancia player
	player1.update(player1, player2, dt)
	-- movimento do player 1
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

	-- Chamando metodo update para instancia player2
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
	
	love.graphics.setColor(0, 0, 255)
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

end