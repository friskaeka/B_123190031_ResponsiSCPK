function varargout = SAW(varargin)
% SAW MATLAB code for SAW.fig
%      SAW, by itself, creates a new SAW or raises the existing
%      singleton*.
%
%      H = SAW returns the handle to a new SAW or the handle to
%      the existing singleton*.
%
%      SAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAW.M with the given input arguments.
%
%      SAW('Property','Value',...) creates a new SAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAW

% Last Modified by GUIDE v2.5 25-Jun-2021 20:01:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAW_OpeningFcn, ...
                   'gui_OutputFcn',  @SAW_OutputFcn, ...
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


% --- Executes just before SAW is made visible.
function SAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAW (see VARARGIN)

% Choose default command line output for SAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%1. import data dari excel ke matlab
%a. memasukkan kolom 1
opts = detectImportOptions('DATARUMAH.xlsx');
opts.SelectedVariableNames = (1);
data1 = readmatrix('DATARUMAH.xlsx',opts);
%memasukkan kolom 3-8
opts = detectImportOptions('DATARUMAH.xlsx');
opts.SelectedVariableNames = (3:8);
data2 = readmatrix('DATARUMAH.xlsx',opts);

%data dimaksukan ke tabel 1
data = [data1 data2];
set(handles.tabelrmh,'data',data);
opts = detectImportOptions('DATARUMAH.xlsx');
opts.SelectedVariableNames = (3:8);

%membaca matriks
x = readmatrix('DATARUMAH.xlsx',opts);
%nilai atribut, 0(cost) dan 1(benefit)
k=[0,1,1,1,1,1];
%bobot
w=[0.30,0.20,0.23,0.10,0.07,0.10];

[m,n]=size (x);
%membuat matriks R (matriks kosong)
R=zeros (m,n);
for j=1:n
    if k(j)==1
        %menghitung normalisasi kriteria jenis keuntungan
        R(:,j)=x(:,j)./max(x(:,j));
    else
        %menghitung normalisasi kriteria jenis biaya
        R(:,j)=min(x(:,j))./x(:,j);
    end
end
%perhitungan hasil perankingan
for i=1:m
 V(i)= sum(w.*R(i,:));
end
%menampilkan hasil perhitungan
Vtranspose=V.'; 
Vtranspose=num2cell(Vtranspose);
opts = detectImportOptions('DATARUMAH.xlsx');
opts.SelectedVariableNames = (2);
x2= readtable('DATARUMAH.xlsx',opts);
x2 = table2cell(x2);
x2=[x2 Vtranspose];
x2=sortrows(x2,-2);
x2 = x2(:,1);
%data perhitungan dimasukan ke tabel 2
set(handles.uitable2, 'data', x2);
