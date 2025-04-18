-- Phineas Asmelash
-- CMPM 121 - Pickup
-- 4-11-25
io.stdout:setvbuf("no")

require "card"
require "grabber"
require "vector"

function love.load() 
  love.window.setMode(960, 640)
  love.graphics.setBackgroundColor(0, 0.7, 0.2, 1)
  
  grabber = GrabberClass:new()
  cardTable = {}
  
  table.insert(cardTable, CardClass:new(100, 100))
  table.insert(cardTable, CardClass:new(200, 100))
end


function love.update()
  grabber:update()
  -- if a card is grabbed move the card
  if grabber.grabbedCard then
      -- center the card
      grabber.grabbedCard.position = Vector(
        grabber.currentMousePos.x - grabber.grabbedCard.size.x/2, 
        grabber.currentMousePos.y - grabber.grabbedCard.size.x/2
      )
  end
  
  for _, card in ipairs(cardTable) do 
    -- check mouse movement and update card state
    local currentCard = checkForMouseMoving(card)
    -- if clicked (grabPos is not nil) and we're hovering over card ----> change state and set grabbedCard
    if grabber.grabPos and currentCard.state == CARD_STATE.MOUSE_OVER then
      currentCard.state = CARD_STATE.GRABBED
      grabber.grabbedCard = currentCard
      
    -- Relsease card when click is release
    elseif not grabber.grabPos and grabber.grabbedCard then
      grabber.grabbedCard.state = CARD_STATE.IDLE 
      grabber.grabbedCard = nil
    end
  end
  
  
  

end


function love.draw()
  for _, card in ipairs(cardTable) do 
    card:draw()
  end
  
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print("Mouse: " .. tostring(grabber.currentMousePos.x) .. ", " ..
    tostring(grabber.currentMousePos.y))
end


function checkForMouseMoving(card) 
  if grabber.currentMousePos == nil then
    return 
  end

  card:checkForMouseOver(grabber)
  
  return card
end