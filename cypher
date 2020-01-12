match (n)
detach delete n

USING PERIODIC COMMIT 100
LOAD CSV FROM "file:///event.csv" AS line
create (n:events{name:line[0],year:line[1],type:line[2]})

USING PERIODIC COMMIT 100
LOAD CSV FROM "file:///nation.csv" AS line
create (n:nations{name:line[0],politic:line[1],religion:line[2]})

USING PERIODIC COMMIT 100
LOAD CSV FROM "file:///story.csv" AS line
create (n:story{name:line[0],people:line[1],type:line[2]})

USING PERIODIC COMMIT 10
LOAD CSV FROM "file:///relationship.csv" AS line
MATCH (f:nations{name:line[0]}),(t:events{name:line[1]})
merge (f) - [r:takepart{type:line[2]}] -> (t)

USING PERIODIC COMMIT 10
LOAD CSV FROM "file:///relationship.csv" AS line
MATCH (f:story{name:line[0]}),(t:events{name:line[1]})
merge (f) - [r:takepart{type:line[2]}] -> (t)