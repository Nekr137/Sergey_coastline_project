function Paths = build_tree(coordinates, x, Y, Values )
Paths = {};
[x_idx,y_idx] = coordinates2indices(coordinates,x,Y);
for k = 1:length( x_idx )
    Paths(1) = {[x_idx(k) y_idx(k)]};
end

for r = 1:30
    L = length(Paths); 
    isStop = 1;
    for k = 1:L

        indices = cell2mat(Paths(k));

        x_idx = indices(:,1);            y_idx = indices(:,2);

        [x_idx_new,y_idx_new] = findMaxPointsNear( x_idx(end),y_idx(end), Values );
        [x_idx_new,y_idx_new] = RemoveSameIndices( Paths, x_idx_new, y_idx_new );     
        
        
        for m3 = 1:length(x_idx_new)
            if x_idx_new(m3) > length(x) 
                x_idx_new(m3) = [];
            end
        end
        for m3 = 1:length(y_idx_new)
            if y_idx_new(m3) > size(Y',1) 
                y_idx_new(m3) = [];
            end
        end        
        
        
        if ( ~isempty(x_idx_new) )
            isStop = 0;
        end

        if ~isempty(x_idx_new)
            Paths(k) = {[[x_idx;x_idx_new(1)] [y_idx;y_idx_new(1)] ]};           
        end
        for j = 1:length(x_idx_new)-1
            Paths(end+1) = {[[x_idx;x_idx_new(j+1)] [y_idx;y_idx_new(j+1)] ]};
        end
    end
    if isStop 
       break; 
    end
end

end




function [x_idx_new, y_idx_new] = RemoveSameIndices( Paths, x_idx_new, y_idx_new )
    for k = 1:length(Paths)
        indices = cell2mat(Paths(k));
        x_idx = indices(:,1);
        y_idx = indices(:,2);
        for m = 1:length(x_idx)
           
            for m2 = length(x_idx_new):-1:1
                if x_idx_new(m2) == x_idx(m) && y_idx_new(m2) == y_idx(m)
                    x_idx_new(m2) = [];
                    y_idx_new(m2) = [];
                end
            end
        end
    end
end

function [x_idx,y_idx] = findMaxPointsNear(x_idx,y_idx,Values)
r = 1;
x_idxces = max(1,x_idx-r) : min(length(Values(:,1)),x_idx+r );
y_idxces = max(1,y_idx-r) : min(length(Values(1,:)),y_idx+r);

current_values_matrix = Values(x_idxces,y_idxces);
m = max(max(current_values_matrix));
    
[row,col] = find( current_values_matrix == m );

d_x_idx = row + (r*2+1 - size(current_values_matrix,1))-r-1;
d_y_idx = col + (r*2+1 - size(current_values_matrix,2))-r-1;

x_idx = x_idx + d_x_idx;
y_idx = y_idx + d_y_idx;

end


% create one path
function path = build_path(coordinates, x, Y, Values )
[x_idx,y_idx] = coordinates2indices(coordinates,x,Y);
path = [];
for k = 1:100
    Values(x_idx,y_idx) = 0;
    [x_idx,y_idx] = findOneMaxPointNear(x_idx,y_idx,Values);
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


function [x_idx,y_idx] = findOneMaxPointNear(x_idx,y_idx,Values)
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











