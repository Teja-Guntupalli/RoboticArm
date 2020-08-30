function varargout = Slider(varargin)
% SLIDER MATLAB code for Slider.fig
%      SLIDER, by itself, creates a new SLIDER or raises the existing
%      singleton*.
%
%      H = SLIDER returns the handle to a new SLIDER or the handle to
%      the existing singleton*.
%
%      SLIDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLIDER.M with the given input arguments.
%
%      SLIDER('Property','Value',...) creates a new SLIDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Slider_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Slider_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Slider

% Last Modified by GUIDE v2.5 11-Jun-2015 15:41:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Slider_OpeningFcn, ...
                   'gui_OutputFcn',  @Slider_OutputFcn, ...
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


% --- Executes just before Slider is made visible.
function Slider_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Slider (see VARARGIN)

% Choose default command line output for Slider
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Slider wait for user response (see UIRESUME)
% uiwait(handles.figure1);
clear all
clc


% --- Outputs from this function are returned to the command line.
function varargout = Slider_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function Base_Callback(hObject, eventdata, handles)
% hObject    handle to Base (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global defBase;
handles.baseValue=get(handles.Base,'Value');
handles.baseValue=round(handles.baseValue);
if (isempty(handles.baseValue) || handles.baseValue<0 || handles.baseValue>180)
     set(handles.Base,'Value',defBase);
     handles.baseValue=defBase;
end    
set(handles.Base,'Value',handles.baseValue);
set(handles.BaseAngle,'String',num2str(handles.baseValue));

global arm;
global currBase;
global time;
currBase = arm.servoRead(3);
if (currBase<handles.baseValue)
    for i=currBase:handles.baseValue
        arm.servoWrite(3,i);
        pause(time)
    end
else
    for i=currBase:-1:handles.baseValue
        arm.servoWrite(3,i);
        pause(time)
    end
end


% --- Executes during object creation, after setting all properties.
function Base_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Base (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function BaseAngle_Callback(hObject, eventdata, handles)
% hObject    handle to BaseAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BaseAngle as text
%        str2double(get(hObject,'String')) returns contents of BaseAngle as a double
global defBase
handles.baseValue=str2num(get(handles.BaseAngle,'String'));
handles.baseValue=round(handles.baseValue);
if (isempty(handles.baseValue) || handles.baseValue<0 || handles.baseValue>180)
    set(handles.Base,'Value',defBase);
    handles.baseValue=defBase;
else
    set(handles.Base,'Value',handles.baseValue);
end   
set(handles.BaseAngle,'String',num2str(handles.baseValue));
global arm;
global currBase;
global time;
currBase = arm.servoRead(3);
if (currBase<handles.baseValue)
    for i=currBase:handles.baseValue
        arm.servoWrite(3,i);
        pause(time)
    end
else
    for i=currBase:-1:handles.baseValue
        arm.servoWrite(3,i);
        pause(time)
    end
end


% --- Executes during object creation, after setting all properties.
function BaseAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BaseAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Shoulder_Callback(hObject, eventdata, handles)
% hObject    handle to Shoulder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global defShoulder
handles.shoulderValue=get(handles.Shoulder,'Value');
handles.shoulderValue=round(handles.shoulderValue);
if (isempty(handles.shoulderValue) || handles.shoulderValue<0 || handles.shoulderValue>180)
     set(handles.Shoulder,'Value',defShoulder);
     handles.shoulderValue=defShoulder;
end  
set(handles.Shoulder,'Value',handles.shoulderValue);
set(handles.ShoulderAngle,'String',num2str(handles.shoulderValue));

global arm;
global currShoulder;
global time;
currShoulder = arm.servoRead(5);
if (currShoulder<handles.shoulderValue)
    for i=currShoulder:handles.shoulderValue
        arm.servoWrite(5,i);
        pause(time)
    end
else
    for i=currShoulder:-1:handles.shoulderValue
        arm.servoWrite(5,i);
        pause(time)
    end
end



% --- Executes during object creation, after setting all properties.
function Shoulder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Shoulder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function ShoulderAngle_Callback(hObject, eventdata, handles)
% hObject    handle to ShoulderAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ShoulderAngle as text
%        str2double(get(hObject,'String')) returns contents of ShoulderAngle as a double
global defShoulder
handles.shoulderValue=str2num(get(handles.ShoulderAngle,'String'));
handles.shoulderValue=round(handles.shoulderValue);
if (isempty(handles.shoulderValue) || handles.shoulderValue<0 || handles.shoulderValue>180)
    set(handles.Shoulder,'Value',defShoulder);
    handles.shoulderValue=defShoulder;
else
    set(handles.Shoulder,'Value',handles.shoulderValue);
end   
set(handles.ShoulderAngle,'String',num2str(handles.shoulderValue));
global arm;
global currShoulder;
global time;
currShoulder = arm.servoRead(5);
if (currShoulder<handles.shoulderValue)
    for i=currShoulder:handles.shoulderValue
        arm.servoWrite(5,i);
        pause(time)
    end
else
    for i=currShoulder:-1:handles.shoulderValue
        arm.servoWrite(5,i);
        pause(time)
    end
end


% --- Executes during object creation, after setting all properties.
function ShoulderAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ShoulderAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Elbow_Callback(hObject, eventdata, handles)
% hObject    handle to Elbow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global defElbow
handles.elbowValue=get(handles.Elbow,'Value');
handles.elbowValue=round(handles.elbowValue);
if (isempty(handles.elbowValue) || handles.elbowValue<0 || handles.elbowValue>180)
     set(handles.Elbow,'Value',defElbow);
     handles.elbowValue=defElbow;
end    
set(handles.Elbow,'Value',handles.elbowValue);
set(handles.ElbowAngle,'String',num2str(handles.elbowValue));

global arm;
global currElbow;
global time;
currElbow = arm.servoRead(6);
if (currElbow<handles.elbowValue)
    for i=currElbow:handles.elbowValue
        arm.servoWrite(6,i);
        pause(time)
    end
else
    for i=currElbow:-1:handles.elbowValue
        arm.servoWrite(6,i);
        pause(time)
    end
end


% --- Executes during object creation, after setting all properties.
function Elbow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Elbow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function ElbowAngle_Callback(hObject, eventdata, handles)
% hObject    handle to ElbowAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ElbowAngle as text
%        str2double(get(hObject,'String')) returns contents of ElbowAngle as a double
global defElbow
handles.elbowValue=str2num(get(handles.ElbowAngle,'String'));
handles.elbowValue=round(handles.elbowValue);
if (isempty(handles.elbowValue) || handles.elbowValue<0 || handles.elbowValue>180)
    set(handles.Elbow,'Value',defElbow);
    handles.elbowValue=defElbow;
else
    set(handles.Elbow,'Value',handles.elbowValue);
end   
set(handles.ElbowAngle,'String',num2str(handles.elbowValue));
global arm;
global currElbow;
global time
currElbow = arm.servoRead(6);
if (currElbow<handles.elbowValue)
    for i=currElbow:handles.elbowValue
        arm.servoWrite(6,i);
        pause(time)
    end
else
    for i=currElbow:-1:handles.elbowValue
        arm.servoWrite(6,i);
        pause(time)
    end
end


% --- Executes during object creation, after setting all properties.
function ElbowAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ElbowAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Wrist_Callback(hObject, eventdata, handles)
% hObject    handle to Wrist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global defWrist
handles.wristValue=get(handles.Wrist,'Value');
handles.wristValue=round(handles.wristValue);
if (isempty(handles.wristValue) || handles.wristValue<0 || handles.wristValue>180)
     set(handles.Wrist,'Value',defWrist);
     handles.wristValue=defWrist;
end    
set(handles.Wrist,'Value',handles.wristValue);
set(handles.WristAngle,'String',num2str(handles.wristValue));

global arm;
global currWrist;
global time;
currWrist = arm.servoRead(9);
if (currWrist<handles.wristValue)
    for i=currWrist:handles.wristValue
        arm.servoWrite(9,i);
        pause(time)
    end
else
    for i=currWrist:-1:handles.wristValue
        arm.servoWrite(9,i);
        pause(time)
    end
end


% --- Executes during object creation, after setting all properties.
function Wrist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Wrist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function WristAngle_Callback(hObject, eventdata, handles)
% hObject    handle to WristAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WristAngle as text
%        str2double(get(hObject,'String')) returns contents of WristAngle as a double
global defWrist
handles.wristValue=str2num(get(handles.WristAngle,'String'));
handles.wristValue=round(handles.wristValue);
if (isempty(handles.wristValue) || handles.wristValue<0 || handles.wristValue>180)
    set(handles.Wrist,'Value',defWrist);
    handles.wristValue=defWrist;
else
    set(handles.Wrist,'Value',handles.wristValue);
end   
set(handles.WristAngle,'String',num2str(handles.wristValue));
global arm;
global currWrist;
global time;
currWrist = arm.servoRead(9);
if (currWrist<handles.wristValue)
    for i=currWrist:handles.wristValue
        arm.servoWrite(9,i);
        pause(time)
    end
else
    for i=currWrist:-1:handles.wristValue
        arm.servoWrite(9,i);
        pause(time)
    end
end


% --- Executes during object creation, after setting all properties.
function WristAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WristAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Gripper_Callback(hObject, eventdata, handles)
% hObject    handle to Gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global defGripper
handles.gripperValue=get(handles.Gripper,'Value');
handles.gripperValue=round(handles.gripperValue);
if (isempty(handles.gripperValue) || handles.gripperValue<0 || handles.gripperValue>180)
     set(handles.Gripper,'Value',defGripper);
     handles.gripperValue=defGripper;
end    
set(handles.Gripper,'Value',handles.gripperValue);
set(handles.GripperAngle,'String',num2str(handles.gripperValue));

global arm;
global currGripper;
global time;
currGripper = arm.servoRead(10);
if (currGripper<handles.gripperValue)
    for i=currGripper:handles.gripperValue
        arm.servoWrite(10,i);
        pause(time)
    end
else
    for i=currGripper:-1:handles.gripperValue
        arm.servoWrite(10,i);
        pause(time)
    end
end


% --- Executes during object creation, after setting all properties.
function Gripper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gripper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function GripperAngle_Callback(hObject, eventdata, handles)
% hObject    handle to GripperAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GripperAngle as text
%        str2double(get(hObject,'String')) returns contents of GripperAngle as a double
global defGripper
handles.gripperValue=str2num(get(handles.GripperAngle,'String'));
handles.gripperValue=round(handles.gripperValue);
if (isempty(handles.gripperValue) || handles.gripperValue<0 || handles.gripperValue>180)
    set(handles.Gripper,'Value',defGripper);
    handles.gripperValue=defGripper;
else
    set(handles.Gripper,'Value',handles.gripperValue);
end   
set(handles.GripperAngle,'String',num2str(handles.gripperValue));
global arm;
global currGripper;
global time;
currGripper = arm.servoRead(10);
if (currGripper<handles.gripperValue)
    for i=currGripper:handles.gripperValue
        arm.servoWrite(10,i);
        pause(time)
    end
else
    for i=currGripper:-1:handles.gripperValue
        arm.servoWrite(10,i);
        pause(time)
    end
end


% --- Executes during object creation, after setting all properties.
function GripperAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GripperAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function WristRotate_Callback(hObject, eventdata, handles)
% hObject    handle to WristRotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global defWristRotate
handles.wristRotValue=get(handles.WristRotate,'Value');
handles.wristRotValue=round(handles.wristRotValue);
if (isempty(handles.wristRotValue) || handles.wristRotValue<0 || handles.wristRotValue>180)
    set(handles.WristRotate,'Value',defWristRotate);
    handles.wristRotValue=defWristRotate;
end    
set(handles.WristRotate,'Value',handles.wristRotValue);
set(handles.WristRotateAngle,'String',num2str(handles.wristRotValue));

global arm;
global currWristRot;
global time;
currWristRot = arm.servoRead(11);
if (currWristRot<handles.wristRotValue)
    for i=currWristRot:handles.wristRotValue
        arm.servoWrite(11,i);
        pause(time)
    end
else
    for i=currWristRot:-1:handles.wristRotValue
        arm.servoWrite(11,i);
        pause(time)
    end
end


% --- Executes during object creation, after setting all properties.
function WristRotate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WristRotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function WristRotateAngle_Callback(hObject, eventdata, handles)
% hObject    handle to WristRotateAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WristRotateAngle as text
%        str2double(get(hObject,'String')) returns contents of WristRotateAngle as a double
global defWristRotate
handles.wristRotValue=str2num(get(handles.WristRotateAngle,'String'));
handles.wristRotValue=round(handles.wristRotValue);
if (isempty(handles.wristRotValue) || handles.wristRotValue<0 || handles.wristRotValue>180)
    set(handles.WristRotate,'Value',defWristRotate);
    handles.wristRotValue=defWristRotate;
else
    set(handles.WristRotate,'Value',handles.wristRotValue);
end   
set(handles.WristRotateAngle,'String',num2str(handles.wristRotValue));
global arm;
global currWristRot;
global time;
currWristRot = arm.servoRead(11);
if (currWristRot<handles.wristRotValue)
    for i=currWristRot:handles.wristRotValue
        arm.servoWrite(11,i);
        pause(time)
    end
else
    for i=currWristRot:-1:handles.wristRotValue
        arm.servoWrite(11,i);
        pause(time)
    end
end


% --- Executes during object creation, after setting all properties.
function WristRotateAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WristRotateAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startButton.
function startButton_Callback(hObject, eventdata, handles)
% hObject    handle to startButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arm;
global port;
global defBase;
defBase=126;
global defShoulder;
defShoulder=153;
global defElbow;
defElbow=72;
global defWrist;
defWrist=25;
global defGripper;
defGripper=36;
global defWristRotate;
defWristRotate=0;
global currBase;
global currShoulder;
global currElbow;
global currWrist;
global currGripper;
global currWristRot;
global time;
time=0.015;
arm=arduino(port);

arm.servoAttach(3);
arm.servoAttach(5);
arm.servoAttach(6);
arm.servoAttach(9);
arm.servoAttach(10);
arm.servoAttach(11);

arm.servoWrite(3,defBase);
pause(time);
arm.servoWrite(5,defShoulder);
pause(time);
arm.servoWrite(6,defElbow);
pause(time);
arm.servoWrite(9,defWrist);
pause(time);
arm.servoWrite(10,defGripper);
pause(time);
arm.servoWrite(11,defWristRotate);
pause(time);

set(handles.BaseAngle,'String',num2str(defBase));
set(handles.ShoulderAngle,'String',num2str(defShoulder));
set(handles.ElbowAngle,'String',num2str(defElbow));
set(handles.WristAngle,'String',num2str(defWrist));
set(handles.GripperAngle,'String',num2str(defGripper));
set(handles.WristRotateAngle,'String',num2str(defWristRotate));

currBase=arm.servoRead(3);
currShoulder=arm.servoRead(5);
currElbow=arm.servoRead(6);
currWrist=arm.servoRead(9);
currGripper=arm.servoRead(10);
currWristRot=arm.servoRead(11);



% --- Executes on selection change in COM_Port.
function COM_Port_Callback(hObject, eventdata, handles)
% hObject    handle to COM_Port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns COM_Port contents as cell array
%        contents{get(hObject,'Value')} returns selected item from COM_Port
global port;
switch get(handles.COM_Port,'Value')
    case 2
        port='COM1';
    case 3
        port='COM2';
    case 4
        port='COM3';
    case 5
        port='COM4';
    case 6
        port='COM5';
    case 7
        port='COM6';
    case 8
        port='COM7';
    case 9
        port='COM8';
    case 10
        port='COM9';
    case 11
        port='COM10';
end

% --- Executes during object creation, after setting all properties.
function COM_Port_CreateFcn(hObject, eventdata, handles)
% hObject    handle to COM_Port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Delay_Callback(hObject, eventdata, handles)
% hObject    handle to Delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global time
time=get(handles.Delay,'Value');
if (isempty(time) || time<0 || time>100)
    time=15;
end
time=round(time);
set(handles.Delay,'Value',time);
set(handles.Delay_Value,'String',num2str(time));
time=time/1000;


% --- Executes during object creation, after setting all properties.
function Delay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Delay_Value_Callback(hObject, eventdata, handles)
% hObject    handle to Delay_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Delay_Value as text
%        str2double(get(hObject,'String')) returns contents of Delay_Value as a double
global time
time=str2num(get(handles.Delay_Value,'String'));
if (isempty(time) || time<0 || time>100)
    time=15;
end
time=round(time);
set(handles.Delay,'Value',time);
set(handles.Delay_Value,'String',num2str(time));
time=time/1000;

% --- Executes during object creation, after setting all properties.
function Delay_Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Delay_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
