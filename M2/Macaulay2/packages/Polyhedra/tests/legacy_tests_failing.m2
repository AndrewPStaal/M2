






-- Test 13
-- Checking faces and minkSummandCone
TEST ///
P = convexHull matrix {{0,-1,1,0,0,1,-1},{0,0,0,1,-1,-1,1}};
verticesP = vertices P;
raysP = rays P;
linP = linealitySpace P;
F1 = faces(1,P);
F1 = apply(F1, f-> verticesP_(f#0));
F2 = {convexHull matrix{{-1,0},{1,1}},convexHull matrix{{0,1},{1,0}},convexHull matrix{{1,1},{0,-1}},convexHull matrix{{1,0},{-1,-1}},convexHull matrix{{0,-1},{-1,0}},convexHull matrix{{-1,-1},{0,1}}};
F2 = apply(F2, f->vertices f);
assert(set F1 === set F2)
(C,L,M) = minkSummandCone(P);
assert(rays(C)*M == matrix{{1_QQ,1},{1,1},{1,1},{1,1},{1,1},{1,1}})
L1 = {convexHull matrix{{0,1},{0,0}},convexHull matrix{{0,0},{0,1}},convexHull matrix{{0,1},{0,-1}},convexHull matrix{{0,0,1},{0,1,0}},convexHull matrix{{0,1,1},{0,0,-1}}};
L = apply(values L, l-> vertices l);
L1 = apply(L1, l-> vertices l);
assert(set L === set L1)
///



-- Test 32a
-- Checking isPolytopal, polytope
TEST ///
C = posHull matrix {{1,0,0},{0,1,0},{0,0,1}};
C1 = posHull matrix {{1,0,0},{0,-1,0},{0,0,1}};
C2 = posHull matrix {{-1,0,0},{0,1,0},{0,0,1}};
C3 = posHull matrix {{1,0,0},{0,1,0},{0,0,-1}};
F = fan {C,C1,C2,C3};
C = posHull matrix {{-1,0,0},{0,-1,0},{0,0,-1}};
C1 = posHull matrix {{-1,0,0},{0,1,0},{0,0,-1}};
C2 = posHull matrix {{1,0,0},{0,-1,0},{0,0,-1}};
C3 = posHull matrix {{-1,0,0},{0,-1,0},{0,0,1}};
F = addCone({C,C1,C2,C3},F);
assert(#(maxCones F) == 8)
assert isPure F
assert isComplete F
assert isSmooth F
assert isPolytopal F
assert(normalFan polytope F == F)
///



-- Test 40
-- Checking directProduct
TEST ///
P1 = convexHull matrix {{1,-1}};
P2 = convexHull matrix {{1,1,-1,-1},{1,-1,1,-1}};
P1 = directProduct(P1,P2);
P2 = convexHull matrix {{1,1,1,1,-1,-1,-1,-1},{1,1,-1,-1,1,1,-1,-1},{1,-1,1,-1,1,-1,1,-1}};
assert(P1 == P2)
C1 = posHull matrix {{1,2},{2,1}};
C2 = posHull matrix {{1,0},{0,1}};
C1 = directProduct(C1,C2);
C2 = posHull matrix {{1,2,0,0},{2,1,0,0},{0,0,1,0},{0,0,0,1}};
assert(C1 == C2)
F1 = normalFan hypercube 1;
F2 = normalFan hypercube 2;
F3 = normalFan hypercube 3;
assert(F3 == directProduct(F1,F2))
///


-- Test 55
-- Checking equality of polyhedral objects
TEST ///
L1 = set {posOrthant 3, hypercube 2, crossPolytope 4, hirzebruch 5};
L2 = set {hirzebruch 5, posOrthant 3, hypercube 2, crossPolytope 4};
assert(L1 === L2)
///


-- Test 59
-- Checking triangulate
TEST ///
P = crossPolytope 3;
L = triangulate P;
L = apply(L,convexHull);
L1 = {convexHull{matrix{{1},{0},{0}},matrix{{0},{1},{0}},matrix{{0},{0},{1}},matrix{{0},{0},{0}}},
     convexHull{matrix{{-1},{0},{0}},matrix{{0},{1},{0}},matrix{{0},{0},{1}},matrix{{0},{0},{0}}},
     convexHull{matrix{{1},{0},{0}},matrix{{0},{-1},{0}},matrix{{0},{0},{1}},matrix{{0},{0},{0}}},
     convexHull{matrix{{1},{0},{0}},matrix{{0},{1},{0}},matrix{{0},{0},{-1}},matrix{{0},{0},{0}}},
     convexHull{matrix{{-1},{0},{0}},matrix{{0},{-1},{0}},matrix{{0},{0},{1}},matrix{{0},{0},{0}}},
     convexHull{matrix{{-1},{0},{0}},matrix{{0},{1},{0}},matrix{{0},{0},{-1}},matrix{{0},{0},{0}}},
     convexHull{matrix{{1},{0},{0}},matrix{{0},{-1},{0}},matrix{{0},{0},{-1}},matrix{{0},{0},{0}}},
     convexHull{matrix{{-1},{0},{0}},matrix{{0},{-1},{0}},matrix{{0},{0},{-1}},matrix{{0},{0},{0}}}};
assert(set L === set L1)
///


-- Test 61
-- Checking incompCones
TEST ///
L = {posHull matrix{{1,0},{1,1}},posHull matrix{{1,0},{0,-1}},posHull matrix{{-1,0},{0,1}},posHull matrix{{1,1},{0,1}},posHull matrix {{1,2},{2,1}}};
assert(set incompCones L === set {(L#0,L#4),(L#3,L#4)})
L = L_{0..3}|{hirzebruch 3};
assert(incompCones L == {(L#0,L#4),(L#2,L#4),(L#3,L#4)})
desired = {(L#2,posHull matrix {{0,-1},{1,3}}),(L#2,posHull matrix {{0,-1},{-1,3}})};
computed = incompCones(L#2,L#4);
assert(sort computed == sort desired)
L = {posHull matrix {{-1,0},{0,1}},posHull matrix {{-1,0},{0,-1}},posHull matrix {{0,-1},{-1,3}},posHull matrix {{0,-1},{1,3}}};
L = {(L#0,L#2),(L#0,L#3),(L#1,L#2)};
assert(set incompCones(normalFan hypercube 2,hirzebruch 3) === set L)
///

-- Test 62
-- Checking isNormal for Cones
TEST ///
P = convexHull transpose matrix {{0,0,0},{1,0,0},{0,1,0},{1,1,3}};
Q = hypercube 2;
assert not isNormal P
assert isNormal Q
///

-- Test 63
-- Checking sublatticeBasis and toSublattice
TEST ///

-- new answer:
assert((sublatticeBasis matrix{{2,4,2,4},{1,2,2,3}}) === matrix({{2, 4}, {2, 3}}) );
-- assert(sublatticeBasis matrix{{2,4,2,4},{1,2,2,3}} == matrix {{2,2},{1,2}})

-- new answer:
assert( (sublatticeBasis convexHull matrix {{1,2,2},{0,-1,2}}) === map(ZZ^2,ZZ^2,{{0, 1}, {-1, 2}}) );
-- assert(sublatticeBasis convexHull matrix {{1,2,2},{0,-1,2}} == matrix {{-1,1},{1,0}})

assert(toSublattice convexHull matrix {{2,0},{0,3}} == convexHull matrix {{0,1}})
///


