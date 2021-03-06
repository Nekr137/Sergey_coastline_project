function [x,y,v] = TreatPolygons(pln,pts,h)
p = pts(:,1:2);

% ������ ���������� �����, �������� � �������� �����
in = logical(zeros(length(p),1));

% ��� ������� ������� ���������, ��������� �� � ��� �����-������ �����. 
% ���� ����� ���������, �� ��� ����� ��� ���������� 1.
% ������ ��� ������ ���������� �������� ������������ ��������� � ��������
% �� ������ �������
% INPOLYGON - �������, �����������, ��������� �� ����� � ������� (�������).
% ���������� 1 ���� ��, 0, ���� ���. 
figure(h);
for k = 1:length(pln)
    g = pln(k).data;    % ����� ������
    in = in | inpolygon(p(:,1),p(:,2),g(:,1),g(:,2));   %�������� ���
    plot(g(:,1),g(:,2),'LineWidth',.9);
end
% �� �� ��������� �������, ����� ������ - ��� ��� ���������� ����
x = p(~in,1);   y = p(~in,2);   v = pts(~in,3);
end