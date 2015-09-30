#include <iostream>		//IO stream ops like cout/cin
#include <cmath>		//Math ops like sin/cos
#include <vector>		//A sequence like an Array that can change size
#include <algorithm>	//Fn's for ranges of elements like count/find/sort
#include <cstdio>		//Other IO ops like printf/scanf and file handling
using namespace std;

int add(int a, int b){
	return a+b;
}

int main() {
	int a,b;
	int sum;
	cin>>a>>b;
	sum = add(a,b);
	cout<<sum;
	return 0;
}
