# Static Bayesian Networks
library(bnlearn) 

#
# Creating and Manipulating Network Structures
data(marks)
str(marks)
summary(marks)
names(marks)

ug = empty.graph( names(marks))
print(ug)

m <- matrix(
	c("MECH", "VECT", "MECH", "ALG", "VECT", "MECH",  "VECT", "ALG", "ALG",
		"MECH", "ALG", "VECT",  "ALG", "ANL", "ALG", "STAT", "ANL", "ALG", "ANL",
		"STAT", "STAT", "ALG", "STAT", "ANL")
	, ncol=2
	, byrow=TRUE
	, dimnames=list(c(), c("from","to"))
)
print(m)

arcs( ug, ignore.cycles=TRUE) <- m
print(ug)


dag <- empty.graph( names( marks ) )
print(dag)

m <- matrix( 
	c("VECT", "MECH", "ALG", "MECH", "ALG", "VECT", "ANL", "ALG", "STAT", "ALG",
		"STAT", "ANL")
	, ncol=2
	, byrow=TRUE
	, dimnames=list( c(), c("from","to") )
)
print(m)

arcs( dag ) <- m 
print(dag)

# from adjacency matrix
mat <- matrix( 
	c(0,1,1,0,0,0,0,1,0,0,0,0,0,1,1,0,0,0,0,1,0,0,0,0,0)
	, nrow=5
	, dimnames=list(nodes(dag), nodes(dag))
)
print(mat) 

nodes( dag )

dag2 <- empty.graph( nodes(dag) )
amat(dag2) <- mat
print(dag2)

all.equal( dag, dag2)

# create new 'bn' object by modifying existing one
dag3 <- empty.graph(nodes(dag))
dag3 <- set.arc(dag3, "VECT", "MECH")
dag3 <- set.arc(dag3, "ALG", "MECH") 
dag3 <- set.arc(dag3, "ALG", "VECT") 
dag3 <- set.arc(dag3, "ANL", "ALG") 
dag3 <- set.arc(dag3, "STAT", "ALG") 
dag3 <- set.arc(dag3, "STAT", "ANL") 
all.equal(dag, dag3)

moral(dag)
all.equal( ug, moral(dag))

# topological ordering
node.ordering( dag )

# neighborhood
nbr( dag, "ANL" )

# markov blanket
mb( dag, "ANL")

"ANL" %in% mb( dag, "ALG" )

# markov blanket = children, parents, children's other parents
chld <- children( dag, "VECT" )
par <- parents( dag, "VECT" )
o.par <- sapply( chld, parents, x = dag)
unique( c(chld, par, o.par) )

# scoring
score( dag, data=marks, type="loglik-g")

dag.eq <- reverse.arc( dag, "STAT", "ANL" )
print(dag.eq)

score( dag.eq, data=marks, type="loglik-g")

vstructs(dag)
vstructs(dag.eq)


#
# Structure Learning 

# Grow-shrink 
bn.gs <- gs(marks)
print(bn.gs)

#
# Parameter fitting
fitted <- bn.fit( bn.gs, data=marks)
fitted$ALG

# discretizing by median split
dmarks <- discretize( marks, breaks=2, method="interval")
print(dmarks)
bn.dgs <- gs(dmarks)
bn.dhc <- hc(dmarks)
all.equal( cpdag( bn.dgs ), cpdag( bn.dhc ) )
