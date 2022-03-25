function [] = Build_Robot(Robot_name)
L(1)=Link([0,101.5,0,0],'modified');
L(2)=Link([0,79.2,0,-pi/2],'modified');
L(3)=Link([0,-79.2,173,0],'modified');
L(4)=Link([0,79.2,173,0],'modified');
L(5)=Link([0,79.2,0,pi/2],'modified');
L(6)=Link([0,41.7,0,-pi/2],'modified');
 
L(2).offset=-pi/2;
L(4).offset=pi/2;
 
L(1).qlim=[deg2rad(-140) deg2rad(140)];
L(2).qlim=[deg2rad(-90) deg2rad(90)];
L(3).qlim=[deg2rad(-140) deg2rad(140)];
L(4).qlim=[deg2rad(-140) deg2rad(140)];
L(5).qlim=[deg2rad(-140) deg2rad(140)];
L(6).qlim=[deg2rad(-360) deg2rad(360)];
 
Robot_name= SerialLink(L, 'name', 'sixlink');
 
%Robot_name.plot([0 0 0 0 0 0])
%Robot_name.teach
 
Robot_name.display
 
end