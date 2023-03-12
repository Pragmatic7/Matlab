function HotPixlsAll = DetectDefectivePixelsFuncV4(ImagePath,Threshold)
% --- Function to look for defective pixels and columns in the image.

if exist('HotRows.txt')==2
   delete 'HotRows.txt' 
end

if exist('HotPixelsXY.txt') == 2
   delete 'HotPixelsXY.txt' 
end

if isempty (ImagePath)
        errordlg({'Please Select the black image first!'},'Error initialization');
end

warning off

Median_size = [3 3];% Neighborhood size of the median filter
Coloumn_Threshld = 15;% Threshold to separate a row from following row
Coloumn_Size = 100;% How many pixels in a row to consider bad row
% DECREASE this value to return MORE hot pixels
% ThreshMultiplyer= 15 seems to be matching with Dave's

% ThreshMultiplyer= 15;
ThreshMultiplyer = Threshold;

I= imread(ImagePath);
if  size(I,3) ~= 3
        errordlg({'Wrong Image! Please Select the correct color image!'},'Error chose wrong image');
        return 
end
% I= imrotate(I,-90);
I2= double(I);
IRed= I2(:,:,1);
IGreen= I2(:,:,2);
IBlue= I2(:,:,3);

% Now Median Filtering
IRedMed = medfilt2(IRed,Median_size);
IGreenMed = medfilt2(IGreen,Median_size);
IBlueMed = medfilt2(IBlue,Median_size);

IRedDiff=abs(IRed-IRedMed);
IGrrenDiff=abs(IGreen-IGreenMed);
IBlueDiff=abs(IBlue-IBlueMed);

ThresholdRed = ThreshMultiplyer*std2(IRedDiff)
ThresholdGreen = ThreshMultiplyer*std2(IGrrenDiff)
ThresholdBlue = ThreshMultiplyer*std2(IBlueDiff)

%find the hot pixels, but ignore the edges
[RowRed,ColRed] = find(IRedDiff>ThresholdRed);
[RowGreen,ColGreen] = find(IGrrenDiff>ThresholdGreen);
[RowBlue,ColBlue] = find(IBlueDiff>ThresholdBlue);
Num_Hot_Pixels_Red = size(RowRed,1)
Num_Hot_Pixels_Green = size(RowGreen,1)
Num_Hot_Pixels_Blue = size(RowBlue,1)

%find the union of colors
A= table([RowRed,ColRed]);
B= table([RowGreen,ColGreen]);
C = union(A,B);
D = table([RowBlue,ColBlue]);
E = union(C,D);

HotPixlsAll = table2array(E);cleanindex =[];
for i=1:size(HotPixlsAll,1)
        if isequal(HotPixlsAll(i,:),[1 1])||isequal(HotPixlsAll(i,:),[1 size(I,2)])...
           ||isequal(HotPixlsAll(i,:),[size(I,1) 1])...
           ||isequal(HotPixlsAll(i,:),[size(I,1) size(I,2)])
           cleanindex = [cleanindex i];
        end
end
HotPixlsAll(cleanindex,:)=[];
Num_Hot_Pixels_All = size(HotPixlsAll,1)

% Now Row/Coloumn finder
HotRows = [];
for i=2:size(I2,1)
    AnyRed = abs(I2(i,:,1)-I2(i-1,:,1)) > Coloumn_Threshld*ones(1,size(I2,2));
    AnyGreen = abs(I2(i,:,2)-I2(i-1,:,2)) > Coloumn_Threshld*ones(1,size(I2,2));
    AnyBlue = abs(I2(i,:,3)-I2(i-1,:,3)) > Coloumn_Threshld*ones(1,size(I2,2));
    if nnz(AnyRed)>Coloumn_Size ||nnz(AnyGreen)>Coloumn_Size ||nnz(AnyBlue)>Coloumn_Size
       HotRows = [HotRows; i];
    end
end
if ~isempty(HotRows)
    FalseIndx = [];
    for i=2:size(HotRows,1)
        if HotRows(i)-HotRows(i-1) == 1
            FalseIndx = [FalseIndx; i];
%             HotRows2(i) = [];
        end
    end
    HotRows(FalseIndx) = [];
end
% subtract -1 To make it match with Dave's numbering
if ~isempty(HotRows)
    for i=1:size(HotRows,1)
        HotRows(i) = HotRows(i) -1;
    end
end
HotRows
Num_Hot_Rows = length(HotRows)

% subtract -1 To make it match with Dave's numbering
if ~isempty(HotPixlsAll)
    fid = fopen( 'HotPixelsXY.txt', 'wt' );
    for i=1:size(HotPixlsAll(:,1),1)
        fprintf( fid, '%d %d\n',HotPixlsAll(i,2)-1,HotPixlsAll(i,1)-1);
    end
    fclose(fid);
end
if ~isempty(HotRows)
    fid = fopen( 'HotRows.txt', 'wt' );
    for i=1:size(HotRows,1)
        fprintf( fid, '%d \n',HotRows(i));
    end
    fclose(fid);
end

h = msgbox(sprintf('Operation Completed!\nNubmer of Defective pixels = %d\nNumber of Defective Rows = %d',Num_Hot_Pixels_All,Num_Hot_Rows));
% set(h, 'position', [600 600 320 120]); %makes box bigger
% ah = get( h, 'CurrentAxes' );
% ch = get( ah, 'Children' );
% set( ch, 'FontSize', 20 ); %makes text bigger
end


