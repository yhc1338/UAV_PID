function [d_d_angle1_N,d_d_position_N]=fly(angle1,d_angle1,d_position,f)
global m k g I J l;
d_d_angle1_N=[d_angle1(2)*d_angle1(3)*(I(2)-I(3))/I(1)-J/I(1)*d_angle1(2)*f(5)+l/I(1)*f(2)-l*k(4)/m*d_angle1(1)
              d_angle1(1)*d_angle1(3)*(I(3)-I(1))/I(2)+J/I(2)*d_angle1(1)*f(5)+l/I(2)*f(3)-l*k(5)/m*d_angle1(2)
              d_angle1(1)*d_angle1(2)*(I(1)-I(2))/I(3)+                        l/I(3)*f(4)-  k(6)/m*d_angle1(3)]';   
d_d_position_N=[(cos(angle1(1))*sin(angle1(2))*cos(angle1(3))+sin(angle1(1))*sin(angle1(3)))*f(1)/m-  k(1)/m*d_position(1)
                (cos(angle1(1))*sin(angle1(2))*sin(angle1(3))-sin(angle1(1))*cos(angle1(3)))*f(1)/m-  k(2)/m*d_position(2)
                 cos(angle1(1))*cos(angle1(2))*                                              f(1)/m-g-k(3)/m*d_position(3)]';
end
       