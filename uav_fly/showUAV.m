function h=showUAV(position,angle1)
%https://blog.csdn.net/shenziheng1/article/details/51227962
R=10;%�뾶
h=0.5;%Բ��bai��du��
m=100;%�ָ�zhi�ߵ�����
[x,y,z]=cylinder(R,m);%������(0,0)ΪԲdao�ģ��߶�Ϊ[0,1]���뾶ΪR��Բ��
z=h*z;%�߶ȷŴ�h��
angle1=-angle1;
%Y
YY=[cos(angle1(1)) 0 -sin(angle1(1))
    0              1             0
    sin(angle1(1)) 0  cos(angle1(1))];
%X
XX=[1  0               0
    0  cos(angle1(2))  sin(angle1(2))
    0 -sin(angle1(2))  cos(angle1(2))];
%Z
ZZ=[ cos(angle1(3))  sin(angle1(3)) 0
    -sin(angle1(3))  cos(angle1(3)) 0
    0               0              1];
for i=1:m+1
    %Y
    a=[x(1,i),y(1,i),z(1,i)]*YY;
    x(1,i)=a(1);y(1,i)=a(2);z(1,i)=a(3);
    a=[x(2,i),y(2,i),z(2,i)]*YY;
    x(2,i)=a(1);y(2,i)=a(2);z(2,i)=a(3);
    %X
    a=[x(1,i),y(1,i),z(1,i)]*XX;
    x(1,i)=a(1);y(1,i)=a(2);z(1,i)=a(3);
    a=[x(2,i),y(2,i),z(2,i)]*XX;
    x(2,i)=a(1);y(2,i)=a(2);z(2,i)=a(3);
    %Z
    a=[x(1,i),y(1,i),z(1,i)]*ZZ;
    x(1,i)=a(1);y(1,i)=a(2);z(1,i)=a(3);
    a=[x(2,i),y(2,i),z(2,i)]*ZZ;
    x(2,i)=a(1);y(2,i)=a(2);z(2,i)=a(3);
%     %ƽ��
%     x(:,i)=x(:,i)+position(1);
%     y(:,i)=y(:,i)+position(2);
%     z(:,i)=z(:,i)+position(3);
end
% h=surf(x,y,z);%���»�ͼ
% hold on
% plot3(position(1),position(2),0,'o')
% hold on
% plot3(200,position(2),position(3),'o')
% hold on
% plot3(position(1),200,position(3),'o')
% axis([-200 200 -200 200 0 500])
% hold off
% grid on
h=surf(x,y,z);
title('��̬')
axis([-20 20 -20 20 -10 10])
end