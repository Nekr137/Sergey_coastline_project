function Value = main
x0 = 73;              
y0 = 72; 
r0 = 1;
r_finish = 15;
step = 0.2;
loops = r0+step:step:r_finish; %loops

% load data
b = load('береговая линия.txt');     
points = load('out.dat');

% make matrix from data
[x,Y,Values] = ConvertData2Matrix(points);  

% extract islands
p = get_polygons(b);
Value = plot_polygon_and_points(p,points,r0,r_finish,step,x0,y0);

% find paths ( variant 1 )
%path = build_path([70,72],x, Y, Values );   plot(path(:,1),path(:,2),'ro-');
%path = build_path([73,72.5],x, Y, Values );   plot(path(:,1),path(:,2),'go-');
%path = build_path([70,74.5],x, Y, Values );   plot(path(:,1),path(:,2),'bo-');

% find paths ( variant 2 with trees )
Paths = build_tree([70, 72], x, Y, Values );    DrawTree( Paths, x, Y, [1 0 0] );
Paths = build_tree([74, 75], x, Y, Values );    DrawTree( Paths, x, Y, [0 1 0] );
Paths = build_tree([76, 74], x, Y, Values );    DrawTree( Paths, x, Y, [0 0 1] );
Paths = build_tree([76.2, 75.1], x, Y, Values );    DrawTree( Paths, x, Y, [0 0 0] );

figure; plot(loops,Value,'k.-');xlabel('Радиус');ylabel('Сумма');grid;


end


function [x,Y,V] = ConvertData2Matrix(points)
v = points(:,3); % values
[tmp n] = max(points(:,1)); % find first maximum in this periodic function
x = points(1:n,1); % one x row
y = points(:,2);
Y = reshape(y,n,length(y)/n); % cols
V = reshape(v,n,length(v)/n); % values
end