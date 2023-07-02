function varargout = PM20208103(varargin)
% PM20208103 MATLAB code for PM20208103.fig
%      PM20208103, by itself, creates a new PM20208103 or raises the existing
%      singleton*.
%
%      H = PM20208103 returns the handle to a new PM20208103 or the handle to
%      the existing singleton*.
%
%      PM20208103('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PM20208103.M with the given input arguments.
%
%      PM20208103('Property','Value',...) creates a new PM20208103 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PM20208103_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PM20208103_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PM20208103

% Last Modified by GUIDE v2.5 07-May-2020 21:47:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PM20208103_OpeningFcn, ...
                   'gui_OutputFcn',  @PM20208103_OutputFcn, ...
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


% --- Executes just before PM20208103 is made visible.
function PM20208103_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PM20208103 (see VARARGIN)

% Choose default command line output for PM20208103
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PM20208103 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PM20208103_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(~, ~, ~)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=15;
Long_Route(n) %This command calls back the function where all the code for the longest route is called.

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(~, ~, ~)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=15;
Shortcut(n) %This command calls back the function where all the code for the shortcut is called.
