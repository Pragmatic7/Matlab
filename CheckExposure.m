function varargout = CheckExposure(varargin)
% CHECKEXPOSURE MATLAB code for CheckExposure.fig
%      CHECKEXPOSURE, by itself, creates a new CHECKEXPOSURE or raises the existing
%      singleton*.
%
%      H = CHECKEXPOSURE returns the handle to a new CHECKEXPOSURE or the handle to
%      the existing singleton*.
%
%      CHECKEXPOSURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHECKEXPOSURE.M with the given input arguments.
%
%      CHECKEXPOSURE('Property','Value',...) creates a new CHECKEXPOSURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CheckExposure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CheckExposure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CheckExposure

% Last Modified by GUIDE v2.5 05-Dec-2016 11:21:22
warning('off','all')

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CheckExposure_OpeningFcn, ...
                   'gui_OutputFcn',  @CheckExposure_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before CheckExposure is made visible.
function CheckExposure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CheckExposure (see VARARGIN)

handles.Camera='';
handles.ImageType='';
handles.Folder='';
handles.ImageFormat='';
handles.BoxLocation = [0.48,0.58,0.52,0.62];% ULX,ULY,LRX,LRY

% Choose default command line output for CheckExposure
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CheckExposure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CheckExposure_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Folder = uigetdir('Computer\','Select Image Folder');
set(handles.text8, 'String', handles.Folder);
guidata(hObject, handles);

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val}
case 'D2X' % User selects peaks.
   handles.Camera = 'D2X';
case 'D300' % User selects peaks.
   handles.Camera = 'D300';
case 'D610' % User selects peaks.
    handles.Camera = 'D610';
end
% Save the handles structure.
guidata(hObject,handles)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val}
case 'Calibration' % User selects peaks.
   handles.ImageType = 'Calibration';
case 'Subject' % User selects peaks.
   handles.ImageType = 'Subject';
end
% Save the handles structure.
guidata(hObject,handles)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if strcmp(handles.Folder,'')||strcmp(handles.Camera,'')||strcmp(handles.ImageType,'')||strcmp(handles.ImageFormat,'')
    errordlg({'Please select the Image folder, Camera model, Image type, and Image format first!'},'Error initialization');
elseif strcmp(handles.Camera,'D2X')&& strcmp(handles.ImageType,'Calibration')
    handles.LowRGB=[199,199,199]; handles.UpRGB=[229,229,229];
    CheckExposureFunc(handles.Folder,handles.Camera,handles.ImageFormat,handles.ImageType,handles.BoxLocation,handles.LowRGB,handles.UpRGB);
elseif strcmp(handles.Camera,'D300')&& strcmp(handles.ImageType,'Calibration')
    handles.LowRGB=[195,195,195]; handles.UpRGB=[225,225,225];
    CheckExposureFunc(handles.Folder,handles.Camera,handles.ImageFormat,handles.ImageType,handles.BoxLocation,handles.LowRGB,handles.UpRGB);
elseif strcmp(handles.Camera,'D610')&& strcmp(handles.ImageType,'Calibration')
    handles.LowRGB=[210,210,210]; handles.UpRGB=[240,240,240];
    CheckExposureFunc(handles.Folder,handles.Camera,handles.ImageFormat,handles.ImageType,handles.BoxLocation,handles.LowRGB,handles.UpRGB);
elseif strcmp(handles.Camera,'D2X')&& strcmp(handles.ImageType,'Subject')
    handles.LowRGB=[220,220,220]; handles.UpRGB=[250,250,250];
    CheckExposureFunc(handles.Folder,handles.Camera,handles.ImageFormat,handles.ImageType,handles.BoxLocation,handles.LowRGB,handles.UpRGB);
elseif strcmp(handles.Camera,'D300')&& strcmp(handles.ImageType,'Subject')
    handles.LowRGB=[220,220,220]; handles.UpRGB=[250,250,250];
    CheckExposureFunc(handles.Folder,handles.Camera,handles.ImageFormat,handles.ImageType,handles.BoxLocation,handles.LowRGB,handles.UpRGB);
elseif strcmp(handles.Camera,'D610')&& strcmp(handles.ImageType,'Subject')
    handles.LowRGB=[220,220,220]; handles.UpRGB=[250,250,250];
    CheckExposureFunc(handles.Folder,handles.Camera,handles.ImageFormat,handles.ImageType,handles.BoxLocation,handles.LowRGB,handles.UpRGB);
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
!notepad CheckExposureResults.txt


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.ImageFormat == 'BMP'
    [f,p] = uigetfile('*.BMP','Select the image to show');
    I = imread(fullfile(p, f));
    figure, imshow(I)
    hold on;
    boxposition=[size(I,2)*handles.BoxLocation(1),size(I,1)*handles.BoxLocation(2),size(I,2)*(handles.BoxLocation(3)-handles.BoxLocation(1)),size(I,1)*(handles.BoxLocation(4)-handles.BoxLocation(2))];
    rectangle('Position',boxposition,...
              'EdgeColor', 'r',...
              'LineWidth',2,'LineStyle','-')
    hold off;
elseif handles.ImageFormat == 'JPG'
    [f,p] = uigetfile('*.JPG','Select the image to show');
    I = imread(fullfile(p, f));
    I=imrotate(I,90);% MATLAB ROATES the image by -90 deg!
    figure, imshow(I)
    hold on;
    boxposition=[size(I,2)*handles.BoxLocation(1),size(I,1)*handles.BoxLocation(2),size(I,2)*(handles.BoxLocation(3)-handles.BoxLocation(1)),size(I,1)*(handles.BoxLocation(4)-handles.BoxLocation(2))];
    rectangle('Position',boxposition,...
              'EdgeColor', 'r',...
              'LineWidth',2,'LineStyle','-')
    hold off;
end



% --- Executes during object creation, after setting all properties.
function text8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val}
case 'BMP' % User selects peaks.
   handles.ImageFormat = 'BMP';
case 'JPG' % User selects peaks.
   handles.ImageFormat = 'JPG';
end
% Save the handles structure.
guidata(hObject,handles)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
