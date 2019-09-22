%**********************************************%
    % % 利用实际测量的真实心磁数据画出所需要的图形便于观察
%*****************************
%%  载入数据
clc;
clear all;
% close all;
%fpath = '11-12-2005_10Average.txt'
Path = 'E:\MATLAB2018b\mDocuments\RealMCG\2002-9-10数据\';                   % 设置数据存放的文件夹路径
File = dir(fullfile(Path,'*.txt'));  % 显示文件夹下所有符合后缀名为.txt文件的完整信息
FileNames = {File.name}';            % 提取符合后缀名为.txt的所有文件的文件名，转换为n行1列
Length_Names = size(FileNames,1);    % 获取所提取数据文件的个数
for k = 1 : Length_Names
    % 连接路径和文件名得到完整的文件路径
    K_Trace = strcat(Path, FileNames(k));
    % 读取数据（因为这里是.txt格式数据，所以直接用load()函数)
%     K_Trace{1,1}
    % 注意1：eval()函数是括号内的内容按照命令行执行，
    %       即eval(['a','=''2','+','3',';'])实质为a = 2 + 3;
    % 注意2：由于K_Trace是元胞数组格式，需要加{1,1}才能得到字符串

[ MCG, ECG, MEAN_ECG,  TR, TT, TQRS, TST ] = RealMCG_LoadTXT( K_Trace{1,1}); %RealMCG_LoadTXT
%% 成像方式 手动输入参数
Line_2D = 2;        %[ 0 1 2 3 4  ] 0 单通道心磁数据图, 1多通道心磁图，2 实测数据等磁场图
                                               % 3 多通道心电图，4心电平均值图                                       %*********请手动输入*********%
Line_T = 1;       %[ 0 1 ]   0 表示不画标志线、1 表示画标志线     %*********请手动输入*********%
%
Max_Min = 0;      %[ 0 1 ]  0 表示不归一化处理、1 表示归一化处理     %*********请手动输入*********%
%
Level_num = 10;         %等高线等级，即步长    %*********请手动输入*********%
%
MIN_Plot = TR;        % 所要画图的时刻  %*********请手动输入*********%
MAX_Plot = TR;

%% 画出36通道实测心磁图
if Line_2D == 1  % 1多通道心磁图
    [data_len, data_wid]=size(MCG);
    fmcg=(MCG./300)*1e-11;
    MCG_min=1.5*min(min(fmcg));
    MCG_max=1.5*max(max(fmcg));
    figure(2);clf; hold on; grid on; box on
    plot(fmcg);
    axis([0,800,MCG_min,MCG_max]); %[x_min,x_max,y_min,y_max]
    set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',0.5);%把网格线改成虚线
%
     if Line_T == 1  %画标志线
        plot([TR,TR],[MCG_min,MCG_max],'k--','LineWidth',1) %画竖线
%         plot([365,365],[MCG_min,MCG_max],'k--','LineWidth',1) %画竖线
%         plot([390,390],[MCG_min,MCG_max],'k--','LineWidth',1) %画竖线
%         plot([490,490],[MCG_min,MCG_max],'k--','LineWidth',1) %画竖线
%         plot([680,680],[MCG_min,MCG_max],'k--','LineWidth',1) %画竖线
%         plot([780,780],[MCG_min,MCG_max],'k--','LineWidth',1) %画竖线
%            text(680,5e-11,'\fontsize{15}\leftarrow\rm ST-T \fontname{隶书}')
     end
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',0.5,'FontName','arial','FontSize',12 ,'LineWidth',1);%把网格线改成虚线
% text(30,5*1e-11,'(d1)','FontSize',12);
title('(b)')
    xlabel('t (ms)','fontsize',14);
    ylabel('MCG (T)','fontsize',14);
end
%% 画出36通道的等磁场图
if Line_2D == 2
    [data_len, data_wid]=size(MCG);
    fmcg=(MCG./300)*1e-11;
    MCG_min=1.5*min(min(fmcg));
    MCG_max=1.5*max(max(fmcg));
    for at=TR
         disp(['[','time: ',int2str(at),']']); %disp函数会直接将内容输出在Matlab命令窗口中
         figure(3);clf; hold on; grid on; box on; axis ij
         if Max_Min == 0          %是否归一化处理
               a = contourf(reshape(fmcg(at,:),sqrt(data_wid),sqrt(data_wid)),Level_num); 
        elseif Max_Min == 1
                 data_sq = reshape(fmcg(at,:),sqrt(data_wid),sqrt(data_wid));
                 a = contourf(data_sq/max(max(data_sq)),[0:0.1:1]);  
         end
%          set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1);%把网格线改成虚线 
         set(gca,'xlim',[1 6],'ylim',[1 6],'xtick',[1:1.25:6],'ytick',[1:1.25:6],'xticklabel',[0:5:20],'yticklabel',[0:5:20],...
               'FontName','Times New Roman','FontSize',12 ,'LineWidth',1,'layer','top','TickDir','in');   %设置坐标轴
%          title('(g1)');
%          text(6,7,strcat(num2str(at),'ms'),'FontSize',16,'fontweight','bold');
         xlabel('x/cm','fontsize',18);
         ylabel('y/cm','fontsize',18);
         pause(0.1)%图像显示延时时长
         colormap('summer');%18种 季节（summer，autumn，winter，spring）温度（hot，cool）材质（bone，copper）hues（pink，gray）
                          %颜色空间（hsv，colorcube-sort of）还有一些古怪的名字，例如jet，lines，prism，flag，parula
%          str0 = 'E:\MATLAB2018b\mDocuments\RealMCG\R波\'
%          str1 = '波'
%          str2 = '.png'
%          save_path = [str0,str1,str2]
%          imwrite(a ,save_path)
        f=getframe(gca);
        imwrite(f.cdata,['E:\MATLAB2018b\mDocuments\RealMCG\R波\',int2str(k+197),'.jpg']);
    end
end
end


