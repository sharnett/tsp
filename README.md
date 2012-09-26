tsp
===

Travelling salesman problem solver.

cutting-plane method: http://www.tsp.gatech.edu/methods/dfj/index.html
min cut: http://code.activestate.com/recipes/576907-minimum-cut-solver/

I used the cutting-plane method (described pretty well above) using some Columbia CS dude's
code to find the mincuts, and gurobi to solve the integer program. 50ish lines of python
outside of those two subroutines, and blazingly fast for 20 cities, less than a tenth of
a second typically.