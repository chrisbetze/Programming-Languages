#include <iostream>
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <string>
#include <climits>
using namespace std;
#define MAXN 1000
char map[MAXN + 2][MAXN + 2];
int flood_time[MAXN + 2][MAXN + 2];
int path_time[MAXN + 2][MAXN + 2];
using namespace std;

struct node{
    int data_x,data_y,data_t;
    node *next;
};

class queue{
private:
	node *front, *rear;
public:
	queue(){front=rear=NULL;}
	void enqueue(int x, int y, int t);
	bool dequeue();
	bool isEmpty();
	int datax();
	int datay();
	int datat();
	~queue();
};

void queue::enqueue(int x, int y, int t){
    node *temp=new node;
    temp->data_x=x;
    temp->data_y=y;
    temp->data_t=t;
    temp->next=NULL;
 
    if(front==NULL){
        front=rear=temp;
    }
    else{
        rear->next=temp;
        rear=temp;
    }
}

bool queue::dequeue() {
	if (front == NULL) {return false;}
	else{
		if(front==rear)
        		front=rear=NULL;
    		else
        		front=front->next;
		return true;
	}
}

bool queue::isEmpty() {
	if (front == NULL && rear == NULL) {
		return true;
	}
	else return false;
}

int queue::datax() {
	return front->data_x;
}

int queue::datay() {
	return front->data_y;
}

int queue::datat() {
	return front->data_t;
}

queue::~queue()
{
    while(front!=NULL)
    {
        node *temp=front;
        front=front->next;
        delete temp;
    }
    rear=NULL;
}

int main(int argc, char **argv) {

  FILE *myFile;
  char *input = NULL;
  queue q1, q2;
  myFile = fopen(argv[1], "r");

  size_t len = 0;
  ssize_t read;

  if (!myFile) return -1;

  int N=0, M=0, t=0, x_start=0, y_start=0, max=-1;
  bool infinity=false;
  std::string str;

  while ((read = getline(&input, &len, myFile)) != -1) {
    if (N == 0) M = strlen(input) - 1;
    N++;
    for (int j = 1; j <= M; j++) {
      if (map[N][j] == '\n') break;
      map[N][j] = input[j - 1];
      flood_time[N][j] = -1;
      path_time[N][j] = -1;
      if (map[N][j] == 'W') q1.enqueue(N, j, t);
      if (map[N][j] == 'A') {
         q2.enqueue(N, j, t);
         x_start=N;
         y_start=j;
      }
    }
  }
  int X=x_start,Y=y_start;
  
  while(q1.isEmpty()==false){
    int u=q1.datax(); 
    int v=q1.datay(); 
    int time=q1.datat();
    if (flood_time[u][v]==-1){
       if (u > 1 && map[u-1][v] != 'X') q1.enqueue(u-1, v, time+1);  //up
       if (v > 1 && map[u][v-1] != 'X') q1.enqueue(u, v-1, time+1);  //left
       if (u < N && map[u+1][v] != 'X') q1.enqueue(u+1, v, time+1);   //down
       if (v < M && map[u][v+1] != 'X') q1.enqueue(u, v+1, time+1);   //right
       flood_time[u][v]=time;
    }
    q1.dequeue();
  }
  
  if (flood_time[x_start][y_start]==-1) infinity=true;
  
  if (infinity==true) {
     while(q2.isEmpty()==false){
       int u=q2.datax(); 
       int v=q2.datay(); 
       int time=q2.datat();
       if (path_time[u][v]==-1) {
          if (v > 1 && map[ u ][v-1] != 'X') q2.enqueue(u, v-1, time+1);  //left
          if (u > 1 && map[ u-1 ][v] != 'X') q2.enqueue(u-1, v, time+1);  //up
          path_time[u][v]=time;
          if (max<=path_time[u][v]) {
             max=path_time[u][v];
             X=u; Y=v;
          }
          if (max==path_time[u][v] && (u<X || v<Y)) {
             max=path_time[u][v];
             X=u; Y=v;
          }
       }
       q2.dequeue();
    }
  }
  else {  
    while(q2.isEmpty()==false){
       int u=q2.datax(); 
       int v=q2.datay(); 
       int time=q2.datat();
       if (path_time[u][v]==-1) {
          if (u > 1 && map[u-1][v] != 'X') q2.enqueue(u-1, v, time+1);  //up
          if (v > 1 && map[u][v-1] != 'X') q2.enqueue(u, v-1, time+1);  //left
          if (u < N && map[u+1][v] != 'X') q2.enqueue(u+1, v, time+1);   //down
          if (v < M && map[u][v+1] != 'X') q2.enqueue(u, v+1, time+1);   //right
          path_time[u][v]=time;
          if (max<flood_time[u][v]-1 && flood_time[u][v]>path_time[u][v]){
             max=flood_time[u][v]-1;
             X=u; Y=v;
          }
          if (max==flood_time[u][v]-1 && flood_time[u][v]>path_time[u][v] && (u<X || v<Y)){
             max=flood_time[u][v]-1;
             X=u; Y=v;
          }
       }
       q2.dequeue();
    }
  }
  int u=X; int v=Y;
  for (int i = 1; i <= max; i++) {
    if (path_time[u][v]==0) break;
    if (u < N && map[u+1][v] != 'X' && path_time[u+1][v]==path_time[u][v]-1) {str="U"+str; u=u+1; v=v; continue;}
    if (v > 1 && map[u][v-1] != 'X' && path_time[u][v-1]==path_time[u][v]-1) {str="R"+str; u=u; v=v-1; continue;}
    if (v < M && map[u][v+1] != 'X' && path_time[u][v+1]==path_time[u][v]-1) {str="L"+str; u=u; v=v+1; continue;}
    if (u > 1 && map[u-1][v] != 'X' && path_time[u-1][v]==path_time[u][v]-1) {str="D"+str; u=u-1; v=v; continue;}
  }

  if (infinity==true) cout<<"infinity"<<endl;
  else cout<<max<<endl;
  
  if (X==x_start && Y==y_start) cout<<"stay"<<endl;
  else cout<<str<<endl;
}
