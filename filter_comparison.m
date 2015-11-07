image_path=input('testing image path');
image=imread(image_path);

if(ndims(image)~=3)
error('input is not a RGB image');
end

nx=size(image);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RGB color-space to YCbCr color-space 
X=rgb2ycbcr(image);
for i=1:nx(1)
for j=1:nx(2)
if(X(i,j,2)>=77 && X(i,j,2)<=127 && X(i,j,3)>=133 && X(i,j,3)<=173)
imagex1(i,j)=1;
else
imagex1(i,j)=0;
end
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RGB color-space 1
X=double(image);
for i=1:nx(1)
for j=1:nx(2)
if((X(i,j,1)>95 &&X(i,j,2)>40 && X(i,j,3)>20)...
 &&((max([X(i,j,1),X(i,j,2),X(i,j,3)])-min([X(i,j,1),X(i,j,2),X(i,j,3)]))>15)...
 &&(norm(X(i,j,1)-X(i,j,2))>15)&&(X(i,j,1)>X(i,j,2))&&(X(i,j,1)>X(i,j,3)))
imagex2(i,j)=1;
else
imagex2(i,j)=0;
end
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RGB color-space 2
X=(image);
for i=1:nx(1)
for j=1:nx(2)
if((X(i,j,1)/X(i,j,2))>1.185...
 &&(((X(i,j,1)*X(i,j,3))/(X(i,j,1)+X(i,j,2)+X(i,j,3))^2)>0.107)...
 &&(((X(i,j,1)*X(i,j,2))/(X(i,j,1)+X(i,j,2)+X(i,j,3))^2)>0.112))
imagex3(i,j)=1;
else
imagex3(i,j)=0;
end
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RGB color-space to HSI color-space
HSI=rgb2hsi(image);H=HSI(:,:,1);S=HSI(:,:,2);I=HSI(:,:,3);
 for i=1:nx(1)
     for j=1:nx(2)
 	   if(I(i,j)>40 &&(S(i,j)>13 && S(i,j)<110) && ((H(i,j))>-28 &&  (H(i,j))<28 ))
          imagex4(i,j)=1;
       end
     end
 end
