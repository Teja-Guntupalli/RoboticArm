function varargout = PickPlaceGUI_IR(varargin)
%PICKPLACEGUI_IR M-file for PickPlaceGUI_IR.fig
%      PICKPLACEGUI_IR, by itself, creates a new PICKPLACEGUI_IR or raises the existing
%      singleton*.
%
%      H = PICKPLACEGUI_IR returns the handle to a new PICKPLACEGUI_IR or the handle to
%      the existing singleton*.
%
%      PICKPLACEGUI_IR('Property','Value',...) creates a new PICKPLACEGUI_IR using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to PickPlaceGUI_IR_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PICKPLACEGUI_IR('CALLBACK') and PICKPLACEGUI_IR('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PICKPLACEGUI_IR.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PickPlaceGUI_IR

% Last Modified by GUIDE v2.5 11-Jun-2015 18:39:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PickPlaceGUI_IR_OpeningFcn, ...
                   'gui_OutputFcn',  @PickPlaceGUI_IR_OutputFcn, ...
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


% --- Executes just before PickPlaceGUI_IR is made visible.
function PickPlaceGUI_IR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for PickPlaceGUI_IR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PickPlaceGUI_IR wait for user response (see UIRESUME)
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
end

% --- Outputs from this function are returned to the command line.
function varargout = PickPlaceGUI_IR_OutputFcn(hObject, eventdata, handles)
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
global port;
global checkpin;
checkpin=2;
global defBase;
defBase=148;
global defShoulder;
defShoulder=176;
global defElbow;
defElbow=104;
global defWrist;
defWrist=43;
global defGripper;
defGripper=0;
global defWristRotate;
defWristRotate=87;
global currBase;
global currShoulder;
global currElbow;
global currWrist;
global currGripper;
global currWristRot;
global time;
time=0.025;

arm=arduino(port);

arm.servoAttach(3);
arm.servoAttach(5);
arm.servoAttach(6);
arm.servoAttach(9);
arm.servoAttach(10);
arm.servoAttach(11);

arm.servoWrite(3,defBase)
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
arm.pinMode(8, 'output');

arm.digitalWrite(12, 0);
arm.digitalWrite(8, 0);
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
global pos;
global Y;
global dest;
% global checkpin;
global obj;
global stop;
global time;
% X{z-1,1}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{z-1,1}),'</span></html>');
while (1)
    arm.digitalWrite(12, 1);
    if stop=='e'
        arm.digitalWrite(12, 0);
        stop='a';
        break;
    end
    
    IR_check(); 
    if obj==1
        arm.digitalWrite(12, 0);
        obj=0;
        for j=1:dest-1
            X=Y;
            X{j,1}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,1}),'</span></html>');
            X{j,2}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,2}),'</span></html>');
            X{j,3}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,3}),'</span></html>');
            X{j,4}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,4}),'</span></html>');
            X{j,5}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,5}),'</span></html>');
            X{j,6}=strcat('<html><span style="color: #FF0000; font-weight: bold;">',num2str(X{j,6}),'</span></html>');
            set(handles.Table,'Data',X);
            if j==1
                currBase = arm.servoRead(3);
                if (currBase<pos(j,1))
                    for k=currBase:pos(j,1)
                        arm.servoWrite(3,k);
                        pause(time)
                    end
                else
                    for k=currBase:-1:pos(j,1)
                        arm.servoWrite(3,k);
                        pause(time)
                    end
                end

                currShoulder = arm.servoRead(5);
                if (currShoulder<pos(j,2))
                    for k=currShoulder:pos(j,2)
                        arm.servoWrite(5,k);
                        pause(time)
                    end
                else
                    for k=currShoulder:-1:pos(j,2)
                        arm.servoWrite(5,k);
                        pause(time)
                    end
                end

                currElbow = arm.servoRead(6);
                if (currElbow<pos(j,3))
                    for k=currElbow:pos(j,3)
                        arm.servoWrite(6,k);
                        pause(time)
                    end
                else
                    for k=currElbow:-1:pos(j,3)
                        arm.servoWrite(6,k);
                        pause(time)
                    end
                end

                currWrist = arm.servoRead(9);
                if (currWrist<pos(j,4))
                    for k=currWrist:pos(j,4)
                        arm.servoWrite(9,k);
                        pause(time)
                    end
                else
                    for k=currWrist:-1:pos(j,4)
                        arm.servoWrite(9,k);
                        pause(time)
                    end
                end

                currGripper = arm.servoRead(10);
                if (currGripper<pos(j,5))
                    for k=currGripper:pos(j,5)
                        arm.servoWrite(10,k);
                        pause(time)
                    end
                else
                    for k=currGripper:-1:pos(j,5)
                        arm.servoWrite(10,k);
                        pause(time)
                    end
                end                

                currWristRot = arm.servoRead(11);
                if (currWristRot<pos(j,6))
                    for k=currWristRot:pos(j,6)
                        arm.servoWrite(11,k);
                        pause(time)
                    end
                else
                    for k=currWristRot:-1:pos(j,6)
                        arm.servoWrite(11,k);
                        pause(time)
                    end
                end
            else
                if pos(j-1,1)<pos(j,1)
                    for k=pos(j-1,1):pos(j,1)
                        arm.servoWrite(3,k);
                        pause(time)
                    end
                else
                    for k=pos(j-1,1):-1:pos(j,1)
                        arm.servoWrite(3,k);
                        pause(time)
                    end
                end

                if pos(j-1,2)<pos(j,2)
                    for k=pos(j-1,2):pos(j,2)
                        arm.servoWrite(5,k);
                        pause(time)
                    end
                else
                    for k=pos(j-1,2):-1:pos(j,2)
                        arm.servoWrite(5,k);
                        pause(time)
                    end
                end

                if pos(j-1,3)<pos(j,3)
                    for k=pos(j-1,3):pos(j,3)
                        arm.servoWrite(6,k);
                        pause(time)
                    end
                else
                    for k=pos(j-1,3):-1:pos(j,3)
                        arm.servoWrite(6,k);
                        pause(time)
                    end
                end

                if pos(j-1,4)<pos(j,4)
                    for k=pos(j-1,4):pos(j,4)
                        arm.servoWrite(9,k);
                        pause(time)
                    end
                else
                    for k=pos(j-1,4):-1:pos(j,4)
                        arm.servoWrite(9,k);
                        pause(time)
                    end
                end

                if pos(j-1,5)<pos(j,5)
                    for k=pos(j-1,5):pos(j,5)
                        arm.servoWrite(10,k);
                        pause(time)
                    end
                else
                    for k=pos(j-1,5):-1:pos(j,5)
                        arm.servoWrite(10,k);
                        pause(time)
                    end
                end

                if pos(j-1,6)<pos(j,6)
                    for k=pos(j-1,6):pos(j,6)
                        arm.servoWrite(11,k);
                        pause(time)
                    end
                else
                    for k=pos(j-1,6):-1:pos(j,6)
                        arm.servoWrite(11,k);
                        pause(time)
                    end
                end
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
i=i-1;
dest=i;
if i>0
B=B(1:(size(B,1)-1),:);
pos=B;
Y=Y(1:(size(Y,1)-1),:);
set(handles.Table,'Data',B);
set(handles.stepNo,'String',num2str(i-1));
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
set(handles.SaveDone,'String','');
global save;
global Y;
% C={'Base','Shoulder','Elbow','Wrist','Gripper','WristRotate'};
% for l=1:size(B,1)
% C={C{1:length(C)};B{l,1:length(B)}};
% end
F={'BASE','SHOULDER','ELBOW','WRIST','GRIPPER','WRIST-ROTATE'};
F=[F;Y];
xlswrite(save,F);
set(handles.SaveDone,'String','Done');
end


function LoadFilename_Callback(hObject, eventdata, handles)
% hObject    handle to LoadFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LoadFilename as text
%        str2double(get(hObject,'String')) returns contents of LoadFilename as a double
global load
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

% --- Executes on button press in LoadFile.
function LoadFile_Callback(hObject, eventdata, handles)
% hObject    handle to LoadFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LoadDone,'String','');
global load
global B;
global i;
global pos;
global Y;
global dest;
global steps
% pos=zeros(steps,6);
Y={0};
B=xlsread(load);
% B=B(2:size(B),:);
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
set(handles.LoadDone,'String','Done');
end


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
