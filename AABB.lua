-- Check Horizontal Collision
function HorCollision(x1, w1, x2, w2)
  return x1 < x2 + w2 and x2 < x1 + w1
end

-- Check Vertical Collision
function VerCollision(y1, h1, y2, h2)
  return y1 < y2 + h2 and y2 < y1 + h1
end


-- Axis Aligned Bounding Box Collisions
function AABB(x1, y1, w1, h1, x2, y2, w2, h2)
  -- Check if a collision happened (both horizontally or vertically)
  -- and save the result in "overlap" variable
  local overlap = HorCollision(x1, w1, x2, w2) and VerCollision(y1, h1, y2, h2)
  -- Variable to save the deltaSpace we need to reset the correct position
  local shiftX, shiftY

  -- Check if a collision happened from left to right or viceversa
  -- and save the compenetration amount in "shiftX" variable
  if(x1 + w1 * .5) < (x2 + w2 * .5) then
    shiftX = (x1 + w1) - x2
  else
    shiftX = x1 - (x2 + w2)
  end

  -- Check if a collision happened from top to bottom or viceversa
  -- and save the compenetration amount in "shiftX" variable
  if(y1 + h1 * .5) < (y2 + h2 * .5) then
    shiftY = (y1 + h1) - y2
  else
    shiftY = y1 - (y2 + h2)
  end

  return overlap, shiftX, shiftY
end
