clc;
close all;
clear all;
%%
input=imread('Image.JPG');
inter4=Get2DPoints(input,9);
%the marked test points are stated below%
wcs4=[4 3 2 1 0 0 0 0 0;
      3 3 3 3 3 3 3 3 3;
      0 0 0 0 0 1 2 3 4
      1 1 1 1 1 1 1 1 1];
load CamMat3;%Camera Matrix obtained from 18 points of corresspondences%
load CamMat2;%Camera Matrix obtained from 12 points of corresspondences%
load CamMat1;%Camera Matrix obtained from 6 points of corresspondences%
hprime3=CamMat3*wcs4;
hprime2=CamMat2*wcs4;
hprime1=CamMat1*wcs4;
%Part taken for 18 points of corresspondences%
%%
cs4=hprime3(1:2,:);
h3(1,:)=hprime3(3,:);
h3(2,:)=hprime3(3,:);
cs4=cs4./h3;
nx1=cs4(1,:);ny1=cs4(2,:);
ox1=inter4(1,:);oy1=inter4(2,:);
PE3=sqrt((ox1-nx1).^2+(oy1-ny1).^2);
PE3=mean2(PE3);%this is projection error value for 18 points of corresspondences%
save PE3;
%Part taken for 12 points of corresspondences%
%%
cs4=hprime2(1:2,:);
h3(1,:)=hprime2(3,:);
h3(2,:)=hprime2(3,:);
cs4=cs4./h3;
nx1=cs4(1,:);ny1=cs4(2,:);
ox1=inter4(1,:);oy1=inter4(2,:);
PE2=sqrt((ox1-nx1).^2+(oy1-ny1).^2);
PE2=mean2(PE2);%this is projection error value for 12 points of corresspondences%
save PE2;
%Part taken for 6 points of corresspondences%
%%
cs4=hprime1(1:2,:);
h3(1,:)=hprime1(3,:);
h3(2,:)=hprime1(3,:);
cs4=cs4./h3;
nx1=cs4(1,:);ny1=cs4(2,:);
ox1=inter4(1,:);oy1=inter4(2,:);
PE1=sqrt((ox1-nx1).^2+(oy1-ny1).^2);
PE1=mean2(PE1);%this is projection error value for 6 points of corresspondences%
save PE1;
%%
%Obtained decreasing values i.e PE1>PE2>PE3 since 1.3804>1.0752>0.7410%
%Precise Order to execute code: first execute codes with 6,12 and 18 pts and then execute this code%
[Q1,R1]=qr(CamMat3(:,1:3));
R1=R1./R1(3,3);
%Intrinsic Camera Parameters obtained by the upper triangular matrix after rq decomposition user defined function%
alphax=R1(1,1);alphay=R1(2,2);s=R1(1,2);tx=R1(1,3);ty=R1(2,3);
%Extrinsic Parameters namely the rotation matrix and the translation vector we have in matrix q1%
RotationMatrix=Q1(1:2,1:2);
TranslationVector=Q1(1:2,3);
ProjectiveVector=q1(3,1:2);


























  