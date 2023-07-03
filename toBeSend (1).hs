type Cell = (Int,Int)
data MyState = Null | S Cell [Cell] String MyState deriving (Show,Eq)

up :: MyState -> MyState
up (S (0,_) _ _ _) = Null
up (S (x,y) t r w) = S (x-1,y) t "up" (S (x,y) t r w)

down :: MyState -> MyState
down (S (3,_) _ _ _) = Null
down (S (x,y) t r w) = S (x+1,y) t "down" (S (x,y) t r w)

left :: MyState -> MyState
left (S (_,0) _ _ _) = Null
left (S (x,y) t r w) = S (x,y-1) t "left" (S (x,y) t r w)

right :: MyState -> MyState
right (S (_,3) _ _ _) = Null
right (S (x,y) t r w) = S (x,y+1) t "right" (S (x,y) t r w)

delete :: Cell -> [Cell] -> [Cell]
delete _ [] = []
delete (x1,y1) ((x2,y2):t) = if x1==x2 && y1==y2 then t
				 else (x2,y2):(delete (x1,y1) t)

collect :: MyState -> MyState
collect (S (x,y) t r w) = if elem (x,y) t then (S (x,y) (delete(x,y) t) "collect" (S (x,y) t r w))
					      else Null

nextMyStateHelperUp (S (x,y) t r w) | up(S (x,y) t r w)/=Null && r/="down" && r/="right" = [up(S (x,y) t r w)]
									  |otherwise = []

nextMyStateHelperDown (S (x,y) t r w) | down(S (x,y) t r w)/=Null && r/="up" && r/="left" = [down(S (x,y) t r w)]
									  |otherwise = []
									 									  
nextMyStateHelperLeft (S (x,y) t r w) | left(S (x,y) t r w)/=Null && r/="right" && r/="up" = [left(S (x,y) t r w)]
									  |otherwise = []

nextMyStateHelperRight (S (x,y) t r w)| right(S (x,y) t r w)/=Null && r/="left" && r/="down"= [right(S (x,y) t r w)]
									  |otherwise = []

nextMyStateHelperCollect (S (x,y) t r w) | collect(S (x,y) t r w)/=Null = [collect(S (x,y) t r w)]
									  |otherwise = []

nextMyStates :: MyState -> [MyState]
nextMyStates (S (x,y) t r w) =(nextMyStateHelperUp (S (x,y) t r w))++
							  (nextMyStateHelperDown (S (x,y) t r w))++
							  (nextMyStateHelperLeft (S (x,y) t r w))++
							  (nextMyStateHelperRight (S (x,y) t r w))++
							  (nextMyStateHelperCollect (S (x,y) t r w))
							  
isGoal :: MyState -> Bool
isGoal Null = error "MyState = Null"
isGoal (S (x,y) t r w) = if t==[] then True
					     else False

search :: [MyState]->MyState
search ((S (x,y) t r w):tail) = if isGoal (S (x,y) t r w) then (S (x,y) t r w)
							  else search (tail++(nextMyStates (S (x,y) t r w)))

constructSolution :: MyState -> [String]
constructSolution (S (x,y) t "" Null) = []
constructSolution (S (x,y) t r w) = ((constructSolution w)++[r])

solve :: Cell -> [Cell] -> [String]
solve (x,y) q = constructSolution (search[(S (x,y) q "" Null)])