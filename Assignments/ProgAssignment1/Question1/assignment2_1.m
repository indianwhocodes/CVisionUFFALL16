clc;
close all;
clear all;
%%
input=imread('Wall.jpg');
intr1=Get2DPointsa1(input,4);
intr2=[71.1540,1968.1672,1962.360,73.089;
       891.2708,784.8694,514.773,552.969;
       1,1,1,1];
for ii=1:4
    intr1(3,ii)=1;%This has been done to make the coordinate system homogeneous%
end

HomoMat=imagehtransform(intr1,intr2);
himat=inv(HomoMat);
A=(HomoMat)';  %Input homography matrix in here
t=maketform('projective',A);
imOut=imtransform(input,t);%This produces the desired output we want%
figure;imshow(imOut);title('Output Image with perspective distortion removed');
%to generate two new perspectives from the original perspective with the same camera center%
A1=[.5 0 0; .5 2 0; 0 0 1];
t1=maketform('affine',A1);
imOut2=imtransform(imOut,t1);%Using a random affine matrix to play with the perspective to generate a new perspective%
A2=[1 0.33 0; .5 1 0; 0 0 1];
t2=maketform('affine',A2);
imOut3=imtransform(imOut,t2);%Applying a non-unifrom shear matrix to the perspective to generate a new perspective%
figure;subplot(1,2,1);imshow(imOut2);title('New Perspective1');
subplot(1,2,2);imshow(imOut3);title('New Perspective2');

%Apart from Applying a shear and an affine we can also rotate the perspective to generate a third new perspective%