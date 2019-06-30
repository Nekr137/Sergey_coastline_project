function Value = main
x0 = 73;              
y0 = 72; 
r0 = 1;
r_finish = 15;
step = 0.2;
loops = r0+step:step:r_finish; %loops

% загрузка файлов
b = load('береговая линия.txt');     
points = load('out.dat');

% делаем из одного столбца матрицу
[x,Y,Values] = ConvertData2Matrix(points);  

% извлекаем острова
p = get_polygons(b);
Value = plot_polygon_and_points(p,points,r0,r_finish,step,x0,y0);

% находим пути
path = build_path([70,72],x, Y, Values );   plot(path(:,1),path(:,2),'ro-');
path = build_path([73,72.5],x, Y, Values );   plot(path(:,1),path(:,2),'go-');
path = build_path([70,74.5],x, Y, Values );   plot(path(:,1),path(:,2),'bo-');

% 
figure; plot(loops,Value,'k.-');xlabel('Радиус');ylabel('Сумма');grid;


end

function path = build_path(coordinates, x, Y, Values )
[x_idx,y_idx] = coordinates2indices(coordinates,x,Y);
path = [];
for k = 1:100
    Values(x_idx,y_idx) = 0;
    [x_idx,y_idx] = findMaxNear(x_idx,y_idx,Values);
    if x_idx > length(x) || y_idx > length( Values(1,:) )
       break; 
    end
    path = [path; [x(x_idx) Y(x_idx,y_idx)]];       
end

end

function [x_idx,y_idx] = coordinates2indices(coo,x,Y)
for k = 1:length(Y(1,:))
    distances(:,k) = (Y(:,k)-coo(2)).^2 + (x-coo(1)).^2;
end
m = min(min(distances));
[x_idx,y_idx] = find(distances == m);
end


function [x_idx,y_idx] = findMaxNear(x_idx,y_idx,Values)
r = 1;  % find in square when "radius" == 1; if all values are the same -> increase r
while( true )
    x_idxces = max(1,x_idx-r) : min(length(Values(:,1)),x_idx+r );
    y_idxces = max(1,y_idx-r) : min(length(Values(1,:)),y_idx+r);
    current_values_matrix = Values(x_idxces,y_idxces);
    m = max(max(current_values_matrix));
    
    if( length(find(m==current_values_matrix)) == 1)
        [row,col] = find( current_values_matrix == m );
        x_idx = x_idx + row + (r*2+1 - size(current_values_matrix,1))-r-1;
        y_idx = y_idx + col + (r*2+1 - size(current_values_matrix,2))-r-1;
        break;
    else
        r = r + 1;
    end
end
end

function [x,Y,V] = ConvertData2Matrix(points)
v = points(:,3); % values
[tmp n] = max(points(:,1)); % find first maximum in this periodic function
x = points(1:n,1); % one x row
y = points(:,2);
Y = reshape(y,n,length(y)/n); % cols
V = reshape(v,n,length(v)/n); % values
end









