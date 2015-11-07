function [New ] = skin_detection( image )
% transform the image into HUE-SATURATION-INTENSTY model
% segment skin region
nx=size(image);
if(nx(3)~=3)
error('Not a Color(RGB) image');
end
R=image(:,:,1);
G=image(:,:,2);
B=image(:,:,3);

R=double(image(:,:,1));
G=double(image(:,:,2));
B=double(image(:,:,3));
L=@(x)105*log10(x+1);
for i=1:nx(1)
for j=1:nx(2)
I(i,j)=(L(R(i,j))+L(G(i,j))+L(B(i,j)))/3;
Rg(i,j)=L(R(i,j))-L(G(i,j));
By(i,j)=L(B(i,j))-(L(R(i,j))+L(G(i,j)))/2;
end
end

Scale=round((nx(1)+nx(2))/320);

I=I-medfilt2(I,[8*2*Scale+1 8*2*Scale+1]);
I=medfilt2(I,[16*2*Scale+1 16*2*Scale+1]);
hue = (atan2(Rg,By));
saturation = sqrt(Rg.^2+By.^2);

New=zeros(nx(1),nx(2),3);
for i=1:nx(1)
for j=1:nx(2)
if(I(i,j)<4.5&(hue(i,j)>(2*pi)/3 & hue(i,j)<(8*pi)/9) & (saturation(i,j)>10 & saturation(i,j)<60))
if((hue(i,j)>(11*pi)/18 & hue(i,j)<pi) & (saturation(i,j)>0 & saturation(i,j)<130))
New(i,j,:)=image(i,j,:);
end
end
end
end
imshow(uint8(New));

end

