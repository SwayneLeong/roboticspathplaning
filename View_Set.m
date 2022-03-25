function [] = View_Set()
%调整坐标轴及视野
set(gca,'XLim',[-400,400]);  %将X轴范围设定为[-400,400]
set(gca,'YLim',[-500,500]);  %将X轴范围设定为[-500,500]
set(gca,'ZLim',[0,600]);      %将Z轴范围设定为[0,600]，最小值设定为0，可以消除模型下面的长杆
set(gca,'XDir','reverse');    %将x轴方向设置为反向
set(gca,'YDir','reverse');    %将Y轴方向设置为反向
set(gca,'View',[-85,10]);     %设定视野方向角和俯仰角
end