%https://blog.csdn.net/apache_mm/article/details/53053717#comments*************
%https://www.zhihu.com/question/38858876/answer/84012518
%https://link.zhihu.com/?target=https%3A//github.com/wjxjmj/quadrotorTracking


%���� �ü�����~~~~~  ��(�b���b*)?
clc
clear
close all

flag=0;%�Ƿ������� flag=1����
global dt m k g I J l;
dt=0.1;%ʱ��΢��
m=1.5;%����
k=[0.223 0.223 0.223 0.223 0.223 0.223];%����
g=9.8;
I=[0.0175 0.0175 0.03175];%���������ת������
J=0.05;%ת������
l=0.225;%������������ĵı۳�

%��ʼ
UAV.w=[600 600 600 600];%��ʼת��
UAV.angle1=[0,0,0];%y�ᣬx�ᣬz����ת�ĽǶ�
UAV.d_angle1=[0,0,0];
UAV.d_d_angle1=[0,0,0];
UAV.position=[0,0,50];
UAV.d_position=[0,0,0];
UAV.d_d_position=[0,0,0];
record.ii=0;%�ܼ�¼

%�Ƕ��趨
s_angle1=[0,0,0];

%·���趨
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
title('�Ƕ�')
subplot(2,2,3)
plot(record.w(:,1))
hold on
plot(record.w(:,2))
hold on
plot(record.w(:,3))
hold on
plot(record.w(:,4))
title('ת��')
subplot(2,2,4)
plot(record.position(:,1))
hold on
plot(record.position(:,2))
hold on
plot(record.position(:,3))
title('λ��')
figure
plot3(record.position(:,1),record.position(:,2),record.position(:,3))
title('·��')




