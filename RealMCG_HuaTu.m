%**********************************************%
    % % ����ʵ�ʲ�������ʵ�Ĵ����ݻ�������Ҫ��ͼ�α��ڹ۲�
%*****************************
%%  ��������
clc;
clear all;
% close all;
%fpath = '11-12-2005_10Average.txt'
Path = 'E:\MATLAB2018b\mDocuments\RealMCG\2002-9-10����\';                   % �������ݴ�ŵ��ļ���·��
File = dir(fullfile(Path,'*.txt'));  % ��ʾ�ļ��������з��Ϻ�׺��Ϊ.txt�ļ���������Ϣ
FileNames = {File.name}';            % ��ȡ���Ϻ�׺��Ϊ.txt�������ļ����ļ�����ת��Ϊn��1��
Length_Names = size(FileNames,1);    % ��ȡ����ȡ�����ļ��ĸ���
for k = 1 : Length_Names
    % ����·�����ļ����õ��������ļ�·��
    K_Trace = strcat(Path, FileNames(k));
    % ��ȡ���ݣ���Ϊ������.txt��ʽ���ݣ�����ֱ����load()����)
%     K_Trace{1,1}
    % ע��1��eval()�����������ڵ����ݰ���������ִ�У�
    %       ��eval(['a','=''2','+','3',';'])ʵ��Ϊa = 2 + 3;
    % ע��2������K_Trace��Ԫ�������ʽ����Ҫ��{1,1}���ܵõ��ַ���

[ MCG, ECG, MEAN_ECG,  TR, TT, TQRS, TST ] = RealMCG_LoadTXT( K_Trace{1,1}); %RealMCG_LoadTXT
%% ����ʽ �ֶ��������
Line_2D = 2;        %[ 0 1 2 3 4  ] 0 ��ͨ���Ĵ�����ͼ, 1��ͨ���Ĵ�ͼ��2 ʵ�����ݵȴų�ͼ
                                               % 3 ��ͨ���ĵ�ͼ��4�ĵ�ƽ��ֵͼ                                       %*********���ֶ�����*********%
Line_T = 1;       %[ 0 1 ]   0 ��ʾ������־�ߡ�1 ��ʾ����־��     %*********���ֶ�����*********%
%
Max_Min = 0;      %[ 0 1 ]  0 ��ʾ����һ������1 ��ʾ��һ������     %*********���ֶ�����*********%
%
Level_num = 10;         %�ȸ��ߵȼ���������    %*********���ֶ�����*********%
%
MIN_Plot = TR;        % ��Ҫ��ͼ��ʱ��  %*********���ֶ�����*********%
MAX_Plot = TR;

%% ����36ͨ��ʵ���Ĵ�ͼ
if Line_2D == 1  % 1��ͨ���Ĵ�ͼ
    [data_len, data_wid]=size(MCG);
    fmcg=(MCG./300)*1e-11;
    MCG_min=1.5*min(min(fmcg));
    MCG_max=1.5*max(max(fmcg));
    figure(2);clf; hold on; grid on; box on
    plot(fmcg);
    axis([0,800,MCG_min,MCG_max]); %[x_min,x_max,y_min,y_max]
    set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',0.5);%�������߸ĳ�����
%
     if Line_T == 1  %����־��
        plot([TR,TR],[MCG_min,MCG_max],'k--','LineWidth',1) %������
%         plot([365,365],[MCG_min,MCG_max],'k--','LineWidth',1) %������
%         plot([390,390],[MCG_min,MCG_max],'k--','LineWidth',1) %������
%         plot([490,490],[MCG_min,MCG_max],'k--','LineWidth',1) %������
%         plot([680,680],[MCG_min,MCG_max],'k--','LineWidth',1) %������
%         plot([780,780],[MCG_min,MCG_max],'k--','LineWidth',1) %������
%            text(680,5e-11,'\fontsize{15}\leftarrow\rm ST-T \fontname{����}')
     end
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',0.5,'FontName','arial','FontSize',12 ,'LineWidth',1);%�������߸ĳ�����
% text(30,5*1e-11,'(d1)','FontSize',12);
title('(b)')
    xlabel('t (ms)','fontsize',14);
    ylabel('MCG (T)','fontsize',14);
end
%% ����36ͨ���ĵȴų�ͼ
if Line_2D == 2
    [data_len, data_wid]=size(MCG);
    fmcg=(MCG./300)*1e-11;
    MCG_min=1.5*min(min(fmcg));
    MCG_max=1.5*max(max(fmcg));
    for at=TR
         disp(['[','time: ',int2str(at),']']); %disp������ֱ�ӽ����������Matlab�������
         figure(3);clf; hold on; grid on; box on; axis ij
         if Max_Min == 0          %�Ƿ��һ������
               a = contourf(reshape(fmcg(at,:),sqrt(data_wid),sqrt(data_wid)),Level_num); 
        elseif Max_Min == 1
                 data_sq = reshape(fmcg(at,:),sqrt(data_wid),sqrt(data_wid));
                 a = contourf(data_sq/max(max(data_sq)),[0:0.1:1]);  
         end
%          set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1);%�������߸ĳ����� 
         set(gca,'xlim',[1 6],'ylim',[1 6],'xtick',[1:1.25:6],'ytick',[1:1.25:6],'xticklabel',[0:5:20],'yticklabel',[0:5:20],...
               'FontName','Times New Roman','FontSize',12 ,'LineWidth',1,'layer','top','TickDir','in');   %����������
%          title('(g1)');
%          text(6,7,strcat(num2str(at),'ms'),'FontSize',16,'fontweight','bold');
         xlabel('x/cm','fontsize',18);
         ylabel('y/cm','fontsize',18);
         pause(0.1)%ͼ����ʾ��ʱʱ��
         colormap('summer');%18�� ���ڣ�summer��autumn��winter��spring���¶ȣ�hot��cool�����ʣ�bone��copper��hues��pink��gray��
                          %��ɫ�ռ䣨hsv��colorcube-sort of������һЩ�Źֵ����֣�����jet��lines��prism��flag��parula
%          str0 = 'E:\MATLAB2018b\mDocuments\RealMCG\R��\'
%          str1 = '��'
%          str2 = '.png'
%          save_path = [str0,str1,str2]
%          imwrite(a ,save_path)
        f=getframe(gca);
        imwrite(f.cdata,['E:\MATLAB2018b\mDocuments\RealMCG\R��\',int2str(k+197),'.jpg']);
    end
end
end


