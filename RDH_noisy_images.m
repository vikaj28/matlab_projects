clc;
clear;
close all;
I=imread('F:\courses\MTECH THESIS\fruits.jpg');
%subplot(321);imshow(I);title('RGB image');
R=imresize(I, [512 512]);
G=rgb2gray(I);
%subplot(321);
imshow(G);
title('original image');
g = imhist(G);
figure;
stem(0:255,g,'.');
title('histogram of original image');

H=imnoise(G,'salt & pepper');
%subplot(322);
figure;
imshow(H);
title('noisy image');

a=medfilt2(H);
%subplot(323);
%imshow(a);
%title('filtered image');

b=imhist(a);
%subplot(324);
%stem(0:255,b,'.');
%title('histogram of filtered image');

% to find peak & zero point
[r,c] = size(a);
Pmax = max (b);
Pmin = min (b);
disp(Pmax);
disp(Pmin);
for i = 1:256
    if b(i) == max(b)
        P = i-1;
    elseif b(i) == min (b)
        Z = i-1;
    end
 end

disp('the peak point is, P=');
disp(P);
disp('the zero point is, Z=');
disp(Z);

%histogram using logic for cross check
hist1=zeros(256,1);
for i=1:r
    for j=1:c
        for k=0:255
            if (a(i,j)==k)
                hist1(k+1)=hist1(k+1)+1;
            end
        end
    end
end

% histogram shifting by 2 units
e = zeros(r,c);
for i = 1:r
    for j = 1:c
            if (a(i,j) <= P)
                e(i,j) = a(i,j);
            else
                e(i,j) = a(i,j) + 2;
            end
    end
end

e=uint8(e);
%subplot(325);
%imshow(e);
%title('histogram shifted image');

f = imhist(e);
%subplot(326);
%stem(0:255,f,'.');
%title('shifted histogram ');

% random sequence of 0 and 1 
x = randi ( [0 1], Pmax, 1 );

% inserting 0 and 1 in the vacant space i.e., at (P+1) and (P+2)

g = zeros(r,c);
for i = 1:r
    for j = 1:c
        if (e(i,j) > P)
            k = 1:Pmax;
                if ( x(k)==0 )
                    g(i,j) = e(i,j)-2;
                   % k = k+1;
                else
                    g(i,j) = e(i,j)-1;
                   % k = k+1;
                end
        else
            g(i,j) = e(i,j);
        end
    end
end

disp('embedding done');
g=uint8(g);
figure;
%subplot(321);
imshow(g);
title('embedded image');

h = imhist(g);
%subplot(322);
figure;
stem(0:255,h,'.');
title('histogram of embedded image');

%extraction process, extract the cover image using extraction algorithm
disp('recovering started');
m = zeros(r,c);
for i = 1 : r
    for j = 1 : c
        if ( g(i,j) > P )
            k = 1 : Pmax;
            if ( x(k) == 0 )
                m (i,j) = g (i,j) + 2;
                k = k+1;
            else
                m (i,j) = g(i,j) + 1;
                k = k+1;
            end
        else
            m (i,j) = g (i,j);
        end
    end
end

 m = uint8(m);
 %subplot(323);
 %imshow(m);
 %title('histogram shifted image after embedding ');

 n = imhist(m);
 %subplot(324);
 %stem(0:255,n,'.');
 %title('shifted histogram after embedding');

 % shift the histogram left by 2 units to recover the host image

 p = zeros(r,c);
 for i = 1 : r
     for j = 1 : c
         if ( m(i,j) > P )
             p (i,j) = m(i,j) - 2;
         else
             p (i,j) = m(i,j);
         end
     end
 end

 p=uint8(p);
 %subplot(325);
 figure;
 imshow(p);
 title('extracted image');

 q = imhist(p);
 %subplot(326);
 figure;
 stem(0:255,q,'.');
 title('histogram of extracted image');

%mean square error

MSE = immse(p,G);
disp('MSE is');
disp(MSE);

% PSNR
PSNR = psnr(p,G);
disp('PSNR is');
disp(PSNR);

% ssim
SSIM = ssim(p,G);
disp('SSIM is');
disp(SSIM);

