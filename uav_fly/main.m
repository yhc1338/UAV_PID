%https://blog.csdn.net/apache_mm/article/details/53053717#comments*************
%https://www.zhihu.com/question/38858876/answer/84012518
%https://link.zhihu.com/?target=https%3A//github.com/wjxjmj/quadrotorTracking


%三天 好激动啊~~~~~  φ(゜▽゜*)?
clc
clear
close all

flag=0;%是否仿真过程 flag=1仿真
global dt m k g I J l;
dt=0.1;%时间微分
m=1.5;%质量
k=[0.223 0.223 0.223 0.223 0.223 0.223];%阻力
g=9.8;
I=[0.0175 0.0175 0.03175];%三个方向的转动惯量
J=0.05;%转动惯量
l=0.225;%电机到质量中心的臂长

%初始
UAV.w=[600 600 600 600];%初始转速
UAV.angle1=[0,0,0];%y轴，x轴，z轴旋转的角度
UAV.d_angle1=[0,0,0];
UAV.d_d_angle1=[0,0,0];
UAV.position=[0,0,50];
UAV.d_position=[0,0,0];
UAV.d_d_position=[0,0,0];
record.ii=0;%总记录

%角度设定
s_angle1=[0,0,0];

%路径设定
s_position=[1000,1000,1000];
[UAV,record]=PID_fly(UAV,record,s_position,s_angle1,flag);

s_position=[1000,5000,1000];
[UAV,record]=PID_fly(UAV,record,s_position,s_angle1,flag);

s_position=[5000,5000,1000];
[UAV,record]=PID_fly(UAV,record,s_position,s_angle1,flag);

s_position=[5000,1000,1000];
[UAV,record]=PID_fly(UAV,record,s_position,s_angle1,flag);

s_position=[1000,1000,1000];
[UAV,record]=PID_fly(UAV,record,s_position,s_angle1,flag);

s_position=[1000,1000,1300];
[UAV,record]=PID_fly(UAV,record,s_position,s_angle1,flag);

s_position=[5000,1000,1300];
[UAV,record]=PID_fly(UAV,record,s_position,s_angle1,flag);

s_position=[5000,5000,1300];
[UAV,record]=PID_fly(UAV,record,s_position,s_angle1,flag);

s_position=[1000,5000,1300];
[UAV,record]=PID_fly(UAV,record,s_position,s_angle1,flag);

s_position=[1000,1000,1300];
[UAV,record]=PID_fly(UAV,record,s_position,s_angle1,flag);

figure
subplot(2,2,1)
showUAV(UAV.position,UAV.angle1);
pause(0.1)
subplot(2,2,2)
plot(record.angle1(:,1))
hold on
plot(record.angle1(:,2))
hold on
plot(record.angle1(:,3))
title('角度')
subplot(2,2,3)
plot(record.w(:,1))
hold on
plot(record.w(:,2))
hold on
plot(record.w(:,3))
hold on
plot(record.w(:,4))
title('转速')
subplot(2,2,4)
plot(record.position(:,1))
hold on
plot(record.position(:,2))
hold on
plot(record.position(:,3))
title('位置')
figure
plot3(record.position(:,1),record.position(:,2),record.position(:,3))
title('路径')




