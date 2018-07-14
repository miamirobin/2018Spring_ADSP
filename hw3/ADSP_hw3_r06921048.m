%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% HW3 (1)                   %%%   
%%% r06921048  電機碩一 李友岐   %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A=im2double(imread('/home/jameslee/Downloads/1.jpg'));
% The path should be modified under different environment
[X, Y, Z] = size(A); 
T = zeros(X,Y,Z);

%Compute  Y Cb Cr
Matrix = [0.299 0.587 0.114;-0.169 -0.331 0.5;0.5 -0.419 -0.081];
T(:,:,1) = 0.299 * A(:,:,1) + 0.587 * A(:,:,2) + 0.114 * A(:,:,3); 
T(:,:,2) = -0.169 * A(:,:,1) - 0.331 * A(:,:,2) + 0.5 * A(:,:,3); 
T(:,:,3) = 0.5 * A(:,:,1) - 0.419 * A(:,:,2) - 0.081 * A(:,:,3);  
figure(1)
image(double(A));
title('A:  input color image ');
% 4:2:0 compression
B1 = T(:,:,1);
T2 = T(1:2:end,:,2);
B2 = T2(:,1:2:end);
T3 = T(1:2:end,:,3);
B3 = T3(:,1:2:end);

% Reconstructed image
D1 = B1;
if mod(Y,2)==0
    C2 = zeros(size(B2,1),size(B2,2)*2);
    C3 = zeros(size(B3,1),size(B3,2)*2);
    Temp1 = (B2(:,1:end)+[B2(:,2:end) B2(:,end)])/2.0;
    Temp2 = (B3(:,1:end)+[B3(:,2:end) B3(:,end)])/2.0;
    C2(:,1:2:end) = B2;    
    C3(:,1:2:end) = B3;  
    C2(:,2:2:end) = Temp1;
    C3(:,2:2:end) = Temp2;    
    D2 = zeros(size(C2,1)*2,size(C2,2));
    D3 = zeros(size(C3,1)*2,size(C3,2));
    Temp3 = (C2(1:end,:)+[C2(2:end,:);C2(end,:)])/2.0;
    Temp4 = (C3(1:end,:)+[C3(2:end,:);C3(end,:)])/2.0;
    D2(1:2:end,:) = C2;    
    D3(1:2:end,:) = C3; 
    D2(2:2:end,:) = Temp3;     
    D3(2:2:end,:) = Temp4;    
   
else
    
    C2 = zeros(size(B2,1),size(B2,2)*2-1);
    C3 = zeros(size(B3,1),size(B3,2)*2-1);
    Temp1 = (B2(:,1:end-1)+B2(:,2:end))/2.0;
    Temp2 = (B3(:,1:end-1)+B3(:,2:end))/2.0;
    C2(:,1:2:end) = B2;    
    C3(:,1:2:end) = B3;  
    C2(:,2:2:end) = Temp1;
    C3(:,2:2:end) = Temp2;    
    D2 = zeros(size(C2,1)*2-1,size(C2,2));
    D3 = zeros(size(C3,1)*2-1,size(C3,2));
    Temp3 = (C2(1:end-1,:)+C2(2:end,:))/2.0;
    Temp4 = (C3(1:end-1,:)+C3(2:end,:))/2.0;
    D2(1:2:end,:) = C2;       
    D3(1:2:end,:) = C3;    
    D2(2:2:end,:) = Temp3;
    D3(2:2:end,:) = Temp4;
end
% B= C420(A)
B = zeros(size(A));
B(:,:,1) = D1 - 0.0009*D2 + 1.4017*D3;
B(:,:,2) = D1 - 0.3437*D2 - 0.7142*D3;
B(:,:,3) = D1 + 1.7722*D2 + 0.0010*D3;
figure(2);
image(double(B));
title('B:  reconstructed image ');
