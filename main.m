function Value = main
x0 = 73;              
y0 = 72; 
r0 = 1;
r_finish = 15;
step = 0.2;
loops = r0+step:step:r_finish; %loops

%% load data
b = load('береговая линия.txt');     
points = load('out.dat');

%% create matrix from data
[x,Y,Values] = ConvertData2Matrix(points);  

%% extract islands
extracted_polygons = get_polygons(b);

%% find islands and plot them
fig = figure(1); hold on;
[x_array,y_array,values] = TreatPolygons(extracted_polygons,points,fig);

%% init figure and draw circles
xlabel('Долгота');  ylabel('Широта');
draw_circles(x0,y0,r0,r_finish,step);
set(gca,'XLim',[min(points(:,1)) max(points(:,1))]); 
set(gca,'YLim',[min(points(:,2)) max(points(:,2))]);
plot(x_array,y_array,'b.','MarkerSize',0.1);
SetTextToThePoints(x_array,y_array,values);
stripValues = SetRadiiTextLabels(x_array,y_array,values,x0,y0,step,r0,r_finish);

%% count strip values and plot them
figure(2); plot(loops,stripValues,'k.-');xlabel('Радиус');ylabel('Сумма');grid;refreshdata;

%% paths ( via trees )
% init structures
coordinatesFrom = [ 
    struct('coordinate',[70,72],'color',[1 0 0])
    struct('coordinate',[74,75],'color',[0 1 0])
    struct('coordinate',[76,74],'color',[0 0 1])
    struct('coordinate',[76.2 75.1],'color',[0 0 0]) ];

% create trees and plot them
for k = 1:length(coordinatesFrom)
    CreateMapAndBuildTree(coordinatesFrom(k).coordinate, coordinatesFrom(k).color, extracted_polygons,x_array,y_array,points,values,x,Y,Values,figure(k+1000));
    drawnow();
end

end

%%
function CreateMapAndBuildTree(coordinatesFrom,color,extracted_polygons,x_array,y_array,points,values,x,Y,Values,fig)
figure(fig);
hold on;
TreatPolygons(extracted_polygons,points,fig);
xlabel('Долгота');  ylabel('Широта');
set(gca,'XLim',[min(points(:,1)) max(points(:,1))]); 
set(gca,'YLim',[min(points(:,2)) max(points(:,2))]);
plot(x_array,y_array,'b.','MarkerSize',0.1);
SetTextToThePoints(x_array,y_array,values);
Paths = build_tree(coordinatesFrom, x, Y, Values );    
DrawTree( Paths, x, Y, color );
end


% find paths ( variant 1 )
%path = build_path([70,72],x, Y, Values );   plot(path(:,1),path(:,2),'ro-');
%path = build_path([73,72.5],x, Y, Values );   plot(path(:,1),path(:,2),'go-');
%path = build_path([70,74.5],x, Y, Values );   plot(path(:,1),path(:,2),'bo-');