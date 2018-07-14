    % 電機碩一  r06921048 李友岐
    k=15;  % k is a input parameter
    Hd=[0,-0.8*1i,-1i*ones(1,k-2),-0.6*1j,0.6*1j,1j*ones(1,k-2),0.8*1i];
    h=fftshift(ifft(Hd));
    x=[-k:k];
    r = 4*10^-3; % resolution
    sb = 0:r:0.1; % stopband     
    pb = 0.1+r:r:0.9; %  passband 
  
    sb2= 0.9+r:r:1.0; % stopband  
    Hd0 = [ zeros(1,length(sb)),ones(1,length(pb)),zeros(1,length(sb2))]; % Ideal band Pass Filter
    x0 = 0:r:1; % range 0~0.5 f/fs
    % Plot two figure
    figure(1)   
    
    plot(x0,Hd0,'-r') ;
    title('The frequency Response ');
    hold on
    rf=zeros(1,length(0:r:1));
   
    fs = 1000;
    Nfft = 128;
    [H,F] = freqz(1,h,Nfft,fs);
    plot(F/fs*2,(H+3.5)/4,'-b') ;    
    xlabel('Frequency  (f / f_s ) ')
    legend('Ideal band pass Filter ','Hilbert band pass filter','Location','northOutside')
    
    figure(2)
    stem(x,h);
    title('The impulse response h[n]');
    legend('h[n]')
