-- These are the initialization of the global variables
debug = true
canSalt = true
saltTimerMax = .2
saltTimer = saltTimerMax
saltImg = nil
saltBalls = {}
-- A window table to store the properties of the game window itself
window = {width = love.graphics.getWidth(), height = love.graphics.getHeight()}
-- Our mollusc saviour, our lord, Snail Landa
snailLanda = {x = 0, y = 0, width = nil, height = nil, speed = 200, img = nil, direction = "left"}
-- Sprites for ach of the sides where he can throw salt balls
move = {up= 'assets/w-top.png', down= 'assets/w-down.png', left = 'assets/w-left.png', right= 'assets/w-right.png'}

-- This is the first function to run, this is where we load our assets
function love.load(arg)
  saltImg = love.graphics.newImage('assets/salt.png')
  snailLanda.img = love.graphics.newImage(move.left)
  snailLanda.width = snailLanda.img:getWidth()
  snailLanda.height = snailLanda.img:getHeight()
  snailLanda.x = (window.width/2) - (snailLanda.width/2)
  snailLanda.y = (window.height/2) - (snailLanda.height/2)
end

-- This function runs every frame, this is where we put all of our logic,
-- the function receives dt (delta time) as a parameter to ensure the
-- correct viewing of the game in every pc.
function love.update(dt)
  -- This is where we update the timer so our character
  -- can shoot only once in a while.
  saltTimer = saltTimer - (1 * dt)
  if saltTimer <0 then
    canSalt = true
  end

  -- This is where we update the position of the salt balls
  for i, ball in ipairs(saltBalls) do
    if ball.direction == "left" then
      ball.x = ball.x - (250 * dt)
      if ball.x < 0 then
        table.remove(saltBalls, i)
      end
    elseif ball.direction == "right" then
      ball.x = ball.x + (250 * dt)
      if ball.x > window.width then
        table.remove(saltBalls, i)
      end
    elseif ball.direction == "up" then
      ball.y = ball.y - (250 * dt)
      if ball.y < 0 then
        table.remove(saltBalls, i)
      end
    elseif ball.direction == "down" then
      ball.y = ball.y + (250 * dt)
      if ball.y > window.height then
        table.remove(saltBalls, i)
      end
    end
  end
  -- Here starts the key listeners for movement and interaction
  -- The esc key to close the game
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end
  -- The arrow and wasd keys to move the snail
  if love.keyboard.isDown('left', 'a') then
    snailLanda.img = love.graphics.newImage(move.left)
    if snailLanda.x > 0 then
      snailLanda.x = snailLanda.x - (snailLanda.speed*dt)
    end
    snailLanda.direction = "left"
  elseif love.keyboard.isDown('right', 'd') then
    snailLanda.img = love.graphics.newImage(move.right)
    if snailLanda.x < (window.width - snailLanda.width) then
      snailLanda.x = snailLanda.x + (snailLanda.speed*dt)
    end
    snailLanda.direction = "right"
  end
  if love.keyboard.isDown('up', 'w') then
    snailLanda.img = love.graphics.newImage(move.up)
    if snailLanda.y > 0 then
      snailLanda.y = snailLanda.y - (snailLanda.speed*dt)
    end
    snailLanda.direction = "up"
  elseif love.keyboard.isDown('down', 's') then
    snailLanda.img = love.graphics.newImage(move.down)
    if snailLanda.y < (window.height - snailLanda.height) then
      snailLanda.y = snailLanda.y + (snailLanda.speed*dt)
    end
    snailLanda.direction = "down"
  end
  -- The control and space key to shoot
  if love.keyboard.isDown(' ', 'rctrl', 'lctrl', 'ctrl') and canSalt then
    newSalt = {x = nil, y = nil, img = saltImg, direction = snailLanda.direction}
    if newSalt.direction == "up" then
      newSalt.x = snailLanda.x + (snailLanda.width/2) - (saltImg:getWidth()/2)
      newSalt.y = snailLanda.y - saltImg:getHeight()
    elseif newSalt.direction == "down" then
      newSalt.x = snailLanda.x + (snailLanda.width/2) - (saltImg:getWidth()/2)
      newSalt.y = snailLanda.y + snailLanda.height
    elseif newSalt.direction == "left" then
      newSalt.x = snailLanda.x - saltImg:getWidth()
      newSalt.y = snailLanda.y + (snailLanda.height/2) - (saltImg:getHeight()/2)
    elseif newSalt.direction == "right" then
      newSalt.x = snailLanda.x + snailLanda.width + saltImg:getWidth()
      newSalt.y = snailLanda.y + (snailLanda.height/2) - (saltImg:getHeight()/2)
    end
    table.insert(saltBalls, newSalt)
    canSalt = false
    saltTimer = saltTimerMax
  end
end

-- This function, just as love.update, runs every frame
-- drawing each element in its right position each time
function love.draw(dt)
  -- love.graphics.print("Landa width: " .. snailLanda.width/2, 400, 300)
  love.graphics.draw(snailLanda.img, snailLanda.x, snailLanda.y)
  -- This is where we draw each of the salt balls
  for i, salt in ipairs(saltBalls) do
    love.graphics.draw(salt.img, salt.x, salt.y)
  end
end