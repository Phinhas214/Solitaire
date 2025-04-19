
require "card"

PileClass = {}
local CARD_WIDTH = 80
local CARD_HEIGHT = 110

function PileClass:new(xPos, yPos, pileNum) 
  local pile = {}
  local metadata = {__index = PileClass}
  setmetatable(pile, metadata) 
  
  pile.topCard = nil
  pile.initialPileNum = pileNum
  pile.pileList = {}
  pile.x = xPos
  pile.y = yPos
  pile.width = CARD_WIDTH
  pile.height = CARD_HEIGHT
  
  return pile
end

function PileClass:push(card) 
  table.insert(self.pileList, card)
  self.topCard = card
  
  local index = #self.pileList
  card:setPosition(self.x, self.y + (index * 20))
end

function PileClass:pop(card)
  local removed = table.remove(self.pileList)
  self.topCard = self.pileList[#self.pileList]
  
  return removed
end

function PileClass:draw()
  for _, card in ipairs(self.pileList) do 
    card:draw()
  end
end

function PileClass:isMouseOver(mouseX, mouseY) 
  return mouseX > self.x and mouseX < self.x + self.width and 
         mouseY > self.y and mouseY < self.y + self.height
end



