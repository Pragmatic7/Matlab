function varargout = DetectDefectivePixelsV4(varargin)
% DETECTDEFECTIVEPIXELS MATLAB code for DetectDefectivePixels.fig
%      DETECTDEFECTIVEPIXELS, by itself, creates a new DETECTDEFECTIVEPIXELS or raises the existing
%      singleton*.
%
%      H = DETECTDEFECTIVEPIXELS returns the handle to a new DETECTDEFECTIVEPIXELS or the handle to
%      the existing singleton*.
%
%      DETECTDEFECTIVEPIXELS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETECTDEFECTIVEPIXELS.M with the given input arguments.
%
%      DETECTDEFECTIVEPIXELS('Property','Value',...) creates a new DETECTDEFECTIVEPIXELS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DetectDefectivePixels_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DetectDefectivePixels_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DetectDefectivePixels

% Last Modified by GUIDE v2.5 22-Feb-2017 09:23:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DetectDefectivePixels_OpeningFcn, ...
                   'gui_OutputFcn',  @DetectDefectivePixels_OutputFcn, ...
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


% --- Executes just before DetectDefectivePixels is made visible.
function DetectDefectivePixels_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DetectDefectivePixels (see VARARGIN)

handles.ImagePath = '';
handles.HotPixlsAll = [];
handles.Threshold = 15;

% Choose default command line output for DetectDefectivePixels
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DetectDefectivePixels wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DetectDefectivePixels_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.jpg'},'Select the Black Image');
handles.ImagePath = [pathname filename];
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty (handles.ImagePath)
        errordlg({'Please select the black image first!'},'Error initialization');
else
    handles.HotPixlsAll = DetectDefectivePixelsFuncV4(handles.ImagePath,handles.Threshold);
end
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if exist('HotPixelsXY.txt', 'file')
    !notepad HotPixelsXY.txt
else
    errordlg({'Cannot open the text file. No Defective pixels found!'},'Error No Defective Pixels');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if exist('HotRows.txt', 'file')
    !notepad HotRows.txt
else
    errordlg({'Cannot open the text file. No Defective rows found!'},'Error No Defective Rows');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty (handles.ImagePath)
        errordlg({'Please choose the image first!'},'Error No Image!');
else
    I=imread(handles.ImagePath);
%     I= imrotate(I,-90);
    figure, imshow(I)
    if ~isempty (handles.HotPixlsAll)
        hold on
        for i=1:size(handles.HotPixlsAll(:,1),1)
            plot(handles.HotPixlsAll(:,2),handles.HotPixlsAll(:,1),'oy','markersize',12,'linewidth',4)
        end
        hold off
    end
end


    


% % --- Executes during object creation, after setting all properties.
% function axes1_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to axes1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: place code in OpeningFcn to populate axes1



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Threshold = str2num(get(handles.edit1,'string'));
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
