
require "card"
require "grabber"

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
  if #self.pileList > 0 then
    local currentTop = self.pileList[#self.pileList]
    currentTop.orient = CARD_ORIENTATION.FACE_DOWN
  end
  
  
  table.insert(self.pileList, card)
  self.topCard = card
  self.topCard.orient = CARD_ORIENTATION.FACE_UP
  
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

function PileClass:update()
  
  for _, card in ipairs(self.pileList) do 
      
      if card.state == CARD_STATE.GRABBED and card == self.topCard then
        local xPos = grabber.currentMousePos.x - 80
        local yPos = grabber.currentMousePos.y - 110
        card:setPosition(xPos, yPos)
        print("set card position")
      end
  end
  
  
end

function PileClass:isMouseOver(mouseX, mouseY) 
  return mouseX > self.x and mouseX < self.x + self.width and 
         mouseY > self.y and mouseY < self.y + self.height
end



