clc;
close all;
clear all;
%%

input=imread('Image.JPG');
inter1=Get2DPoints(input,6);
wcs1=[1 2 1 4 0 0;1 2 0 0 2 4;0 0 1 2 1 4];
%the selected 6 world coordinates in specified order are:(1,1,0),(2,2,0),(1,0,1),(4,0,2),(0,2,1),(0,4,4)%
CamMat1=getCameraMatrix(inter1,wcs1);
save CamMat1;
