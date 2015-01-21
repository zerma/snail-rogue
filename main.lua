debug = true
window = {width = love.graphics.getWidth(), height = love.graphics.getHeight()}
snailLanda = {x = 0, y = 0, width = nil, height = nil, speed = 200, img = nil}
move = {up= 'assets/w-top.png', down= 'assets/w-down.png', left = 'assets/w-left.png', right= 'assets/w-right.png'}

function love.load(arg)
  snailLanda.img = love.graphics.newImage(move.left)
  snailLanda.width = snailLanda.img:getWidth()
  snailLanda.height = snailLanda.img:getHeight()
  snailLanda.x = (window.width/2) - (snailLanda.width/2)
  snailLanda.y = (window.height/2) - (snailLanda.height/2)
end

function love.update(dt)
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end
  if love.keyboard.isDown('left', 'a') then
    snailLanda.img = love.graphics.newImage(move.left)
    if snailLanda.x > 0 then
      snailLanda.x = snailLanda.x - (snailLanda.speed*dt)
    end
  elseif love.keyboard.isDown('right', 'd') then
    snailLanda.img = love.graphics.newImage(move.right)
    if snailLanda.x < (window.width - snailLanda.width) then
      snailLanda.x = snailLanda.x + (snailLanda.speed*dt)
    end
  end
  if love.keyboard.isDown('up', 'w') then
    snailLanda.img = love.graphics.newImage(move.up)
    if snailLanda.y > 0 then
      snailLanda.y = snailLanda.y - (snailLanda.speed*dt)
    end
  elseif love.keyboard.isDown('down', 's') then
    snailLanda.img = love.graphics.newImage(move.down)
    if snailLanda.y < (window.height - snailLanda.height) then
      snailLanda.y = snailLanda.y + (snailLanda.speed*dt)
    end
  end
end

function love.draw(dt)
  love.graphics.draw(snailLanda.img, snailLanda.x, snailLanda.y)
end