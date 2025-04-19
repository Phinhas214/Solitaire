
require "vector"
require "grabber"

CardClass = {}
CARD_STATE = {
  IDLE = 0,
  MOUSE_OVER = 1,
  GRABBED = 2
}
CARD_ORIENTATION = {
  FACE_UP = 0,
  FACE_DOWN = 1
}

function CardClass:new(xPos, yPos)
  local card = {}
  local metadata = {__index = CardClass}
  setmetatable(card, metadata)
  
  card.position = Vector(xPos, yPos)
  card.size = Vector(80, 110)
  card.state = CARD_STATE.IDLE 
  card.orient = CARD_ORIENTATION.FACE_DOWN
  
  return card
end

function CardClass:update()
  return
end

function CardClass:draw()
  love.graphics.setColor(1, 1, 1, 1)
  if self.orient == CARD_ORIENTATION.FACE_UP then
    love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)
  else
    love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)
  end
  love.graphics.print(tostring(self.state), self.position.x + 20, self.position.y - 20)
end

function CardClass:checkForMouseOver(grabber)
  if self.state == CARD_STATE.GRABBED then
    return
  end
  
  local mousePos = grabber.currentMousePos
  local isMouseOver = 
    mousePos.x > self.position.x and 
    mousePos.x < self.position.x + self.size.x and 
    mousePos.y > self.position.y and 
    mousePos.y < self.position.y + self.size.y
  
  -- set the state to Mouse_OVER if it is, otherwise set it to IDLE
  self.state = isMouseOver and CARD_STATE.MOUSE_OVER or CARD_STATE.IDLE 
  
  
end


function CardClass:setPosition(xPos, yPos)
  self.position = Vector(xPos, yPos)
end



