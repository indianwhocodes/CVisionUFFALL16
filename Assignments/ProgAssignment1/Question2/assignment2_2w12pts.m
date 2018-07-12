clc;
close all;
clear all;
%%

input=imread('Image.JPG');
inter2=Get2DPoints(input,12);
wcs2=[1 2 1 4 0 0 5 4 2 3 0 0;
      1 2 0 0 2 4 5 4 0 0 1 2;
      0 0 1 2 1 4 0 0 2 3 1 2];
%the selected 12 world coordinates in specified order are:(1,1,0),(2,2,0),(1,0,1),(4,0,2),(0,2,1),(0,4,4)%
%--------------------------------------------------------:(5,5,0),(4,4,0),(2,0,2),(3,0,3),(0,1,1),(0,2,2)%
CamMat2=getCameraMatrix(inter2,wcs2);
save CamMat2;
