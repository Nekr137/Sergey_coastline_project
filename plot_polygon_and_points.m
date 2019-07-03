function Value = plot_polygon_and_points(pln,pts,r0,r_finish,step,x0,y0)
p = pts(:,1:2);
figure(1);  
xlabel('�������');
ylabel('������');
draw_circles(x0,y0,r0,r_finish,step);

% �������:
set(gca,'XLim',[min(p(:,1)) max(p(:,1))]);
set(gca,'YLim',[min(p(:,2)) max(p(:,2))]);

% ������ ���������� �����, �������� � �������� �����
in = logical(zeros(length(p),1));

% ��� ������� ������� ���������, ��������� �� � ��� �����-������ �����. 
% ���� ����� ���������, �� ��� ����� ��� ���������� 1.
% ������ ��� ������ ���������� �������� ������������ ��������� � ��������
% �� ������ �������
% INPOLYGON - �������, �����������, ��������� �� ����� � ������� (�������).
% ���������� 1 ���� ��, 0, ���� ���. 
for k = 1:length(pln)
    g = pln(k).data;    % ����� ������
    in = in | inpolygon(p(:,1),p(:,2),g(:,1),g(:,2));   %�������� ���
    plot(g(:,1),g(:,2),'LineWidth',1.2);
end
% �� �� ��������� �������, ����� ������ - ��� ��� ���������� ����
x = p(~in,1);   y = p(~in,2);   v = pts(~in,3);

% ������ ��� ���������� ���� 
plot(x,y,'b.','MarkerSize',0.1);

% 
dx = Delta(x);  dy = Delta(y);
v = num2str(v);
text(x+dx/6,y+dy/4,num2str(v),'FontSize',7);


% �������
r = sqrt((x-x0).^2 + (y-y0).^2);

strip = 1;
for R = r0+step:step:r_finish    % ��� ������ ����
    num = find(r>R-step & r<R);  % ��� ������� ������ ������ ��������� 
                                 % ��������, �������� ������� ����� �
                                 % ��������� ��������
    plot(x(num),y(num),'rx','MarkerSize',1.5);    % �������
    Value(strip) = sum(v(num));    strip = strip + 1; % ��������� �������� 
                                % � ����������� ������ �� �������, ��������� � ��������� �������
    text(x0,y0+R-step,num2str(Value(strip-1)));
    %pause(0.1); % ����� ��� ������������
end
end


function [dx] = Delta(x)
x = sort(x);k = 1;g = 1;r = 1;
while(k<length(x))
    while((x(k)-x(g))==0 && k<length(x))
        k=k+1;
    end
    g = k;
    X(r) = x(g);
    r=r+1;
end
dx = sum(diff(X))/length(X);
end
