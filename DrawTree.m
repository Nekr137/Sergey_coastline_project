
function DrawTree(Paths, x, Y, color)

for k = 1:length(Paths)
    Path = cell2mat(Paths(k));
    x_idx = Path(:,1); 
    y_idx = Path(:,2);

    try
    xx = x(x_idx);
    yy = Y(x_idx,y_idx);
    yy = yy(1,:);
    plot(xx,yy,'Color',color,'Marker','o','LineWidth',3);
    catch
    end

end

end

