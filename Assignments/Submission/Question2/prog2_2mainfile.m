close all;
clear all;
clc;
%%
%Energy equation of snake=alpha*v(ss)-Beta*v(ssss)+Eext(Image)%
inputpoints=50;
timediff=0.08;
ImageFileName='Pacman.jpg';

I=double(imread(ImageFileName))/255;
I2=rgb2gray(I);

%fprintf('\n Input %d points manually', inputpoints);
%XY2D = Get2DPoints(ImageFileName, inputpoints);x1 = XY2D(1, :);y1 = XY2D(2, :);disp(XY2D);
%%
%For the Pacman Image we have the input points if you want to hardcode the
%points instead of tediously giving the input as 50 points
x1=[180.159735349716,174.110586011342,169.029300567108,164.431947069943,156.447069943289,150.155954631380,142.896975425331,134.670132325142,125.717391304348,117.490548204159,109.021739130435,100.310964083176,91.8421550094518,84.0992438563327,75.3884688090737,65.9517958412098,58.2088846880907,52.1597353497165,45.8686200378072,44.6587901701323,43.4489603024575,44.1748582230624,47.5623818525520,52.1597353497165,63.2901701323251,72.7268431001890,85.5510396975425,93.0519848771266,105.392249527410,117.732514177694,136.363894139887,150.397920604915,155.721172022684,162.254253308129,170.481096408318,178.224007561437,182.821361058601,181.127599243856,176.772211720227,170.723062381853,164.915879017013,159.834593572779,153.059546313800,146.526465028355,147.010396975425,153.301512287335,162.738185255199,173.142722117202,178.465973534972,183.063327032136];
y1=[68.7816901408451,59.7676056338028,53.9084507042253,51.2042253521126,44.8943661971831,42.1901408450704,40.8380281690141,40.8380281690141,39.4859154929577,41.2887323943662,42.6408450704225,43.0915492957746,47.1478873239436,50.3028169014084,57.0633802816901,63.3732394366197,70.1338028169014,80.5000000000000,94.4718309859155,110.697183098592,128.274647887324,143.147887323944,154.415492957746,167.485915492958,185.063380281690,194.077464788732,203.091549295775,203.992957746479,204.443661971831,204.894366197183,203.542253521127,202.640845070423,199.936619718310,197.683098591549,192.725352112676,186.415492957746,174.697183098592,163.880281690141,160.274647887324,155.316901408451,148.105633802817,144.500000000000,135.035211267606,127.823943661972,119.711267605634,111.147887323944,103.035211267606,94.4718309859155,88.1619718309859,75.9929577464789];
xvector=x1(:);
yvector=y1(:);

xvector(end)=xvector(1);
yvector(end)=yvector(1);

%Input Image and Initial Points%
lw=1.25;%linewidth parameter inputted for the plot%
figure, imshow(I), hold on, plot(xvector, yvector, 'r', 'LineWidth',lw), hold off;

%The external force term in the energy equation of the snake related to the gradient of the image (Fexternal=-gradient(Image))%
I2smoothed=imgaussfilt(I2,1.5);
[I2x, I2y]=gradient(I2smoothed);
NormValSquared=(I2x.^2)+(I2y.^2);
[I2SquaredNormxx, I2SquaredNormyy]=gradient(NormValSquared);


%Both of these terms are used in the energy eqn of the snake and multipled by alpha term and beta term respectively%
Order2dd=SecondOrderDiscreteDerivative(inputpoints);
Order4dd=FourthOrderDiscreteDerivative(inputpoints);
alpha=0.5;beta=0.2;

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
    