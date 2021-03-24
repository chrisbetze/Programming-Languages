import sys
from collections import deque
import gc

grid = []
depth = []
path = []

with open(sys.argv[1], 'r') as infile:
    grid = infile.readlines()

grid = [list(line.strip('\n')) for line in grid]
N, M = len(grid), len(grid[0])

q1=deque()
q2=deque()
t=0

for i in range(N):
  for j in range(M):
    depth[i][j]=-1
    path[i][j]=-1
    if grid[i][j]=='W':
      q1.append((i,j,t))
    elif grid[i][j]=='A':
      q2.append((i,j,t))
      x_start=i
      y_start=j

while q1:
  p = q1.popleft()
  u, v, time = p
  if (depth[u][v]==-1):
     if (u > 0 and grid[u-1][v] != 'X'): q1.append((u-1, v, time+1))  #up
     if (v > 0 and grid[u][v-1] != 'X'): q1.append((u, v-1, time+1))  #left
     if (u < N-1 and grid[u+1][v] != 'X'): q1.append((u+1, v, time+1))  #down
     if (v < M-1 and grid[u][v+1] != 'X'): q1.append((u, v+1, time+1))  #right
     depth[u][v]=time

maximum=-1
X=x_start
Y=y_start
infinity=0

if (depth[x_start][y_start]==-1): infinity=1

if infinity==0:
  while q2:
    p = q2.popleft()
    u, v, time = p
    if path[u][v]==-1:
      if (u > 0 and grid[u-1][v] != 'X'): q2.append((u-1, v, time+1))  #up
      if (v > 0 and grid[u][v-1] != 'X'): q2.append((u, v-1, time+1))  #left
      if (u < N-1 and grid[u+1][v] != 'X'): q2.append((u+1, v, time+1)) #down
      if (v < M-1 and grid[u][v+1] != 'X'): q2.append((u, v+1, time+1))  #right
      path[u][v]=time
      if (maximum<depth[u][v]-1 and depth[u][v]>path[u][v]):
        maximum=depth[u][v]-1
        X=u 
        Y=v
      if (maximum==depth[u][v]-1 and depth[u][v]>path[u][v] and (u<X or v<Y)):
        maximum=depth[u][v]-1
        X=u 
        Y=v
else:
  while q2:
    p = q2.popleft()
    u, v, time = p
    if path[u][v]==-1:
      if (v > 0 and grid[u][v-1] != 'X'): q2.append((u, v-1, time+1))  #left
      if (u > 0 and grid[u-1][v] != 'X'): q2.append((u-1, v, time+1))  #up
      if (u < N-1 and grid[u+1][v] != 'X'): q2.append((u+1, v, time+1)) #down
      if (v < M-1 and grid[u][v+1] != 'X'): q2.append((u, v+1, time+1))  #right
      path[u][v]=time
      if (u<X or v<Y):
        maximum=path[u][v]
        X=u
        Y=v
s=""
u=X
v=Y

gc.collect()
del depth

for i in range (maximum):
  if (path[u][v]==0): break
  if (u < N-1 and grid[u+1][v] != 'X' and path[u+1][v]==path[u][v]-1): 
    s = "U" + s
    u=u+1 
    v=v 
    continue
  if (v > 0 and grid[u][v-1] != 'X' and path[u][v-1]==path[u][v]-1): 
    s = "R" + s 
    u=u 
    v=v-1 
    continue
  if (v < M-1 and grid[u][v+1] != 'X' and path[u][v+1]==path[u][v]-1): 
    s="L"+s 
    u=u 
    v=v+1 
    continue
  if (u > 0 and grid[u-1][v] != 'X' and path[u-1][v]==path[u][v]-1): 
    s="D"+s 
    u=u-1 
    v=v 
    continue

if (infinity==1): print("infinity")
else: print(maximum)
  
if (X==x_start and Y==y_start): print("stay")
else: print(s)
