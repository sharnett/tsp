import numpy as np
import gurobipy as grb
import scipy.io 
from itertools import product
from mincut import minimum_cut, UndirectedGraph

def makenodes(n, xscale=1.0, yscale=1.0, zscale=1.0):
    P = np.random.random((n,3))
    P[:,0] *= xscale
    P[:,1] *= yscale
    P[:,2] *= zscale
    D = np.zeros((n,n))
    for i in xrange(n):
        for j in xrange(i):
            D[i,j] = np.linalg.norm(P[i,:]-P[j,:])
    return P, D

# returns list of all arcs incident to node i
def pairs(i,n):
    return [(i,j) for j in range(i)] + [(j,i) for j in range(i+1,n)]

# returns list of all arcs crossing the cut S,T
def cross(S,T):
    crosslist = []
    for i,j in product(S,T):
        if i<j:
            crosslist += [(j,i)]
        else:
            crosslist += [(i,j)]
    return crosslist

def tsp(D):
    n = D.shape[0]
    m = grb.Model("tsp")
    x = {}
    for i in xrange(n):
        for j in xrange(i):
            x[i,j] = m.addVar(vtype='B', lb=0, ub=1, obj=D[i,j], name='x_%d%d'%(i,j))
    m.update()
    for i in xrange(n):
        m.addConstr(grb.quicksum(x[arc] for arc in pairs(i,n)) == 2, 'triv_%d'%i)
    mincutval, it = 0, 0
    while mincutval < 2:
        m.optimize()
        if m.status != grb.GRB.status.OPTIMAL:
            print 'bad status:', m.status
            return None
        candidate = [arc for arc,var in x.iteritems() if var.x > 0]
        g = UndirectedGraph()
        g.add_vertices(xrange(n))
        for edge in candidate:
            g.add_edge(*edge)
        S, T, mincutval = minimum_cut(g, 0)
        m.addConstr(grb.quicksum(x[arc] for arc in cross(S,T)) >= 2, 'cut_%d'%it)
        it += 1
        print it
    return candidate, m.objVal

def list2path(L):
    n = len(L)
    path = [0]
    while L:
        for i, arc in enumerate(L):
            if path[-1] in arc:
                if path[-1] == arc[0]:
                    path += [arc[1]]
                else:
                    path += [arc[0]]
                L.pop(i)
                break
    return path

def obj(path, D):
    n = D.shape[0]
    total = 0
    for k in range(n-1):
        i = path[k]-1
        j = path[k+1]-1
        total += D[i, j]
    total += D[path[n-1]-1, path[0]-1]
    return total

def loadmat(filename):
    mat = scipy.io.loadmat(filename)
    return mat['D'], mat['solution'][0]
