function Value = main
x0 = 73;              
y0 = 72; 
r0 = 1;
r_finish = 15;
step = 0.2;
loops = r0+step:step:r_finish; %loops

% �������� ������
b = load('��������� �����.txt');     
points = load('out.dat');

% ��������� �������
p = get_polygons(b);
Value = plot_polygon_and_points(p,points,r0,r_finish,step,x0,y0);

figure; plot(loops,Value,'k.-');xlabel('������');ylabel('�����');grid;







