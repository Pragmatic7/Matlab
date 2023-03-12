clear; close all; clc;
warning off
GaussianSigma = 40;
tic
%% Read Image and LUT first
IBKG = imread('full.jpg');
IBKG = imrotate(IBKG,90);
figure, imshow(IBKG), title('Background image')
% export_fig 1BKG.png -m3 -transparent
ISUBJ = imread('img.jpg');
ISUBJ = imrotate(ISUBJ,90);
figure, imshow(ISUBJ), title('Subject')
% export_fig 2Subj.png -m3 -transparent
%% Read LUTs
filename = 'NikonD7000_sRGB_std_storedToLinear.lut';
delimiterIn = '\t';
headerlinesIn = 1;
A = importdata(filename,delimiterIn,headerlinesIn);
LUT = uint16(A.data(:,1)');

filename = 'invNikonD7000_sRGB_std_storedToLinear.lut';
delimiterIn = '\t';
headerlinesIn = 1;
A = importdata(filename,delimiterIn,headerlinesIn);
LUTInv = uint8(A.data(:,1)');
LUTInv = [LUTInv 255*ones(1,2^16-2^12)];

%% Convert to Gray scale image and linearize using LUT
Igray = rgb2gray(IBKG);
figure, imshow(Igray),title('Gray scale image')
Igraylinearized = LUT(double(Igray)+1);
% figure, imshow(Igraylinearized,[]),title('Linerized image')

%% Now Gaussian Blur
Iblur = imgaussfilt(Igraylinearized, GaussianSigma);
IblurInv = LUTInv(double(Iblur)+1);
figure, imshow(IblurInv),title('Gaussian Blured Image')

%% Now Gain image
double(Iblur(1207,1230))/double(Igraylinearized(1207,1230))
DustI = 128.*(double(Iblur)./double(Igraylinearized));
% figure, imshow(DustI,[]),title('Dust Map')

%% Save as 8 bit dustmap
DustI8 = uint8(DustI);
figure, imshow(DustI8),title('Dust Image')
%% Load original image and pixel wise multiply by dustmap, divide by 128, inverse linearize, and save.
% results should look like the orignal image without the dust.
IoR = ISUBJ(:,:,1);
IoG = ISUBJ(:,:,2);
IoB = ISUBJ(:,:,3);
IoRlinearized = LUT(double(IoR)+1);
IoGlinearized = LUT(double(IoG)+1);
IoBlinearized = LUT(double(IoB)+1);

% now multiply with dustmap  divide by 128
IoRD = uint16(double(IoRlinearized).*double(DustI8)./128);
IoGD = uint16(double(IoGlinearized).*double(DustI8)./128);
IoBD = uint16(double(IoBlinearized).*double(DustI8)./128);

% Now inverse LUT R G B to 8bit
IoRDInv = LUTInv(double(IoRD)+1);
IoGDInv = LUTInv(double(IoGD)+1);
IoBDInv = LUTInv(double(IoBD)+1);

Iout = cat(3,IoRDInv,IoGDInv,IoBDInv);
figure, imshow(Iout), title('Dust Removed')
export_fig img_DustRemoved.png -m3 -transparent

toc

