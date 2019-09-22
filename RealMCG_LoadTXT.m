%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��������:�����Ĵ����ݡ������Ӧ�Ĳ���  ȫ����������������һ����������                                                                                                                                
% �������
    % fpath: MCG .tet�ı��ļ���·��
% Output Argument:%�������
    % fmcg: �Ĵ�����
    % fecg: �ĵ�����
    % fmeanecg: �ĵ����ݵ�ƽ��ֵ
    % ftr: R�����ʱ��
    % ftt: T�����ʱ��
    % ftqrs: QRS�����Ŀ�ʼ����ʱ��
    % ftst: T�ε���ʼ�ͽ���ʱ��
% ����޸�ʱ��: 2019-5-16
%*************************************************************************%
 function [ fmcg, fecg, fmeanecg,  ftr, ftt, ftqrs, ftst ] = RealMCG_LoadTXT(fpath)
rawdata = load(fpath);
fmcg = rawdata(:,2:37); %����
fecg = rawdata(:,38:73); %����
flen = size(rawdata,1); % size(A,1)�����A������
fmeanecg = mean(fecg,2); % mean(A,2)���е�ƽ��ֵ
fnormmcg = zeros(flen,1);% ����flen*1�ľ���
fnormecg = zeros(flen,1);
for t = 1:flen  %tΪʱ��
    fnormmcg(t) = norm(fmcg(t,:));%��Ϊ�����������ֵ�����ֵ
    fnormecg(t) = norm(fecg(t,:));
end
%���A��һ������max(A)��A��ÿһ����Ϊһ������������һ������������ÿһ�е����Ԫ��
%��Ӧ��ÿ��ʱ�̵�������ֵ�����ֵ��ÿ��ʱ�̵�p��ֵ��
ftr = find(fnormmcg == max(fnormmcg)); %�ҳ� QRS ��ֵ��Ӧ��ʱ�� find������������Ӧ��ʱ�̣�
ftt = find(fnormmcg == max(fnormmcg(ftr+200:end)));%�ҳ� T ��ֵ��Ӧ��ʱ��
ftqrs = [ftr-50 ftr+49];   %QRS ���Ŀ�ʼ����ʱ��
ftst = [ftt-66 ftt+33];      % T ���ε���ʼ�ͽ���ʱ��ft
end
