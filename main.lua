-- Phineas Asmelash
-- CMPM 121 - Pickup
-- 4-11-25
io.stdout:setvbuf("no")

require "card"
require "grabber"
require "vector"
require "pile"

function love.load() 
  love.window.setMode(960, 640)
  love.graphics.setBackgroundColor(0, 0.7, 0.2, 1)
  
  grabber = GrabberClass:new()
  cardTable = {}
  piles = {}
  
  -- Tableau piles
  for i = 0, 6 do 
    local pile = PileClass:new(80 + (i * 120), 300, i)
    table.insert(piles, pile)
  end
  
  -- add cards to each pile
  for i, pile in ipairs(piles) do 
    for j = 1, i do 
      local card = CardClass:new(0, 0) --will handle position in pile class
      pile:push(card)
    end
  end
  
  
  
end


function love.update()
  grabber:update()
  
  -- Relsease card when click is release
  if not grabber.grabPos and grabber.grabbedCard then
      grabber.grabbedCard.state = CARD_STATE.IDLE 
      grabber.grabbedCard = nil 
  -- if a card is grabbed move the card    
  elseif grabber.grabbedCard then
      -- center the card
      local currXPos = grabber.currentMousePos.x - grabber.grabbedCard.size.x/2
      local currYPos = grabber.currentMousePos.y - grabber.grabbedCard.size.y/2
      grabber.grabbedCard:setPosition(currXPos, currYPos)
  -- else update card state    
  else 
    for _, pile in ipairs(piles) do 
      for _, card in ipairs(pile.pileList) do
        -- check mouse movement and update card state
        checkForMouseMoving(card)
        -- if clicked (grabPos is not nil) and we're hovering over card 
        -- change state and set grabbedCard
        if grabber.grabPos and card.state == CARD_STATE.MOUSE_OVER then
          card.state = CARD_STATE.GRABBED
          grabber.grabbedCard = card
        end
      end
      
    end
  end
end


function love.draw()
--  for _, card in ipairs(cardTable) do 
--    card:draw()
--  end
  for _, pile in ipairs(piles) do 
    pile:draw()
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




