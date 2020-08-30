function varargout = PickPlaceGUI_IR_Color_modified(varargin)
%PICKPLACEGUI_IR_COLOR_MODIFIED M-file for PickPlaceGUI_IR_Color_modified.fig
%      PICKPLACEGUI_IR_COLOR_MODIFIED, by itself, creates a new PICKPLACEGUI_IR_COLOR_MODIFIED or raises the existing
%      singleton*.
%
%      H = PICKPLACEGUI_IR_COLOR_MODIFIED returns the handle to a new PICKPLACEGUI_IR_COLOR_MODIFIED or the handle to
%      the existing singleton*.
%
%      PICKPLACEGUI_IR_COLOR_MODIFIED('Property','Value',...) creates a new PICKPLACEGUI_IR_COLOR_MODIFIED using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to PickPlaceGUI_IR_Color_modified_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PICKPLACEGUI_IR_COLOR_MODIFIED('CALLBACK') and PICKPLACEGUI_IR_COLOR_MODIFIED('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PICKPLACEGUI_IR_COLOR_MODIFIED.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PickPlaceGUI_IR_Color_modified

% Last Modified by GUIDE v2.5 03-Nov-2016 16:13:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PickPlaceGUI_IR_Color_modified_OpeningFcn, ...
                   'gui_OutputFcn',  @PickPlaceGUI_IR_Color_modified_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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
end

% --- Executes just before PickPlaceGUI_IR_Color_modified is made visible.
function PickPlaceGUI_IR_Color_modified_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for PickPlaceGUI_IR_Color_modified
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PickPlaceGUI_IR_Color_modified wait for user response (see UIRESUME)
% uiwait(handles.figure1);
clear all
clc
global steps
steps=100;
global pos
pos=zeros(steps,6);
global i;
global h;
h=1;
global dest;
global B
global Y
global arm
global checkpin;
checkpin=2;
global stop;
global entry;
entry=1;
global time;
time=0.02;
end

% --- Outputs from this function are returned to the command line.
function varargout = PickPlaceGUI_IR_Color_modified_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

end

% --- Executes on button press in startButton.
function startButton_Callback(hObject, eventdata, handles)
% hObject    handle to startButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arm;
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
global port;
global c1;
global d1;
global c2;
global d2;
global c3;
global d3;
set(handles.CheckStep,'String',num2str(0));
global rect;
rect=0;
global vidDevice;
vidDevice = videoinput('winvideo',1,'YUY2_320x240');
set(vidDevice,'FramesPerTrigger',inf);
set(vidDevice,'ReturnedColorspace','rgb');

global time;
time=0.015;
set(handles.Delay_Value,'String',num2str(15));
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

arm.pinMode(2, 'input');
arm.pinMode(12, 'output');
arm.pinMode(13, 'output');

arm.digitalWrite(12, 0);
arm.digitalWrite(13, 0);
end

% --- Executes on selection change in COM_Port.
function COM_Port_Callback(hObject, eventdata, handles)
% hObject    handle to COM_Port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns COM_Port contents as cell array
%        contents{get(hObject,'Value')} returns selected item from COM_Port
global port
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
end

% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i;
global pos;
global h;
global B;
global Y;
global dest;
if dest>1
    i=dest;
    h=2;
else
    i=1;
end
pos(i,1)=get(handles.Base,'Value');
pos(i,2)=get(handles.Shoulder,'Value');
pos(i,3)=get(handles.Elbow,'Value');
pos(i,4)=get(handles.Wrist,'Value');
pos(i,5)=get(handles.Gripper,'Value');
pos(i,6)=get(handles.WristRotate,'Value');
set(handles.stepNo,'String',num2str(i));
i=i+1;
dest=i;
data=get(handles.Table,'Data');
z=size(data,1)+1;
    switch h
        case 1
          B(h,:)=pos(i-1,:);
          Y{h,1}=pos(i-1,1);
          Y{h,2}=pos(i-1,2);
          Y{h,3}=pos(i-1,3);
          Y{h,4}=pos(i-1,4);
          Y{h,5}=pos(i-1,5);
          Y{h,6}=pos(i-1,6);
          h=h+1;
        case 2
          B(z,:)=pos(i-1,:);
          Y{z,1}=pos(i-1,1);
          Y{z,2}=pos(i-1,2);
          Y{z,3}=pos(i-1,3);
          Y{z,4}=pos(i-1,4);
          Y{z,5}=pos(i-1,5);
          Y{z,6}=pos(i-1,6);
    end
    set(handles.Table,'Data',B);

end

function stepNo_Callback(hObject, eventdata, handles)
% hObject    handle to stepNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stepNo as text
%        str2double(get(hObject,'String')) returns contents of stepNo as a double
end

% --- Executes during object creation, after setting all properties.
function stepNo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stepNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in repeat.
function repeat_Callback(hObject, eventdata, handles)
% hObject    handle to repeat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arm;
global Y;
% global checkpin;
global obj;
global stop;
global c1;
global d1;
global c2;
global d2;
global c3;
global d3;
global color;
global vidDevice;
% X{z-1,1}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{z-1,1}),'</span></html>');
while (1)
    arm.digitalWrite(12, 1);
    if stop=='e'
        stop='a';
        arm.digitalWrite(12, 0);
        release(vidDevice);
        
        break;
    end
    IR_check();
    if obj==1
        arm.digitalWrite(12, 0);
        obj=0;
        pause(1)
        Color_check(handles);
        for j=1:c1
            X=Y;
            X{j,1}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,1}),'</span></html>');
            X{j,2}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,2}),'</span></html>');
            X{j,3}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,3}),'</span></html>');
            X{j,4}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,4}),'</span></html>');
            X{j,5}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,5}),'</span></html>');
            X{j,6}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,6}),'</span></html>');
            set(handles.Table,'Data',X);
            motorWrite(j);
        end
        if strcmp(color,'red')
            for j=c1+1:d1
                X=Y;
                X{j,1}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,1}),'</span></html>');
                X{j,2}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,2}),'</span></html>');
                X{j,3}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,3}),'</span></html>');
                X{j,4}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,4}),'</span></html>');
                X{j,5}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,5}),'</span></html>');
                X{j,6}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,6}),'</span></html>');
                set(handles.Table,'Data',X);
                motorWrite(j);                
            end
            motorWrite(1);
        elseif strcmp(color,'green')
            for j=c2+1:d2
                X=Y;
                X{j,1}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,1}),'</span></html>');
                X{j,2}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,2}),'</span></html>');
                X{j,3}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,3}),'</span></html>');
                X{j,4}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,4}),'</span></html>');
                X{j,5}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,5}),'</span></html>');
                X{j,6}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,6}),'</span></html>');
                set(handles.Table,'Data',X);
                motorWrite(j);                
            end
        elseif strcmp(color,'blue')
            for j=c3+1:d3
                X=Y;
                X{j,1}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,1}),'</span></html>');
                X{j,2}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,2}),'</span></html>');
                X{j,3}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,3}),'</span></html>');
                X{j,4}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,4}),'</span></html>');
                X{j,5}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,5}),'</span></html>');
                X{j,6}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,6}),'</span></html>');
                set(handles.Table,'Data',X);
                motorWrite(j);                
            end
        end
    end
end
end

% --- Executes on button press in Delete.
function Delete_Callback(hObject, eventdata, handles)
% hObject    handle to Delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
global dest
global pos
global B
global Y
global c1;
global d1;
global c2;
global d2;
global c3;
global d3;
global entry;
i=i-1;
dest=i;
if i>0
B=B(1:(size(B,1)-1),:);
pos=B;
Y=Y(1:(size(Y,1)-1),:);
set(handles.Table,'Data',B);
set(handles.stepNo,'String',num2str(i-1));
if i==d3
    d3=0;
    entry=6;
    set(handles.CheckStep,'String',num2str(3));
elseif i==d2
    d2=0;
    c3=0;
    entry=4;
    set(handles.CheckStep,'String',num2str(2));
elseif i==d1
    d1=0;
    c2=0;
    entry=2;
    set(handles.CheckStep,'String',num2str(1));
elseif i==c1
    c1=0;
    entry=1;
    set(handles.CheckStep,'String',num2str(0));
end
    
    
end
end

% --- Executes on button press in stopButton.
function stopButton_Callback(hObject, eventdata, handles)
% hObject    handle to stopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop;
global arm;
arm.digitalWrite(12, 0);
stop='e';
end

% --- Executes on button press in Checkpoint.
function Checkpoint_Callback(hObject, eventdata, handles)
% hObject    handle to Checkpoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global c1;
global d1;
global c2;
global d2;
global c3;
global d3;
global i;
global entry;
Save_Callback(hObject,eventdata,handles);
switch (entry)
          case 1 %save check-obj position
            c1=i-1;
            entry=entry+1;
            set(handles.CheckStep,'String',num2str(1));
          case 2 %save drop-objR position
            d1=i-1;
            entry=entry+1;
            for s=d1-1:-1:c1
                motorWrite2(s);
            end
            SaveMotor(c1, hObject, eventdata, handles);
          	Save_Callback(hObject, eventdata, handles);
            c2=i-1;
            entry=entry+1;
            set(handles.CheckStep,'String',num2str(2));
          case 4 %save the take-objG position
            d2=i-1;
            entry=entry+1;
            for s=d2-1:-1:c2
                motorWrite2(s);
            end
            SaveMotor(c2, hObject, eventdata, handles);
            Save_Callback(hObject, eventdata, handles);
            c3=i-1;
            entry=entry+1;
            set(handles.CheckStep,'String',num2str(3));
          case 6 %save the drop-objB position
            d3=i-1;
            entry=entry+1;
            for s=d3-1:-1:c3
                motorWrite2(s);
            end
            SaveMotor(c3, hObject, eventdata, handles);
            Save_Callback(hObject, eventdata, handles);
            for s=c1-1:-1:1
                motorWrite2(s);
            end
            set(handles.CheckStep,'String','Done');
         case 7
             Delete_Callback(hObject,eventdata,handles);
end


end

% --- Executes on Base slider movement.
function Base_Callback(hObject, eventdata, handles)
% hObject    handle to Base (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global defBase
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
end

% --- Executes Base angle entered.
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
end

% --- Executes on Shoulder slider movement.
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
end

% --- Executes Shoulder angle entered.
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
end

% --- Executes on Elbow slider movement.
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
end

% --- Executes Elbow angle entered.
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
end

% --- Executes on Wrist slider movement.
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
end

% --- Executes Wrist angle entered.
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
end

% --- Executes on Gripper slider movement.
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
end

% --- Executes Gripper angle entered.
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
end

% --- Executes on Wrist-Rotate slider movement.
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
end

% --- Executes Wrist-Rotate angle entered.
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
end

% --- Checks for presence of object.
function IR_check()
    global arm;
    global checkpin;
    global obj
%     pause(0.2)
    obj= arm.digitalRead(checkpin);
end

% --- To move the robot arm in the forward matrix order.
function motorWrite(q)
global pos
global arm
global time
if q==1

currBase = arm.servoRead(3);
if (currBase<pos(q,1))
    for i=currBase:pos(q,1)
        arm.servoWrite(3,i);
        pause(time)
    end
else
    for i=currBase:-1:pos(q,1)
        arm.servoWrite(3,i);
        pause(time)
    end
end

currShoulder = arm.servoRead(5);
if (currShoulder<pos(q,2))
    for i=currShoulder:pos(q,2)
        arm.servoWrite(5,i);
        pause(time)
    end
else
    for i=currShoulder:-1:pos(q,2)
        arm.servoWrite(5,i);
        pause(time)
    end
end
                
currElbow = arm.servoRead(6);
if (currElbow<pos(q,3))
    for i=currElbow:pos(q,3)
        arm.servoWrite(6,i);
        pause(time)
    end
else
    for i=currElbow:-1:pos(q,3)
        arm.servoWrite(6,i);
        pause(time)
    end
end
                
currWrist = arm.servoRead(9);
if (currWrist<pos(q,4))
    for i=currWrist:pos(q,4)
        arm.servoWrite(9,i);
        pause(time)
    end
else
    for i=currWrist:-1:pos(q,4)
        arm.servoWrite(9,i);
        pause(time)
    end
end

currGripper = arm.servoRead(10);
if (currGripper<pos(q,5))
    for i=currGripper:pos(q,5)
        arm.servoWrite(10,i);
        pause(time)
    end
else
    for i=currGripper:-1:pos(q,5)
        arm.servoWrite(10,i);
        pause(time)
    end
end                
                
currWristRot = arm.servoRead(11);
if (currWristRot<pos(q,6))
    for i=currWristRot:pos(q,6)
        arm.servoWrite(11,i);
        pause(time)
    end
else
    for i=currWristRot:-1:pos(q,6)
        arm.servoWrite(11,i);
        pause(time)
    end
end
            else
                if pos(q-1,1)<pos(q,1)
                    for k=pos(q-1,1):pos(q,1)
                        arm.servoWrite(3,k);
                        pause(time)
                    end
                else
                    for k=pos(q-1,1):-1:pos(q,1)
                        arm.servoWrite(3,k);
                        pause(time)
                    end
                end

                if pos(q-1,2)<pos(q,2)
                    for k=pos(q-1,2):pos(q,2)
                        arm.servoWrite(5,k);
                        pause(time)
                    end
                else
                    for k=pos(q-1,2):-1:pos(q,2)
                        arm.servoWrite(5,k);
                        pause(time)
                    end
                end

                if pos(q-1,3)<pos(q,3)
                    for k=pos(q-1,3):pos(q,3)
                        arm.servoWrite(6,k);
                        pause(time)
                    end
                else
                    for k=pos(q-1,3):-1:pos(q,3)
                        arm.servoWrite(6,k);
                        pause(time)
                    end
                end

                if pos(q-1,4)<pos(q,4)
                    for k=pos(q-1,4):pos(q,4)
                        arm.servoWrite(9,k);
                        pause(time)
                    end
                else
                    for k=pos(q-1,4):-1:pos(q,4)
                        arm.servoWrite(9,k);
                        pause(time)
                    end
                end

                if pos(q-1,5)<pos(q,5)
                    for k=pos(q-1,5):pos(q,5)
                        arm.servoWrite(10,k);
                        pause(time)
                    end
                else
                    for k=pos(q-1,5):-1:pos(q,5)
                        arm.servoWrite(10,k);
                        pause(time)
                    end
                end

                if pos(q-1,6)<pos(q,6)
                    for k=pos(q-1,6):pos(q,6)
                        arm.servoWrite(11,k);
                        pause(time)
                    end
                else
                    for k=pos(q-1,6):-1:pos(q,6)
                        arm.servoWrite(11,k);
                        pause(time)
                    end
                end
end   
end

% --- To move the robot arm in the reverse matrix order.
function motorWrite2(q)
global pos
global arm
global time
global i;
    if q==i-1
                arm.servoWrite(3,pos(q,1));
                pause(time);
                arm.servoWrite(5,pos(q,2));
                pause(time);
                arm.servoWrite(6,pos(q,3));
                pause(time);
                arm.servoWrite(9,pos(q,4));
                pause(time);
                arm.servoWrite(10,pos(q,5));
                pause(time);
                arm.servoWrite(11,pos(q,6));
                pause(time);
            else
                if pos(q+1,1)<pos(q,1)
                    for k=pos(q+1,1):pos(q,1)
                        arm.servoWrite(3,k);
                        pause(time)
                    end
                else
                    for k=pos(q+1,1):-1:pos(q,1)
                        arm.servoWrite(3,k);
                        pause(time)
                    end
                end

                if pos(q+1,2)<pos(q,2)
                    for k=pos(q+1,2):pos(q,2)
                        arm.servoWrite(5,k);
                        pause(time)
                    end
                else
                    for k=pos(q+1,2):-1:pos(q,2)
                        arm.servoWrite(5,k);
                        pause(time)
                    end
                end

                if pos(q+1,3)<pos(q,3)
                    for k=pos(q+1,3):pos(q,3)
                        arm.servoWrite(6,k);
                        pause(time)
                    end
                else
                    for k=pos(q+1,3):-1:pos(q,3)
                        arm.servoWrite(6,k);
                        pause(time)
                    end
                end

                if pos(q+1,4)<pos(q,4)
                    for k=pos(q-1,4):pos(q,4)
                        arm.servoWrite(9,k);
                        pause(time)
                    end
                else
                    for k=pos(q+1,4):-1:pos(q,4)
                        arm.servoWrite(9,k);
                        pause(time)
                    end
                end

                if pos(q+1,5)<pos(q,5)
                    for k=pos(q-1,5):pos(q,5)
                        arm.servoWrite(10,k);
                        pause(time)
                    end
                else
                    for k=pos(q+1,5):-1:pos(q,5)
                        arm.servoWrite(10,k);
                        pause(time)
                    end
                end

                if pos(q+1,6)<pos(q,6)
                    for k=pos(q-1,6):pos(q,6)
                        arm.servoWrite(11,k);
                        pause(time)
                    end
                else
                    for k=pos(q+1,6):-1:pos(q,6)
                        arm.servoWrite(11,k);
                        pause(time)
                    end
                end
    end
end

% --- The servo angles are set to the specfied positions.
function SaveMotor(q, hObject, eventdata, handles)
global pos;
set(handles.Base,'Value',pos(q,1));
set(handles.Shoulder,'Value',pos(q,2));
set(handles.Elbow,'Value',pos(q,3));
set(handles.Wrist,'Value',pos(q,4));
set(handles.Gripper,'Value',pos(q,5));
set(handles.WristRotate,'Value',pos(q,6));

Base_Callback(hObject, eventdata, handles);
Shoulder_Callback(hObject, eventdata, handles);
Elbow_Callback(hObject, eventdata, handles);
Wrist_Callback(hObject, eventdata, handles);
Gripper_Callback(hObject, eventdata, handles);
WristRotate_Callback(hObject, eventdata, handles);

end

% --- Checks the color of the object using the USB camera.
function Color_check(handles)
global color
global rect;
global vidDevice;
set(handles.ObjColor,'String','');
redThresh = 0.12; % Threshold for red detection
greenThresh = 0.05; % Threshold for green detection
blueThresh = 0.2; % Threshold for blue detection
if rect==0
    preview(vidDevice);
    pause(5)
    Frame = getsnapshot(vidDevice); % Acquire single frame
    rgbFrame=ycbcr2rgb(Frame);
    rgbFrame = flipdim(rgbFrame,2); % obtain the mirror image for displaying
    figure()
    [rgbFrame, rect] = imcrop(rgbFrame);
    closepreview(vidDevice);
    
    %rgbFrame = step(vidDevice); % Acquire single frame
    
    
    rgbFrame = getsnapshot(vidDevice); % Acquire single frame
    
    rgbFrame = flipdim(rgbFrame,2); % obtain the mirror image for displaying    
    rgbFrame = imcrop(rgbFrame, rect);
    
    diffFrameRed = imsubtract(rgbFrame(:,:,1), rgb2gray(rgbFrame)); % Get red component of the image
    diffFrameRed = medfilt2(diffFrameRed, [3 3]); % Filter out the noise by using median filter
    binFrameRed = im2bw(diffFrameRed, redThresh); % Convert the image into binary image with the red objects as white
    
    diffFrameGreen = imsubtract(rgbFrame(:,:,2), rgb2gray(rgbFrame)); % Get green component of the image
    diffFrameGreen = medfilt2(diffFrameGreen, [3 3]); % Filter out the noise by using median filter
    binFrameGreen = im2bw(diffFrameGreen, greenThresh); % Convert the image into binary image with the green objects as white
    
    diffFrameBlue = imsubtract(rgbFrame(:,:,3), rgb2gray(rgbFrame)); % Get blue component of the image
    diffFrameBlue = medfilt2(diffFrameBlue, [3 3]); % Filter out the noise by using median filter
    binFrameBlue = im2bw(diffFrameBlue, blueThresh); % Convert the image into binary image with the blue objects as white    

    r=rgbFrame(:,:,1) & binFrameRed;
    g=rgbFrame(:,:,2) & binFrameGreen;
    b=rgbFrame(:,:,3) & binFrameBlue;
    R=mean(mean(r));
    G=mean(mean(g));
    B=mean(mean(b));
%     figure(); imshow(rgbFrame), title('Image')
%     figure(); imshow(binFrameRed); title('Red objects');
%     figure(); imshow(binFrameGreen); title('Green objects');
%     figure(); imshow(binFrameBlue); title('Blue objects');
    if (R>G && R>B) color='red';
    elseif (G>R && G>B) color='green';
    elseif (B>R && B>G) color='blue';
    end
    set(handles.ObjColor,'String',color);
else
    %rgbFrame = step(vidDevice); % Acquire single frame
    rgbFrame = getsnapshot(vidDevice); % Acquire single frame
    
    rgbFrame = flipdim(rgbFrame,2); % obtain the mirror image for displaying    
    rgbFrame = imcrop(rgbFrame, rect);
    
    diffFrameRed = imsubtract(rgbFrame(:,:,1), rgb2gray(rgbFrame)); % Get red component of the image
    diffFrameRed = medfilt2(diffFrameRed, [3 3]); % Filter out the noise by using median filter
    binFrameRed = im2bw(diffFrameRed, redThresh); % Convert the image into binary image with the red objects as white
    
    diffFrameGreen = imsubtract(rgbFrame(:,:,2), rgb2gray(rgbFrame)); % Get green component of the image
    diffFrameGreen = medfilt2(diffFrameGreen, [3 3]); % Filter out the noise by using median filter
    binFrameGreen = im2bw(diffFrameGreen, greenThresh); % Convert the image into binary image with the green objects as white
    
    diffFrameBlue = imsubtract(rgbFrame(:,:,3), rgb2gray(rgbFrame)); % Get blue component of the image
    diffFrameBlue = medfilt2(diffFrameBlue, [3 3]); % Filter out the noise by using median filter
    binFrameBlue = im2bw(diffFrameBlue, blueThresh); % Convert the image into binary image with the blue objects as white    

    r=rgbFrame(:,:,1) & binFrameRed;
    g=rgbFrame(:,:,2) & binFrameGreen;
    b=rgbFrame(:,:,3) & binFrameBlue;
    R=mean(mean(r))
    G=mean(mean(g))
    B=mean(mean(b))
%     figure(); imshow(rgbFrame), title('Image');
%     figure(); imshow(binFrameRed); title('Red objects');
%     figure(); imshow(binFrameGreen); title('Green objects');
%     figure(); imshow(binFrameBlue); title('Blue objects');
    if (R>G && R>B) color='red';
    elseif (G>R && G>B) color='green';
    elseif (B>R && B>G) color='blue';
    end
    set(handles.ObjColor,'String',color);
end

end

% --- The name of the excel file to be saved is obtained.
function SaveFilename_Callback(hObject, eventdata, handles)
% hObject    handle to SaveFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SaveFilename as text
%        str2double(get(hObject,'String')) returns contents of SaveFilename as a double
global save
save=get(handles.SaveFilename,'String');
save=strcat(save,'.xlsx');
end

% --- Executes during object creation, after setting all properties.
function SaveFilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SaveFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

% --- Executes on button press in SaveFile.
function SaveFile_Callback(hObject, eventdata, handles)
% hObject    handle to SaveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global c1;
global d1;
global c2;
global d2;
global c3;
global d3;
set(handles.SaveDone,'String','');
global save;
global Y;
% C={'Base','Shoulder','Elbow','Wrist','Gripper','WristRotate'};
% for l=1:size(B,1)
% C={C{1:length(C)};B{l,1:length(B)}};
% end
F={'BASE','SHOULDER','ELBOW','WRIST','GRIPPER','WRIST-ROTATE'};
F=[F;Y(1:c1-1,:)];
G={'RED','','','','',''};
F=[F;G];
F=[F;Y(c1:d1,:)];
G={'GREEN','','','','',''};
F=[F;G];
F=[F;Y(c2:d2,:)];
G={'BLUE','','','','',''};
F=[F;G];
F=[F;Y(c3:d3,:)];
G={'REST','','','','',''};
F=[F;G];
F=[F;Y(d3+1:size(Y),:)];
xlswrite(save,F);
set(handles.SaveDone,'String','Done');
end

% --- Displays that the file has been saved.
function SaveDone_Callback(hObject, eventdata, handles)
% hObject    handle to SaveDone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SaveDone as text
%        str2double(get(hObject,'String')) returns contents of SaveDone as a double


end

% --- Executes during object creation, after setting all properties.
function SaveDone_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SaveDone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

% --- Executes on button press in LoadFile.
function LoadFile_Callback(hObject, eventdata, handles)
% hObject    handle to LoadFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global c1;
global d1;
global c2;
global d2;
global c3;
global d3;
set(handles.LoadDone,'String','');
global load
global B;
global i;
global pos;
global Y;
global dest;
global entry;
Y={0};
C=xlsread(load);
% B=B(2:size(B),:);
k=0;
for m=1:4
    for n=k+1:size(C)
        if isnan(C(n,1))
        t(m,1)=n;
        k=n;
        break
        end
    end
end
c1=t(1,1);
d1=t(2,1)-2;
c2=d1+1;
d2=t(3,1)-3;
c3=d2+1;
d3=t(4,1)-4;

B=C(1:t(1,1)-1,:);
B=[B;C(t(1,1)+1:t(2,1)-1,:)];
B=[B;C(t(2,1)+1:t(3,1)-1,:)];
B=[B;C(t(3,1)+1:t(4,1)-1,:)];
B=[B;C(t(4,1)+1:size(C),:)];

pos=B;
set(handles.Table,'Data',B);
i=size(B,1);
i=i+1;
dest=i;
set(handles.stepNo,'String',num2str(i-1));
for z=1:i-1
          Y{z,1}=pos(z,1);
          Y{z,2}=pos(z,2);
          Y{z,3}=pos(z,3);
          Y{z,4}=pos(z,4);
          Y{z,5}=pos(z,5);
          Y{z,6}=pos(z,6);
end
set(handles.CheckStep,'String','Done');
entry=7;
set(handles.LoadDone,'String','Done');

end

% --- Displays that the file has been loaded.
function LoadDone_Callback(hObject, eventdata, handles)
% hObject    handle to LoadDone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LoadDone as text
%        str2double(get(hObject,'String')) returns contents of LoadDone as a double

end

% --- Executes during object creation, after setting all properties.
function LoadDone_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LoadDone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

% --- The name of the excel file to be loaded is obtained.
function LoadFilename_Callback(hObject, eventdata, handles)
% hObject    handle to LoadFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LoadFilename as text
%        str2double(get(hObject,'String')) returns contents of LoadFilename as a double
global load;
load=get(handles.LoadFilename,'String');
load=strcat(load,'.xlsx');
end

% --- Executes during object creation, after setting all properties.
function LoadFilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LoadFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

% --- Color of the object identified is displayed in the text area.
function ObjColor_Callback(hObject, eventdata, handles)
% hObject    handle to ObjColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ObjColor as text
%        str2double(get(hObject,'String')) returns contents of ObjColor as a double
end

% --- Executes during object creation, after setting all properties.
function ObjColor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ObjColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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
end

% --- Executes during object creation, after setting all properties.
function Delay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
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
end

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
end



function CheckStep_Callback(hObject, eventdata, handles)
% hObject    handle to CheckStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CheckStep as text
%        str2double(get(hObject,'String')) returns contents of CheckStep as a double
end

% --- Executes during object creation, after setting all properties.
function CheckStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CheckStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
