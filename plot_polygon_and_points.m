function Value = plot_polygon_and_points(pln,pts,r0,r_finish,step,x0,y0)
p = pts(:,1:2);
figure(1);  
xlabel('Долгота');
ylabel('Широта');
draw_circles(x0,y0,r0,r_finish,step);

% масштаб:
set(gca,'XLim',[min(p(:,1)) max(p(:,1))]);
set(gca,'YLim',[min(p(:,2)) max(p(:,2))]);

% вектор логических нулей, размером с вектором точек
in = logical(zeros(length(p),1));

% Для каждого острова проверяем, находится ли в нем какая-нибудь точка. 
% Если точка находится, то она будет как логическая 1.
% Каждый раз вектор логических значений подвергается операцией с вектором
% от нового острова
% INPOLYGON - фукнция, проверяющая, находится ли точка в области (острове).
% возвращает 1 если да, 0, если нет. 
for k = 1:length(pln)
    g = pln(k).data;    % берем остров
    in = in | inpolygon(p(:,1),p(:,2),g(:,1),g(:,2));   %операция или
    plot(g(:,1),g(:,2),'LineWidth',1.2);
end
% мы не учитываем острова, тогда данные - это где логические нули
x = p(~in,1);   y = p(~in,2);   v = pts(~in,3);

% строим все логические нули 
plot(x,y,'b.','MarkerSize',0.1);

% 
dx = Delta(x);  dy = Delta(y);
v = num2str(v);
text(x+dx/6,y+dy/4,num2str(v),'FontSize',7);


% радиусы
r = sqrt((x-x0).^2 + (y-y0).^2);

strip = 1;
for R = r0+step:step:r_finish    % для каждой дуги
    num = find(r>R-step & r<R);  % эта строчка выдает номера элементов 
                                 % векторов, значения которых лежат в
                                 % диапазоне радиусов
    plot(x(num),y(num),'rx','MarkerSize',1.5);    % выводим
    Value(strip) = sum(v(num));    strip = strip + 1; % суммируем величины 
                                % и увеличиваем индекс на единицу, переходим к следующей полоске
    text(x0,y0+R-step,num2str(Value(strip-1)));
    %pause(0.1); % пауза для визуализации
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
