  warning('off', 'Images:initSize:adjustingMag');
  I1=imread('TestImages/m1.png');  I2=imread('TestImages/m2.png');
  %Options.upright=true;
  Options.tresh=0.0001;
  Ipts1=OpenSurf(I1,Options);
  Ipts2=OpenSurf(I2,Options);
  D1 = reshape([Ipts1.descriptor],64,[]); 
  D2 = reshape([Ipts2.descriptor],64,[]); 
  err=zeros(1,length(Ipts1));
  cor1=1:length(Ipts1); 
  cor2=zeros(1,length(Ipts1));

 %SURF ALGORITHM
 tic;
      for i=1:length(Ipts1),
               x=repmat(D1(:,i),[1 length(Ipts2)]);
               y=(D2-x).^2;
               sum=sum_vals(y);
               [err(i),cor2(i)]=min(sum);
      end
 toc;
 %SURF ALGORITHM

 %THIS PAPER ALGORITHM
 tic;
      for i=1:length(Ipts1),
                 x=repmat(D1(:,i),[1 length(Ipts2)]);
                 y=(D2-x).^2;
                 mins=min_vals(y,0.0000008);
                 [err(i),cor2(i)]=min(mins);
      end
 toc;
 %THIS PAPER ALGORITHM

%SJ
[err, ind]=sort(err); 
cor1=cor1(ind); 
cor2=cor2(ind);
I = zeros([size(I1,1) size(I1,2)*2 size(I1,3)]);
I(:,1:size(I1,2),:)=I1; I(:,size(I1,2)+1:size(I1,2)+size(I2,2),:)=I2;
figure, imshow(I/255); hold on;

for i=1:110,
      c=rand(1,3);
      plot([Ipts1(cor1(i)).x Ipts2(cor2(i)).x+size(I1,2)],[Ipts1(cor1(i)).y Ipts2(cor2(i)).y],'-','Color',c)
      plot([Ipts1(cor1(i)).x Ipts2(cor2(i)).x+size(I1,2)],[Ipts1(cor1(i)).y Ipts2(cor2(i)).y],'o','Color',c)
end