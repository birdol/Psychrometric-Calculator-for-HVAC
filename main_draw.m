clc,clear
B=101325;
dmax=30;
dd=5;
tmin=0;
dt=5;
tmax=50;
%���һ����������0�Ļ������й���ʪͼ��������ASHRAE��ʪͼ��
ID=idDiag(tmin,tmax,dt,dmax,dd);
ID.Drawid;%����������¶Ⱥ����ʪ�Ȱѵ㻭����ʪͼ��
A=[25,50;27,35;22,50];
ID.drawPoints(A);