%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 函数描述:载入心磁数据、求出相应的参数  全部数据是心脏跳动一个周期数据                                                                                                                                
% 输入参数
    % fpath: MCG .tet文本的加载路径
% Output Argument:%输出参数
    % fmcg: 心磁数据
    % fecg: 心电数据
    % fmeanecg: 心电数据的平均值
    % ftr: R波峰的时间
    % ftt: T波峰的时间
    % ftqrs: QRS复波的开始结束时间
    % ftst: T段的起始和结束时间
% 最后修改时间: 2019-5-16
%*************************************************************************%
 function [ fmcg, fecg, fmeanecg,  ftr, ftt, ftqrs, ftst ] = RealMCG_LoadTXT(fpath)
rawdata = load(fpath);
fmcg = rawdata(:,2:37); %矩阵
fecg = rawdata(:,38:73); %矩阵
flen = size(rawdata,1); % size(A,1)求矩阵A的行数
fmeanecg = mean(fecg,2); % mean(A,2)求行的平均值
fnormmcg = zeros(flen,1);% 生成flen*1的矩阵
fnormecg = zeros(flen,1);
for t = 1:flen  %t为时刻
    fnormmcg(t) = norm(fmcg(t,:));%化为向量，求绝对值的最大值
    fnormecg(t) = norm(fecg(t,:));
end
%如果A是一个矩阵，max(A)将A的每一列作为一个向量，返回一行向量包含了每一列的最大元素
%对应着每个时刻的所有数值的最大值（每个时刻的p峰值）
ftr = find(fnormmcg == max(fnormmcg)); %找出 QRS 峰值对应的时刻 find返回索引（对应该时刻）
ftt = find(fnormmcg == max(fnormmcg(ftr+200:end)));%找出 T 峰值对应的时刻
ftqrs = [ftr-50 ftr+49];   %QRS 波的开始结束时间
ftst = [ftt-66 ftt+33];      % T 波段的起始和结束时间ft
end
