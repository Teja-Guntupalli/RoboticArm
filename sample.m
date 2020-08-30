delete(instrfind)
clc

z=arduino('COM5')

z.servoAttach(3)
z.servoAttach(5)
z.servoWrite(5,110)
a=1;
for i=0:180
 z.servoWrite(3,i)
 x(a)=i;
 a=a+1;
 pause(0.1)
 
 
 
end

for j=180:-1:0
 z.servoWrite(3,j)
 pause(0.1)
 
 
 
end
plot(x)