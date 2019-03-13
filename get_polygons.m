function p = get_polygons(b)
k = 1;
len = length(b);
kk = 1;
bb = []; 
num = 1;            % polygon number

while(k<=len) 
   if(b(k,1)-ceil(b(k,1))==0)
       len = length(b);
       try
           if(~isempty(bb))         
               p(num).data = bb;
               num = num+1;
           end
       catch
       end
       k = k+1;       kk = 1;       bb = [];
   else
       bb(kk,:) = b(k,:);       k = k+1;       kk = kk+1;
   end
end
end