function retval=min_vals(arrays,amplitude)
  for i=1:length(arrays)
  retval(i)=arrays(1,i);
     for j=2:64
         if(retval(i)<(arrays(j,i)-amplitude))
              retval(i)=arrays(j,i);
         end
     end
  end
end