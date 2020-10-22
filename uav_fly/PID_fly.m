function [N_UAV,N_record]=PID_fly(UAV,record,s_position,s_angle1,flag)
global dt
ii=record.ii+1;
i=1;
%PID
%高度

P_Z=10;
I_Z=0.2;
D_Z=200;

%水平
P_X_Y=3;
I_X_Y=0.1;
D_X_Y=20;

%角度
P_x_y=.3;
I_x_y=0.01;
D_x_y=40;

%矫正
P_z=100;
I_z=0.1;
D_z=300;

%误差项
e0=[0,0,0,0,0,0,0];%Z X Y y x z
e1=[0,0,0,0,0,0,0];%Z X Y y x z
e2=[0,0,0,0,0,0,0];%Z X Y y x z
du_Z=0;
du_X=0;
du_Y=0;
while(1)
    e2=e1;
    e1=e0;
    e0(1)=s_position(3)-UAV.position(3);
    e0(2)=s_position(1)-UAV.position(1);
    e0(3)=s_position(2)-UAV.position(2);
    
    if i>2
        du_Z=P_Z*  (e0(1)-e1(1))+I_Z*  e0(1)+D_Z*  (e0(1)-2*e1(1)+e2(1));
        du_X=P_X_Y*(e0(2)-e1(2))+I_X_Y*e0(2)+D_X_Y*(e0(2)-2*e1(2)+e2(2));
        du_Y=P_X_Y*(e0(3)-e1(3))+I_X_Y*e0(3)+D_X_Y*(e0(3)-2*e1(3)+e2(3));
    end
    i=i+1;
    %     du_X(du_X>0.1)=0.1;du_X(du_X<-0.1)=-0.1;
    %     du_Y(du_Y>0.1)=0.1;du_Y(du_Y<-0.1)=-0.1;
    %     du_x(du_x>10)=10;du_x(du_x<-10)=-10;
    %     du_y(du_y>10)=10;du_y(du_y<-10)=-10;
    %Z轴调节
    UAV.w=UAV.w+du_Z;
    
    %水平调节
    s_angle1(2)=s_angle1(2)+du_X;
    s_angle1(1)=s_angle1(1)-du_Y;
    s_angle1(s_angle1> 0.4)= 0.4;
    s_angle1(s_angle1<-0.4)=-0.4;
    
    e0(4)=s_angle1(1)-UAV.angle1(1);
    e0(5)=s_angle1(2)-UAV.angle1(2);
    e0(6)=-UAV.angle1(3);
    %悬停
    if (e0(2)<100&&e0(2)>50)
        s_angle1(1)=s_angle1(1)*0.5;
    elseif (e0(2)<50)
        s_angle1(1)=s_angle1(1)*0.1;
    end
    if (e0(3)<100&&e0(3)>50)
        s_angle1(2)=s_angle1(2)*0.5;
    elseif (e0(3)<50)
        s_angle1(2)=s_angle1(2)*0.1;
    end
    
    du_y=P_x_y*(e0(4)-e1(4))+I_x_y*e0(4)+D_x_y*(e0(4)-2*e1(4)+e2(4));
    du_x=P_x_y*(e0(5)-e1(5))+I_x_y*e0(5)+D_x_y*(e0(5)-2*e1(5)+e2(5));
    du_z=P_z*(e0(6)-e1(6))+  I_z*e0(6)+  D_z*  (e0(6)-2*e1(6)+e2(6));
    %         w(2)=w(2)+du_Y;
    %         w(1)=w(1)+du_X;
    
    %     s_angle1(1)=0;
    %x轴转矩调节
    UAV.w(1)=UAV.w(1)+du_y;
    UAV.w(4)=UAV.w(4)+du_y;
    %y轴转矩调节
    UAV.w(3)=UAV.w(3)+du_x;
    UAV.w(4)=UAV.w(4)+du_x;
    %z轴转矩调节
    UAV.w(2)=UAV.w(2)+du_z;
    UAV.w(4)=UAV.w(4)+du_z;
    UAV.w(UAV.w<0)=0;
    
    
    %w=[700 700 700 701];%初始转速
    UAV.f=fm(UAV.w,'X');
    [d_d_angle1_N,d_d_position_N]=fly(UAV.angle1,UAV.d_angle1,UAV.d_position,UAV.f);
    UAV.angle1=UAV.angle1+dt*UAV.d_angle1;
    UAV.d_angle1=UAV.d_angle1+dt.*d_d_angle1_N;
    UAV.position=UAV.position+dt*UAV.d_position;
    UAV.d_position=UAV.d_position+dt*d_d_position_N;
    
    record.angle1(ii,:)=UAV.angle1;
    record.d_angle1(ii,:)=UAV.d_angle1;
    record.d_d_angle1(ii,:)=d_d_angle1_N;
    record.position(ii,:)=UAV.position;
    record.w(ii,:)=UAV.w;
    record.d_position(ii,:)=UAV.position;
    record.ii=ii;
    ii=ii+1;
    if (flag==1)
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
        drawnow
    end
    if UAV.position(3)<0
        break
    elseif sum(abs(e0)<0.1)==7
        break
        %     elseif sum(abs(e0(1:3))<10)==3
        %         break
    end
end
N_UAV=UAV;
N_record=record;
end