function XY2D=Get2DPointsa1(ImageFileName, NumberOfPoints)
XY2D=[]; 
[Img, Col]=imread('Wall.jpg'); %%% assuming the imagefile is a jpg file. 
image(Img); drawnow; hold on;
for i=1:NumberOfPoints 
    [x, y]=ginput(1); 
    v=[x;y]; 
    plot(x, y,'r*'); 
    XY2D=[XY2D v]; 
end
return;
%This function is being used for question 1 of the programming assignment-1%