close all;
clear all;
clc;
%%
%Energy equation of snake=alpha*v(ss)-Beta*v(ssss)+Eext(Image)%
inputpoints=50;
timediff=0.03;
ImageFileName='Square.jpg';
I2=double(imread(ImageFileName))/255;

%fprintf('\n Input %d points manually', inputpoints);
%XY2D = Get2DPoints(ImageFileName, inputpoints);x1 = XY2D(1, :);y1 = XY2D(2, :);disp(XY2D);
%%
%For the Square Image we have the input points if you want to hardcode the
%points instead of tediously giving the input as 50 points
x1=[215.486767485822,204.598298676749,191.532136105860,181.611531190926,174.352551984877,160.076559546314,148.946124763705,136.847826086957,124.749527410208,108.295841209830,98.6172022684310,82.8894139886579,62.8062381852552,50.2240075614367,34.4962192816635,33.5283553875236,33.2863894139887,33.0444234404537,33.0444234404537,32.5604914933837,32.5604914933837,32.5604914933837,34.9801512287335,52.4017013232514,64.7419659735350,76.5982986767486,83.8572778827977,100.068998109641,114.103024574669,127.169187145558,139.267485822306,152.575614366730,168.061436672968,179.433837429112,191.290170132325,206.775992438563,215.486767485822,220.084120982987,221.293950850662,222.745746691871,222.987712665406,222.987712665406,222.987712665406,222.987712665406,222.745746691871,222.745746691871,222.745746691871,222.987712665406,222.987712665406,220.326086956522];
y1=[34.5281690140845,33.6267605633803,34.0774647887324,34.0774647887324,34.0774647887324,33.6267605633803,32.7253521126760,32.7253521126760,32.7253521126760,32.7253521126760,32.2746478873239,30.0211267605634,31.8239436619718,33.6267605633803,33.6267605633803,61.1197183098591,92.2183098591549,118.359154929577,142.246478873239,164.781690140845,186.866197183099,206.697183098592,222.021126760563,225.176056338028,225.176056338028,225.626760563380,225.626760563380,228.781690140845,227.429577464789,227.429577464789,226.978873239437,227.429577464789,226.077464788732,226.077464788732,227.880281690141,227.880281690141,227.880281690141,226.077464788732,197.232394366197,171.542253521127,141.795774647887,130.978873239437,120.161971830986,105.288732394366,93.5704225352113,75.0915492957746,64.7253521126760,50.7535211267605,39.4859154929577,35.8802816901408];
xvector=x1(:);
yvector=y1(:);

xvector(end)=xvector(1);
yvector(end)=yvector(1);

%Input Image and Initial Points%
lw=1.25;%linewidth parameter inputted for the plot%
figure, imshow(I2), hold on, plot(xvector, yvector, 'r', 'LineWidth',lw), hold off;

%The external force term in the energy equation of the snake related to the gradient of the image (Fexternal=-gradient(Image))%
I2smoothed=imgaussfilt(I2,1.5);
[I2x, I2y]=gradient(I2smoothed);
NormValSquared=(I2x.^2)+(I2y.^2);
[I2SquaredNormxx, I2SquaredNormyy]=gradient(NormValSquared);


%Both of these terms are used in the energy eqn of the snake and multipled by alpha term and beta term respectively%
Order2dd=SecondOrderDiscreteDerivative(inputpoints);
Order4dd=FourthOrderDiscreteDerivative(inputpoints);
alpha=1.3;beta=0.8;

E= eye(inputpoints)+timediff*(-alpha*Order2dd+beta*Order4dd);
Einverse=inv(E);
%Some parameters that need to be initialized before the loop is made%
iterationmax=150;delta=4500;iterationdiff=50;
hold on;
%Iteration Loop%
for iterations=1:iterationmax
    interpolatedxvalues=interp2(I2SquaredNormxx,xvector,yvector);
    interpolatedyvalues=interp2(I2SquaredNormyy,xvector,yvector);
    interpolatedvectorx=interpolatedxvalues(:);
    interpolatedvectory=interpolatedyvalues(:);
    
    itm1=xvector+timediff*delta*interpolatedvectorx;
    itm2=yvector+timediff*delta*interpolatedvectory;
    
    xvector = E\itm1;
    yvector = E\itm2;
    xvector(end) = xvector(1); 
    yvector(end) = yvector(1);
        
        if(mod(iterations,iterationdiff) == 0)
            plot(xvector, yvector, 'LineWidth',lw);
        end
        
        
end
if(mod(iterationmax,iterationdiff)==0)
        legend('Stages', 'First', 'Second', 'Final');
end
    hold off;
    