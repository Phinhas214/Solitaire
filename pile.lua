
require "card"

PileClass = {}

function PileClass:new(xPos, yPos, pileNum) 
  local pile = {}
  local metadata = {__index = PileClass}
  setmetatable(pile, metadata) 
  
  pile.topCard = nil
  pile.initialPileNum = pileNum
  pile.pileList = {}
  pile.x = xPos
  pile.y = yPos
  pile.validWidth = nil
  pile.validHeight = nil
  
  return pile
end

function PileClass:push(card) 
  table.insert(self.pileList, card)
  self.topCard = card
  self.validWidth = {self.topCard.position.x, self.topCard.position.x + self.topCard.size.x}
  self.validheight = {self.topCard.position.y, self.topCard.position.y + self.topCard.size.y}
  
  local index = #self.pileList
  card:setPosition(self.x, self.y + (index * 20))
end

function PileClass:pop(card)
  local removed = table.remove(self.pileList)
  self.topCard = self.pileList[#pileList]
  return removed
end

function PileClass:draw()
  for _, card in ipairs(self.pileList) do 
    card:draw()
  end
end



---- draw pile 
--  for i = 80, 200, 120 do 
--    table.insert(cardTable, CardClass:new(i, 80))
--    -- table.insert(cardTable, CardClass:new(200, 100))
--  end
--  -- suit pile 
--  for i = 440, 900, 120 do 
--    table.insert(cardTable, CardClass:new(i, 80))
--    -- table.insert(cardTable, CardClass:new(200, 100))
--  end
--  -- tableau pile 
--  for i = 80, 900, 120 do 
--    table.insert(cardTable, CardClass:new(i, 300))
--    -- table.insert(cardTable, CardClass:new(200, 100))
--  end
