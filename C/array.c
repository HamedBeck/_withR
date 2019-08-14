#include<stdio.h>

int main(int argc, char *srgv[])
{	
	float v[10] ={2, 1.4, 34.2, 12.1, 1, 1, 18.04, 9.2};
	double sum =0;
	v[9] = 12;
	v[8] = 1.1;
	int sz = sizeof(v)/sizeof(float);
	printf("the size of v is %d\n", sz);
	for(int i=0; i < sizeof(v)/sizeof(float); i++){
		sum += v[i];
	}

	float avg = sum / 10;

	printf("average is %.2f\n", avg);

	return 0;	


}	





