%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% Mini-Max Low Pass Filter %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% 電機碩一   r06921048    李友岐  %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%% Set up parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%
fl = 19 ;  %  Filter Length
k = (fl-1)/2; % k=9
NofEP = k+2; % choose 11 extreme points
freq = 2.5*10^3; % Sampling frequency = 2500 Hz
PassBand = 10^3; % Pass Band = 0~1000 Hz
BandEdge = PassBand/freq; % bandband edge=0.40 f/fs
f1 = 950/freq; % Transition band starts from 0.38 f/fs
f2 = 1050/freq; % Transition band ends to 0.42 f/fs
ws = 0.6; % W(F)=0.6 for stopband 
wp = 1; % W(F)=1 for passband
delta = 0.0001; % delta = 0.0001
ep = [0 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.43 0.45 0.50];% Initial guess 11 extreme points 
r = 4*10^-3; % resolution
x = 0:r:0.5; % range 0~0.5 f/fs
tf = [ones(1,length(0:r:f1)) zeros(1,length(f1+r:r:f2-r)) ones(1,length(f2:r:0.5))];
hv = zeros(NofEP,1); 
Matrix = ones(NofEP,NofEP);
pb = 0:r:BandEdge; % passband 
sb = BandEdge+r:r:0.5; % stopband  
Hd = [ones(1,length(pb)), zeros(1,length(sb))]; % Ideal Low Pass Filter
wf = [wp*ones(1,length(pb)), ws*ones(1,length(sb))]; % weighting function
E1 = 10^6; % Set  E1-> infinite
E0 = 0;    % Set  E0=0
 
for n=1:20 %   After 20 iterations, if it still not converge, then break the for loop    
    for c1=1:NofEP
        
        if (ep(c1)>f1)
            Matrix(c1,NofEP) = (-1)^(c1-1)*1/ws;
        else
            Matrix(c1,NofEP) = (-1)^(c1-1)*1/wp;
        end   
    end 
    for c1 = 1:NofEP
        if(ep(c1)<=BandEdge)
            hv(c1,1) = 1;
        else
            hv(c1,1) = 0;
        end
    end 
    for c2=1:k
        for c1 = 1:NofEP
            Matrix(c1,c2+1) = cos(ep(c1)*2*pi*c2);
        end
    end 
    rf = zeros(1,length(x));
    matrix2 = inv(Matrix)*hv;
    ep2 = matrix2(1:k+1);    
    for c2 = 0:k
        rf = rf + cos(c2*x*2*pi)*matrix2(c2+1);
    end
    errf = (rf - Hd).*tf.*wf;
    [c3,c4] =  findpeaks(abs(errf));
    E0 = max(abs(errf));      
    if length(c4) > NofEP+2
        fprintf(1,'It fail\n');
    else
        ep = zeros(1,NofEP);
        ep(1:length(c4)) =  (c4-1)*r;
        for matrix2=1:NofEP
            if ( ep(matrix2)==f1 || ep(matrix2) == f2)
                ep(matrix2) = 0;
            end
        end
        ep = sort(ep);
    end        
    % Check wther extreme point is on the boundary
    c2 = 1; 
    len = NofEP - length(c4)+2;
    if c2<len+1  % check whether if 0.38 f/fs is extreme point
        if  abs(errf(f1/r))<abs(errf(1+ f1/r))
            ep(c2) = f1; 
            c2 = c2+1;
        end 
    end
    if c2<len+1  % check whether if 0.42 f/fs is extreme point
        if  abs(errf(2+f2/r))<abs(errf(1+ f2/r))
            ep(c2) = f2; 
            c2 = c2+1;
        end 
    end   
    if c2<len+1  % check whether if 0.5 f/fs is extreme point
        if  abs(errf(0.5/r))<abs(errf(1+0.5/r))
            ep(c2) = 0.5; 
            c2 = c2+1;
        end 
    end
    if c2<NofEP+1  % check whether 0 f/fs is extreme point
        if abs(errf(2))<abs(errf(1))
            ep(c2) = 0;
            c2 = c2+1;
        end
    end
    ep = sort(ep);        
    if E1-E0 >= 0 && E1-E0 <= delta % Iteration Stop 
       fprintf(1,'\n');
       fprintf(1,'Iteration  %d, Max(|error|)=%3.4f\t  Converge!\n\nIteration End\n', n, E0);
       break 
    else                           % Iteration Continue
       fprintf(1,'\n');
       fprintf(1,'Iteration  %d, Max(|error|)=%3.4f\t  Continue\n', n, E0);
       E1 = E0;
    end
    
end
k2=1+k;
mh = zeros(1,fl);
for c2 = 1:k2
    mh((k2)-(1-c2)) = ep2(c2)*0.5;
    mh((k2)+(1-c2)) = ep2(c2)*0.5;
end
mh(k2) = mh(k2)*2; 
% Plot two figure
figure(1)
plot(x,rf,'-b')
title('The frequency Response ');
xlabel('Frequency  (f / f_s ) ')
hold on
plot(x,Hd,'-r') 
legend('Mini-Max Filter','Ideal Filter','Location','southwest')
figure(2)
stem(0:fl-1,mh);
title('The impulse response h[n]');
xlabel('Tap(n)')
legend('h[n]')
