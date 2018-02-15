function varargout = PCD_1(varargin)
% PCD_1 MATLAB code for PCD_1.fig
%      PCD_1, by itself, creates a new PCD_1 or raises the existing
%      singleton*.
%
%      H = PCD_1 returns the handle to a new PCD_1 or the handle to
%      the existing singleton*.
%
%      PCD_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PCD_1.M with the given input arguments.
%
%      PCD_1('Property','Value',...) creates a new PCD_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PCD_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PCD_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PCD_1

% Last Modified by GUIDE v2.5 15-Feb-2018 11:04:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PCD_1_OpeningFcn, ...
                   'gui_OutputFcn',  @PCD_1_OutputFcn, ...
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


% --- Executes just before PCD_1 is made visible.
function PCD_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PCD_1 (see VARARGIN)

% Choose default command line output for PCD_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PCD_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PCD_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_browse.
function btn_browse_Callback(hObject, eventdata, handles)
% hObject    handle to btn_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Filename,Pathname] = uigetfile({'*.png';'*.jpg';'*.bmp'},'Browse Image');
name = strcat(Pathname,Filename);
img = imread(name);
axes(handles.axes1);
handles.imgName.String = name;
imshow(img);


% --- Executes on button press in btn_grayscale.
function btn_grayscale_Callback(hObject, eventdata, handles)
% hObject    handle to btn_grayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes1);
r = sum(img(:,:,1));
g = sum(img(:,:,2));
b = sum(img(:,:,3));
if (r>g & r>b) 
    grayscale = 0.5*img(:,:,1) + 0.25*img(:,:,2) + 0.25*img(:,:,3);
elseif (g>r & g>b)
    grayscale = 0.25*img(:,:,1) + 0.5*img(:,:,2) + 0.25*img(:,:,3);
else
    grayscale = 0.25*img(:,:,1) + 0.25*img(:,:,2) + 0.5*img(:,:,3);
end
axes(handles.axes1);
imshow(grayscale);

% --- Executes on button press in btn_zoomIn.
function btn_zoomIn_Callback(hObject, eventdata, handles)
% hObject    handle to btn_zoomIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes1);
imsize = size(img);
[zoomR,zoomG,zoomB] = deal([]);
for i = 1:imsize(1)
    [r,g,b] = deal([]);
    for j = 1:imsize(2)
        r = [r img(i,j,1) img(i,j,1)];
        g = [g img(i,j,2) img(i,j,2)];
        b = [b img(i,j,3) img(i,j,3)];
    end
    zoomR = [zoomR;r;r];
    zoomG = [zoomG;g;g];
    zoomB = [zoomB;b;b];
end 

zoomInImg = cat(3,zoomR,zoomG,zoomB);
axes(handles.axes1);
imshow(zoomInImg((imsize(1)/2):(imsize(1)+imsize(1)/2),(imsize(2)/2):(imsize(2)+imsize(2)/2),:));

% --- Executes on button press in btn_zoomOut.
function btn_zoomOut_Callback(hObject, eventdata, handles)
% hObject    handle to btn_zoomOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes1);
imsize = size(img);
height = imsize(1);
width = imsize(2);
[zoomR,zoomG,zoomB] = deal([]);
h = 1;

while h<height
    [r,g,b] = deal([]);
    w = 1;
    while w<width
        r = [r round(mean(mean(img(h:h+1,w:w+1,1))))];
        g = [g round(mean(mean(img(h:h+1,w:w+1,2))))];
        b = [b round(mean(mean(img(h:h+1,w:w+1,3))))];
        w = w+2;
    end
    zoomR = [zoomR;r];
    zoomG = [zoomG;g];
    zoomB = [zoomB;b];
    h = h+2;
end
zoomOutImg = cat(3,zoomR,zoomG,zoomB);
zoomOutImg = uint8(zoomOutImg);
padded = padarray(zoomOutImg,[100 100],255);
axes(handles.axes1);
imshow(padded,'InitialMagnification','fit');

% --- Executes on button press in btn_invers.
function btn_invers_Callback(hObject, eventdata, handles)
% hObject    handle to btn_invers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes1);
imginvers = 255 - img;
axes(handles.axes1);
imshow(imginvers);

% --- Executes on button press in btn_original.
function btn_original_Callback(hObject, eventdata, handles)
% hObject    handle to btn_original (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (get(handles.imgName,'String')) 
    img = imread(get(handles.imgName,'String'));
    axes(handles.axes1);
    imshow(img);
end
