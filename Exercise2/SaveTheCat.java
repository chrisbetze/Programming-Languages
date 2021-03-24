import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Stack;
import java.util.Queue;
import java.io.File;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;
import java.io.FileNotFoundException;
import java.util.NoSuchElementException;
import java.io.BufferedReader;
import java.io.FileReader;

public class SaveTheCat {
  static int MAXN=1000;
  static String[][] grid=new String[MAXN+2][MAXN+2];
  static int[][] depth=new int[MAXN+2][MAXN+2];
  static int[][] path=new int[MAXN+2][MAXN+2];
  static int M=0,N=0,x_start=0,y_start=0,maximum=-1;
  static String s=new String();

private static class node{
  int x=0;
  int y=0;
  int t=0;
  void setx(int a){x=a;}
  void sety(int a){y=a;}
  void sett(int a){t=a;}
  int getx(){return x;}
  int gety(){return y;}
  int gett(){return t;}	
}

static Queue<node> q1 = new LinkedList<node>();
static Queue<node> q2 = new LinkedList<node>();

public static int textCount(Scanner Scan1) {
  Scanner input = Scan1;
  int lines =0;
  int characters =0;
  int maxCharacters =0;
  String longestLine= "";
     
  while(input.hasNextLine()){
    String line = input.nextLine();
    lines++;
    characters+=line.length();
    if(maxCharacters<line.length()){
      maxCharacters = line.length();
      longestLine = line;
    }
  }
  return((characters / lines));
}

public static void main (String[] args) throws Exception {
  File infile = new File(args[0]);
  Scanner sc = new Scanner(infile);
  sc.useDelimiter("|\\n");
  M=0;
  N=0;
  BufferedReader reader = new BufferedReader(new FileReader(args[0]));
  int lines = 0;
  while (reader.readLine() != null) lines++;
  reader.close();
  N=lines;
  M=textCount(sc);
  int jj=0;

  sc = new Scanner(infile);
  sc.useDelimiter("|\\n");
  while(jj<N){
    for(int i=0; i<=M; i++){
      String c=sc.next();
      while(c==String.valueOf('\n')){c=sc.next();}
      grid[jj][i]=c;	
    }
    jj=jj+1;
  }
  
  for (int i=0; i<N; i++) {
    for(int j=0; j<M; j++) {				
      if(grid[i][j].equals(String.valueOf('W'))) {
        node p= new node();
	p.setx(i);
	p.sety(j);
	p.sett(0);
	q1.add(p);
	depth[i][j]=-1;
      }
      else {depth[i][j]=-1;}
      if(grid[i][j].equals(String.valueOf('A'))) {
        node p= new node();
	p.setx(i);
	p.sety(j);
	p.sett(0);
	q2.add(p);
	path[i][j]=-1;
	x_start=i;
	y_start=j;
      }
      else {path[i][j]=-1;}
    }
  }
  
  while (!q1.isEmpty()) {
    node p=q1.remove();
    int u=p.getx();
    int v=p.gety();
    int time=p.gett();
    if (depth[u][v]==-1) {
      if (u > 0 && !grid[ u-1 ][v] .equals( String.valueOf('X'))) {
        node pp= new node();
	pp.setx(u-1);
	pp.sety(v);
	pp.sett(time+1);
	q1.add(pp);
      }
      if (v > 0 && !grid[ u ][v-1] .equals( String.valueOf('X'))){
        node pp= new node();
	pp.setx(u);
	pp.sety(v-1);
	pp.sett(time+1);
	q1.add(pp);
      }
      if (u < N-1 && !grid[u+1] [v] .equals( String.valueOf('X'))){
        node pp= new node();
	pp.setx(u+1);
	pp.sety(v);
	pp.sett(time+1);
	q1.add(pp);
      }
      if (v < M-1 && !grid[u] [v+1] .equals( String.valueOf('X'))){
        node pp= new node();
	pp.setx(u);
	pp.sety(v+1);
	pp.sett(time+1);
	q1.add(pp);
      }
      depth[u][v]=time;
    }
  }
  int X=x_start;
  int Y=y_start;
  boolean infinity=false;
  if (depth[x_start][y_start]==-1) {infinity=true;}
  
  if (infinity==false){
    while (!q2.isEmpty()) {
      node p=q2.remove();
      int u=p.getx();
      int v=p.gety();
      int time=p.gett();
      if (path[u][v]==-1) {
        if (u > 0 && !grid[ u-1 ][v] .equals( String.valueOf('X'))) {
          node pp= new node();
    	  pp.setx(u-1);
	  pp.sety(v);
	  pp.sett(time+1);
	  q2.add(pp);
        }
        if (v > 0 && !grid[ u ][v-1] .equals( String.valueOf('X'))){
          node pp= new node();
  	  pp.setx(u);
	  pp.sety(v-1);
	  pp.sett(time+1);
	  q2.add(pp);
        }
        if (u < N-1 && !grid[u+1] [v] .equals( String.valueOf('X'))){
          node pp= new node();
	  pp.setx(u+1);
	  pp.sety(v);
	  pp.sett(time+1);
	  q2.add(pp);
        }
        if (v < M-1 && !grid[u] [v+1] .equals( String.valueOf('X'))){
          node pp= new node();
	  pp.setx(u);
	  pp.sety(v+1);
	  pp.sett(time+1);
	  q2.add(pp);
        }
        path[u][v]=time;
        if (maximum<depth[u][v]-1 && depth[u][v]>path[u][v]){
          maximum=depth[u][v]-1;
          X=u; 
          Y=v;
        }
        if (maximum==depth[u][v]-1 && depth[u][v]>path[u][v] && (u<X || v<Y)){
          maximum=depth[u][v]-1;
          X=u; 
          Y=v;
        }
      }
    }
  }
  else{
    while (!q2.isEmpty()) {
      node p=q2.remove();
      int u=p.getx();
      int v=p.gety();
      int time=p.gett();
      if (path[u][v]==-1) {
        if (u > 0 && !grid[ u-1 ][v] .equals( String.valueOf('X'))) {
          node pp= new node();
    	  pp.setx(u-1);
	  pp.sety(v);
	  pp.sett(time+1);
	  q2.add(pp);
        }
        if (v > 0 && !grid[ u ][v-1] .equals( String.valueOf('X'))){
          node pp= new node();
  	  pp.setx(u);
	  pp.sety(v-1);
	  pp.sett(time+1);
	  q2.add(pp);
        }
        if (u < N-1 && !grid[u+1] [v] .equals( String.valueOf('X'))){
          node pp= new node();
	  pp.setx(u+1);
	  pp.sety(v);
	  pp.sett(time+1);
	  q2.add(pp);
        }
        if (v < M-1 && !grid[u] [v+1] .equals( String.valueOf('X'))){
          node pp= new node();
	  pp.setx(u);
	  pp.sety(v+1);
	  pp.sett(time+1);
	  q2.add(pp);
        }
        path[u][v]=time;
        if (u<X || v<Y){
          maximum=path[u][v];
          X=u;
          Y=v;
        }
      }
    }
  }
  int u=X;
  int v=Y;
  
  for (int i=0; i<maximum; i++) {
    if (path[u][v]==0){break;}
    if (u < N-1 && !grid[u+1] [v] .equals( String.valueOf('X')) && path[u+1][v]==path[u][v]-1){ 
      s="U"+s;
      u=u+1; 
      v=v; 
      continue;
    }
    if (v > 0 && !grid[u] [v-1] .equals( String.valueOf('X')) && path[u][v-1]==path[u][v]-1){ 
      s="R"+s; 
      u=u; 
      v=v-1; 
      continue;
    }
    if (v < M-1 && !grid[u] [v+1] .equals( String.valueOf('X')) && path[u][v+1]==path[u][v]-1){
      s="L"+s; 
      u=u; 
      v=v+1; 
      continue;
    }
    if (u > 0 && !grid[u-1] [v] .equals( String.valueOf('X')) && path[u-1][v]==path[u][v]-1){ 
      s="D"+s; 
      u=u-1; 
      v=v; 
      continue;
    }
  }
  if (infinity==true){ System.out.println("infinity");}
  else{System.out.println(maximum);}
  
  if (X==x_start && Y==y_start){ System.out.println("stay");}
  else{ System.out.println(s);}
}
}
