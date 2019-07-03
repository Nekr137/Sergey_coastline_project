function [x,Y,V] = ConvertData2Matrix(points)
v = points(:,3); % values
[tmp,n] = max(points(:,1)); % find first maximum in this periodic function
x = points(1:n,1); % one x row
y = points(:,2);
Y = reshape(y,n,length(y)/n); % cols
V = reshape(v,n,length(v)/n); % values
end