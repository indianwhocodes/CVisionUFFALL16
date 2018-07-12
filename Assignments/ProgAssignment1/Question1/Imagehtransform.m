function [ImOut] = Imagehtransform(I,H)
I1=im2double(I);
[R,C] = size(I);
for i=1:C
       for j=1:R
          vect1 = [j;i;1];
          vect2 = H*vect1;
          vect3 =vect2/vect2(3,1);
          if (vect3(1,1) <0 || vect3(2,1)<0 || vect3(3,1)<0)
           continue;
          else     
          ImOut(round(1+vect3(2,1)),round(1+vect3(1,1)))=I1(i,j);
          end
       end
end 