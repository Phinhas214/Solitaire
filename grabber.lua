
require "vector"
--require "card"

GrabberClass = {}

function GrabberClass:new()
  local grabber = {}
  local metadata = {__index = GrabberClass}
  setmetatable(grabber, metadata)
  
  grabber.previousMousePos = nil
  grabber.currentMousePos = nil
  
  grabber.grabPos = nil
  grabber.grabbedCard = nil
  
  return grabber
end

function GrabberClass:update()
  self.currentMousePos = Vector(
    love.mouse.getX(),
    love.mouse.getY()
  )
  
  -- Click (just the first frame)
  if love.mouse.isDown(1) and self.grabPos == nil then
    self:grab()
  end
  -- Release
  if not love.mouse.isDown(1) and self.grabPos ~= nil then
    self:release()
  end
  
--  moveGrabbedCard()
  
end

function GrabberClass:grab()
  self.grabPos = self.currentMousePos
  print("GRAB - " .. tostring(self.grabPos))
end

function GrabberClass:release()
  print("RELEASE")
  self.previousMousePos = self.grabPos
  self.grabPos = nil
  self.grabbedCard = nil
end

--function moveGrabbedCard()
--  -- Relsease card when click is released
--  if not grabber.grabPos and grabber.grabbedCard then
    
--    grabber.grabbedCard.state = CARD_STATE.IDLE 
--    grabber.grabbedCard = nil 
--  -- if a card is grabbed move the card    
--  elseif grabber.grabbedCard then
--    -- center the card
--    local currXPos = grabber.currentMousePos.x - grabber.grabbedCard.size.x/2
--    local currYPos = grabber.currentMousePos.y - grabber.grabbedCard.size.y/2
--    grabber.grabbedCard:setPosition(currXPos, currYPos)
--  end
--end










