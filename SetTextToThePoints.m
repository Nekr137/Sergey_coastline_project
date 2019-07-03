function SetTextToThePoints(x,y,values)
dx = Delta(x);  dy = Delta(y);
text(x+dx/6,y+dy/4,num2str(values,2),'FontSize',7,'Color',[0.4 0.4 0.4]);
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
