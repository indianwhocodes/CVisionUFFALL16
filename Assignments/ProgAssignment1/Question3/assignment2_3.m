clc;
clear all;
close all;
%%
%For Input Image1 The following code is written %

input1=imread('s4_1.pgm');
input2=imread('s10_1-1.pgm');
fou1=fft2(input1);
magnitude1=abs(fou1);
sft1=log(1+fftshift(fou1));
phase1=angle(fou1);

r1=ifftshift(ifft2(magnitude1));
r2=ifft2(exp(1i*phase1));
figure,subplot(2,4,1);imshow(input1);title('Input Image 1');
subplot(2,4,2);imshow(sft1,[]);title('Fourier Transform');
subplot(2,4,3);imshow(uint8(r1));title('Magnitude Only');
subplot(2,4,4);imshow(r2,[]);title('Phase Only');

%%
%For Input Image2 The above code wriiten again %
fou2=fft2(input2);
magnitude2=abs(fou2);
sft2=log(1+fftshift(fou2));
phase2=angle(fou2);

r3=ifftshift(ifft2(magnitude2));
r4=ifft2(exp(1i*phase2));
subplot(2,4,5);imshow(input2);title('Input Image 2');
subplot(2,4,6);imshow(sft2,[]);title('Fourier Transform');
subplot(2,4,7);imshow(uint8(r3));title('Magnitude Only');
subplot(2,4,8);imshow(r4,[]);title('Phase Only');

%%
%Code for computing the composites%
figure;subplot(2,2,1);imshow(input1);title('Input Image 1');
xx1 = magnitude1.*exp(1i*phase2);
input3 = ifft2(xx1); 
input3=abs(input3);
subplot(2,2,2);imagesc(input3);colormap(gray);title('Composite of MagintudeA & PhaseB');
subplot(2,2,3);imshow(input2);title('Input Image 2');
xx2 = magnitude2.*exp(1i*phase1);
input4 = ifft2(xx2); 
input4=abs(input4);
subplot(2,2,4);imagesc(input4);colormap(gray);title('Composite of MagnitudeB & PhaseA');


%%