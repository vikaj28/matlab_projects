clc;
clear;
close all;
I=imread('nature.jpg');
G=rgb2gray(I);
subplot(321);imshow(G);title('original gray scale image');
H=imnoise(G,'salt & pepper');
subplot(322);imshow(H);title('noisy image');
H1=padarray(H,[1,1]);
[m n]=size(G);
mean=[1 1 1;1 1 1;1 1 1];
mean_k=mean/9;
a=imfilter(H,mean_k);
subplot(323);imshow(a);title('filtered image using inbuilt mean filter ');
b=medfilt2(H);
subplot(324);imshow(b);title('filtered image using inbuilt median filter');
x=zeros(size(H));
for i=2:m+1
 for j=2:n+1
 k=H1(i-1:i+1,j-1:j+1); 
 SUM = sum(k,'all');
 x(i-1,j-1)=SUM/9;
 end
end
x=uint8(x);
subplot(325);imshow(x);title("Mean filtered image");
y=zeros(size(H));
for i=2:m+1            
  for j=2:n+1
 k=H1(i-1:i+1,j-1:j+1); 
 med = median(k,'all');
 y(i-1,j-1)=med;
 end
end
y=uint8(y);
subplot(326);imshow(y);title("Median filtered image");