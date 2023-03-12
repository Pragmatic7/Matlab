clear; close all; clc;
warning off
misfireThreshold = 20

I4 = imread('Missfire59C.jpg');
I4 = imrotate(I4,90);
crop4 = I4(1:500, 1:500, :);
AvgMissfire1 = mean(crop4(:))

I5 = imread('Missfire61A.jpg');
I5 = imrotate(I5,90);
crop5 = I5(1:500, 1:500, :);
AvgMissfire2 = mean(crop5(:))

I1 = imread('FairoaksA.jpg');
I1 = imrotate(I1,90);
% figure, imshow(I1,[])

I2 = imread('FairoaksB.jpg');
I2 = imrotate(I2,90);
% figure, imshow(I2,[])

I3 = imread('FairoaksC.jpg');
I3 = imrotate(I3,90);
% figure, imshow(I3,[])

% by default crop from top left corner
crop1 = I1(1:500, 1:500, :);
Avg1 = mean(crop1(:))

crop2 = I2(1:500, 1:500, :);
Avg2 = mean(crop2(:))

crop3 = I3(1:500, 1:500, :);
Avg3 = mean(crop3(:))

% Now check that crop is actually background
% Check if Avg1 > Avg2 and Avg3 > Avg2
if (Avg1 > Avg2 && Avg3 > Avg2)
    fprintf('\nTrue, crop ROI is on background. Continuing.\n')
else
    fprintf('\nFalse, crop ROI is NOT on background. Cropping different ROI.\n')
    % crop from top right corner
    crop1 = I1(end-500:end, end-500:end, :);
    Avg1 = mean(crop1(:))
    crop2 = I2(end-500:end, end-500:end, :);
    Avg2 = mean(crop2(:))
    crop3 = I3(end-500:end, end-500:end, :);
    Avg3 = mean(crop3(:))
    % check again
    if (Avg1 > Avg2 && Avg3 > Avg2)
        fprintf('\nTrue, crop ROI is on background. Continuing.\n')
    else
        fprintf('\nFalse, crop ROI is NOT on background.\n')
        fprintf('\nERROR! Misfire! Take photos again!\n')
    end
end

% Now check Avg1-3 against a threshold for misfire
if (Avg1 < misfireThreshold || Avg2 < misfireThreshold || Avg3 < misfireThreshold)
    fprintf('\nERROR! Misfire! Take photos again!\n')
else
    fprintf('\nTrue, NO missfire detected.\n');
end




