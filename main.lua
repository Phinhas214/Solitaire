-- Phineas Asmelash
-- CMPM 121 - Pickup
-- 4-11-25
io.stdout:setvbuf("no")

require "card"
require "grabber"
require "vector"
require "pile"

math.randomseed(os.time())

function love.load() 
  love.window.setMode(960, 640)
  love.graphics.setBackgroundColor(0, 0.7, 0.2, 1)
  
  grabber = GrabberClass:new()
  piles = {}
  cardTable = {}
  cardImages = {}
  backImage = {}
  
  --TODO: load card images
  local suits = {"clubs", "diamonds", "hearts", "spades"}
  
  for _, suit in ipairs(suits) do
    cardImages[suit] = {}
    
    for n=1, 13 do 
      local fileName = string.format("Cards/%s_%02d.png", suit, n)
      cardImages[suit][n] = love.graphics.newImage(fileName)
    end
  end
  
  backImage = love.graphics.newImage("Cards/back07.png")
  
  
  -- load all our cards
  for i=1, 13 do -- values 
    for _, suit in ipairs(suits) do -- suits (diamonds = 1) (hearts = 2) (spades = 3) (clubs = 4)
      table.insert(cardTable, CardClass:new(0, 0, i, suit))
    end
  end
  
  -- shuffle cards before placing them into piles
  shuffle() 
  
  makeTableuPiles()
  makeSuitPiles()
  makeDeckPile()
  
  
  

  
  
  
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
        if grabber.grabPos and card.state == CARD_STATE.MOUSE_OVER and card == pile.topCard then 
          card.state = CARD_STATE.GRABBED
          grabber.grabbedCard = card
          break
        end
      end
      
    end
  end
end


function love.draw()
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


function shuffle() 
  --Fisher Yates Shuffle (taken from Prof. Zac from class lecture)
  local cardCount = 52
	for i = 1, cardCount do
		local randIndex = math.random(cardCount)
    local temp = cardTable[randIndex]
    cardTable[randIndex] = cardTable[cardCount]
    cardTable[cardCount] = temp
    cardCount = cardCount - 1
	end
end


function makeTableuPiles()
  -- Tableau piles
  for i = 0, 6 do 
    local tableauPile = PileClass:new(80 + (i * 120), 300, i)
    table.insert(piles, tableauPile)
  end
  
  -- add cards to each pile
  for i, pile in ipairs(piles) do 
    for j = 1, i do 
      -- TODO: take from cardTable instead of creating new cards. 
      local card = CardClass:new(0, 0) --will handle position in pile class
      print(#cardTable)
      pile:push(table.remove(cardTable))
    end
  end
  
end


-- Suit piles (4) (where the goal it so fill those up)
function makeSuitPiles()
  -- Suit piles
  for i = 0, 3 do 
    local suitPile = PileClass:new(440 + (i * 120), 50, 1)
    table.insert(piles, suitPile)
  end
  
  -- add cards to each pile
  for i, pile in ipairs(piles) do 
    -- TODO: take from cardTable instead of creating new cards. 
    local card = CardClass:new(0, 0) --will handle position in pile class
    print(#cardTable)
    pile:push(table.remove(cardTable))
  end
end



-- A deck pile (where clicking on it draws three cards into the draw pile)
function makeDeckPile()
  -- deck piles

  local deckPile = PileClass:new(80, 50, 1)
  table.insert(piles, deckPile)

  
  -- add cards to each pile
  for i, pile in ipairs(piles) do 
    -- TODO: take from cardTable instead of creating new cards. 
    local card = CardClass:new(0, 0) --will handle position in pile class
    print(#cardTable)
    pile:push(table.remove(cardTable))
  end
end



