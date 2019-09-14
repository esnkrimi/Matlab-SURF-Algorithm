function  retval=sum_vals(arrays)
for i=1:length(arrays)
retval(i)=0;
   for j=1:64
         if(arrays(j,i)>0)
               retval(i)=arrays(j,i)+retval(i);
         end     
   end
end
end