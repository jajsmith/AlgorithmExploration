#include <iostream>		//IO stream ops like cout/cin
#include <cmath>		//Math ops like sin/cos
#include <vector>		//A sequence like an Array that can change size
#include <algorithm>	//Fn's for ranges of elements like count/find/sort
#include <cstdio>		//Other IO ops like printf/scanf and file handling
using namespace std;

// Array Sum

int main() {
	int length;
	cin >> length;
	int sum = 0;
	for (int i = 0; i < length; i++) {
		int a;
		cin >> a;
		sum = sum + a;
	}
	cout << sum;
	
	return 0;
}
