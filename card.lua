
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

function CardClass:new(xPos, yPos, value, suit)  -- value == num, suit == string
  local card = {}
  local metadata = {__index = CardClass}
  setmetatable(card, metadata)
  
  card.position = Vector(xPos, yPos)
  card.value = value
  card.suit = suit
  
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
    love.graphics.draw(cardImages[self.suit][self.value], self.position.x, self.position.y, 0, 0.25, 0.25)
  else
    love.graphics.draw(backImage, self.position.x, self.position.y, 0, 0.25, 0.25)
  end
--  love.graphics.print(tostring(self.state), self.position.x + 20, self.position.y - 20)

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



