function CheckExposureFunc(Folder,CamModel,ImageFormat,ImageType,BoxLocation,LowRGB,UpRGB)
% --- Function to check exposure of an image, pass/fail.
fprintf('Checking the exposure of the image\n');
if strcmp(ImageType,'Subject')
    if ImageFormat=='BMP'
        Direc = subdir([Folder, '\*.BMP']);
        name1 = {Direc.name};
        name11 = natsortfiles(name1);
        Num1 = length(Direc(not([Direc.isdir])))
    elseif ImageFormat=='JPG'
        errordlg({'Please only choose JPEG image folder for Calibration, and BMP for both Calibration and Subject!'},'Error initialization');
    end
elseif strcmp(ImageType,'Calibration')
    if ImageFormat=='BMP'
        Direc = subdir([Folder, '\*.BMP']);
        name1 = {Direc.name};
        name11 = natsortfiles(name1);
        Num1 = length(Direc(not([Direc.isdir])))
    elseif ImageFormat=='JPG'
        Direc = subdir([Folder, '\*.JPG']);
        name1 = {Direc.name};
        name11 = natsortfiles(name1);
        Num1 = length(Direc(not([Direc.isdir])))
    end
end

fid = fopen( 'CheckExposureResults.txt', 'wt' );
fprintf( fid, 'Image Name \t Camera Model \t Average Red \t Average Green \t Average Blue \t Status\n');
% fclose(fid);
        
for i=1:Num1
    i 
    name11{i}
    I=imread(name11{i});
    
    if ImageFormat=='JPG'
        I=imrotate(I,90);%Matlab roatets the images and messes up with the cropping!
    end
    
    Ired=I(:,:,1); Igreen=I(:,:,2); Iblue=I(:,:,3);
    Icroppedred=Ired(size(Ired,1)*BoxLocation(2):size(Ired,1)*BoxLocation(4),size(Ired,2)*BoxLocation(1):size(Ired,2)*BoxLocation(3));
    Icroppedgreen=Igreen(size(Igreen,1)*BoxLocation(2):size(Igreen,1)*BoxLocation(4),size(Igreen,2)*BoxLocation(1):size(Igreen,2)*BoxLocation(3));
    Icroppedblue=Iblue(size(Iblue,1)*BoxLocation(2):size(Iblue,1)*BoxLocation(4),size(Iblue,2)*BoxLocation(1):size(Iblue,2)*BoxLocation(3));

    Avgred=mean2(Icroppedred)
    Avggreen=mean2(Icroppedgreen)
    Avgblue=mean2(Icroppedblue)
    
    if Avgred>=LowRGB(1) && Avgred<=UpRGB(1)&& Avggreen>=LowRGB(2) && Avggreen<=UpRGB(2)&& Avgblue>=LowRGB(3) && Avgblue<=UpRGB(3)
        Status='Passed'
    else
        Status='Failed'
    end
%         fid = fopen( 'CheckExposureResults.txt', 'wt' );
    fprintf( fid, '%s \t %s \t %10.2f \t %10.2f \t %10.2f \t %s\n',name11{i},CamModel,Avgred,Avggreen,Avgblue,Status);
%         fclose(fid);
end

fclose(fid);
h = msgbox('Processing Completed');

end


