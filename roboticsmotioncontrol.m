% DH建模部分 设定各轴参数，参数顺序为theta、d、a、alpha
L(1)=Link([0,101.5,0,0],'modified');
L(2)=Link([-pi/2,79.2,0,-pi/2],'modified');
L(3)=Link([0,-79.2,173,0],'modified');
L(4)=Link([pi/2,79.2,173,0],'modified');
L(5)=Link([0,79.2,0,pi/2],'modified');
L(6)=Link([0,41.7,0,-pi/2],'modified');

%设定关节变量偏移量
L(2).offset=-pi/2;
L(4).offset=pi/2;


%建立机械臂模型
myrobot= SerialLink(L, 'name', 'sixlink');

%显示建立的机器人模型
%myrobot.plot([0 0 0 0 0 0])
myrobot.teach

%打印出机器人模型的信息
myrobot.display

%调整坐标轴及视野
set(gca,'XLim',[-400,400]);  %将X轴范围设定为[-400,400]
set(gca,'YLim',[-500,500]);  %将X轴范围设定为[-500,500]
set(gca,'ZLim',[0,600]);      %将Z轴范围设定为[0,600]，最小值设定为0，可以消除模型下面的长杆
set(gca,'XDir','reverse');    %将x轴方向设置为反向
set(gca,'YDir','reverse');    %将Y轴方向设置为反向
set(gca,'View',[-85,10]);     %设定视野方向角和俯仰角
 
%设定关节变量范围
L(1).qlim=[deg2rad(-140) deg2rad(140)];
L(2).qlim=[deg2rad(-90) deg2rad(90)];
L(3).qlim=[deg2rad(-140) deg2rad(140)];
L(4).qlim=[deg2rad(-140) deg2rad(140)];
L(5).qlim=[deg2rad(-140) deg2rad(140)];
L(6).qlim=[deg2rad(-360) deg2rad(360)];


%正运动学求解
theta_0=[0,0,0,0,0,0];
theta_1=[pi/4,0,pi/3,-pi/3,0,0];
T0=myrobot.fkine(theta_0);
T1=myrobot.fkine(theta_1);
% figure(2)
% myrobot.plot(theta_0)
% View_Set()
% myrobot.plot(theta_1)   %可在此处设置一断点进行观察
% View_Set()
 
 
%逆运动学求解
theta_0_0=myrobot.ikine(T0);   %数值解
theta_1_1=myrobot.ikine(T1);
% myrobot.teach
%myrobot.plot(theta_1)
% View_Set()
% myrobot.plot(theta_1_1)   %可在此处设置一断点进行观察% View_Set()
 
%创建一个跟之前相同的机械臂，取名为myrobot2
syms myrobot2
Build_Robot(myrobot2)
 
%轨迹规划部分
%首先我们先规划之前得到的两个位姿之间的轨迹
t=[0:0.05:4];   %设定步数
p=mtraj(@tpoly, theta_0_0, theta_1_1, 100);
p1=mtraj(@lspb, theta_0_0, theta_1_1, 100);
[q,dq,ddq]=mtraj(@tpoly, theta_0_0, theta_1_1, 100); 
[q2,dq2,ddq2]=mtraj(@lspb, theta_0_0, theta_1_1, 100);
subplot(6,3,[1 4 7  2 5 8 10 13 16  11 14 17])
myrobot.plot([0 0 0 0 0 0])
View_Set()
myrobot.plot(p)
myrobot.plot(p1)
subplot(6,3,3)
plot(q)
subplot(6,3,6)
plot(dq)
subplot(6,3,9)
plot(ddq)
subplot(6,3,12)
plot(q2)
subplot(6,3,15)
plot(dq2)
subplot(6,3,18)
plot(ddq2)
 
 
%将之前绘制的图像关掉，不想关掉的话注释掉下一行程序
close all
 
 
%将轨迹创建生成视频
out=VideoWriter('myrobot.avi');
out.FrameRate=10;
open(out);
myrobot.plot([0 0 0 0 0 0])
View_Set()
for K=1:100
    myrobot.plot(p(K,:))
    F=getframe(gcf);
    writeVideo(out,F);
end
 
close(out);