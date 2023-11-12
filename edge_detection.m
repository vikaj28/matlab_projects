clc;
clear;
close all;
I=imread('bird.jpg');
a=im2double(I);
subplot(321);imshow(I);title('Original Image');
G=rgb2gray(a);
G1=padarray(G,[1 1]);
subplot(322);imshow(G);title('Grayscale Image');
[m,n]=size(G1);
S_vr=[-1 0 1;-2 0 2;-1 0 1];
S_hr=[1 2 1;0 0 0;-1 -2 -1];
for i=1:m-2
for j=1:n-2
S_vr(i,j)=G1(i,j+2)+2*G1(i+1,j+2)+G1(i+2,j+2)-G1(i,j)-2*G1(i+1,j)-G1(i+2,j);
end
end
for i=1:m-2
for j=1:n-2
S_hr(i,j)=G1(i,j)+2*G1(i,j+1)+G1(i,j+2)-G1(i+2,j)-2*G1(i+2,j+1)-G1(i+2,j+2);
end
end
S=sqrt((S_vr.^2)+(S_hr.^2));
subplot(323);imshow(S);title('Edge Detection using Sobel Logic');
h1 = fspecial('sobel');
S1 = imfilter(G,h1);
subplot(324);imshow(S1);title('Using inbuilt func(Sobel)');
P_hr=[1 1 1;0 0 0;-1 -1 -1];
P_vr=[-1 0 1;-1 0 1;-1 0 1];
for i=1:m-2
for j=1:n-2
P_hr(i,j)=G1(i,j)+G1(i,j+1)+G1(i,j+2)-G1(i+2,j)-G1(i+2,j+1)-G1(i+2,j+2);
end
end
for i=1:m-2
for j=1:n-2
P_vr(i,j)=G1(i,j+2)+G1(i+1,j+2)+G1(i+2,j+2)-G1(i,j)-G1(i+1,j)-G1(i+2,j);
end
end
P=sqrt((P_hr.^2)+(P_vr.^2));
subplot(325);imshow(P);title('Edge Detection using Prewitt Logic');
h2 = fspecial('prewitt');
P1 = imfilter(G,h2);
subplot(326);imshow(P1);title('Using inbuilt func(Prewitt)');