%%% ADSP_Final  %%%%%%%%%%%%%%%%
%%% 電機碩一  r06921048  李友岐 %%%%
 
fig1 = double(imread('/home/jameslee/Desktop/2018adsp/Pic/Peppers.png'))* (1/255.0);
fig2 = fig1 * 0.75;
fig3 = fig1 * 0.45;

fig4 = imnoise(fig1,'salt & pepper', 0.02);
fig5 = imnoise(fig1,'salt & pepper', 0.1);
fig6 = imnoise(fig1,'salt & pepper', 0.3);
fig7 = double(imread('/home/jameslee/Desktop/2018adsp/Pic/House.png'))* (1/255.0);
% The path should be modified under different environment


fig8=imrotate(fig1,90);
fig9=imrotate(fig1,180);
fig10=imrotate(fig1,270);

se = strel('line',15,100);
fig11 = imdilate(fig1,se);
fig12 = imerode(fig1,se);

p = [-1 -1 -1;-1 8 -1;-1 -1 -1] ;
freqz2(p);
fig13 = imfilter(fig1,p);
mse(fig1,fig13);
%fprintf("figure1, figure1\t");
%Psnr(fig1,fig1);
Psnr(fig1,fig3);
%nrmse(fig1,fig2);
%Psnr(fig1,fig3);

%nrmse(fig1,fig1);
%Psnr(fig4, fig5);  

nrmse(fig1,fig1);
nrmse(fig1,fig2);
nrmse(fig1,fig3);
nrmse(fig1,fig4);
nrmse(fig1,fig5);
nrmse(fig1,fig6);
nrmse(fig1,fig7);
nrmse(fig1,fig8);
nrmse(fig1,fig9);
nrmse(fig1,fig10);



nrmse(fig1,fig11);
nrmse(fig1,fig12);
nrmse(fig1,fig13);
%fig3 = double(imread('/home/jameslee/Desktop/2018adsp/Pic/48.gif'))* (1/255.0);
% The path should be modified under different environment
cwssim=cwssim_index(fig1,fig1,6,16,0,0);
cwssim2=cwssim_index(fig1,fig5,6,16,0,0);
cwssim3=cwssim_index(fig1,fig6,6,16,0,0);
cwssim4=cwssim_index(fig1,fig11,6,16,0,0);
cwssim5=cwssim_index(fig1,fig12,6,16,0,0);
cwssim6=cwssim_index(fig1,fig13,6,16,0,0);
fprintf('\n The cwssim is %0.4f\n',  cwssim);
fprintf('\n The cwssim is %0.4f\n',  cwssim2);
fprintf('\n The cwssim is %0.4f\n',  cwssim3);
fprintf('\n The cwssim is %0.4f\n',  cwssim4);
fprintf('\n The cwssim is %0.4f\n',  cwssim5);
fprintf('\n The cwssim is %0.4f\n',  cwssim6);
figure(1)
imshow(fig1);
figure(2)
imshow(fig2);
figure(3)
imshow(fig3);
figure(4)
imshow(fig4);
figure(5)
imshow(fig5);
figure(6)
imshow(fig6);
figure(8)
imshow(fig8);
figure(9)
imshow(fig9);
figure(10)
imshow(fig10);
figure(11)
imshow(fig11);
figure(12)
imshow(fig12);
figure(13)
imshow(fig13);
fprintf("figure1, figure3\t");
SSIM(fig1, fig3, 1E-2, 1E-2)
fprintf("figure1, figure4\t");
SSIM(fig1, fig4, 1E-2, 1E-2)
fprintf("figure1, figure5\t");
SSIM(fig1, fig5, 1E-2, 1E-2)
fprintf("figure1, figure6\t");
SSIM(fig1, fig6, 1E-2, 1E-2);
fprintf("figure1, figure11\t");
SSIM(fig1, fig11, 1E-2, 1E-2)
fprintf("figure1, figure12\t");
SSIM(fig1, fig12, 1E-2, 1E-2)
fprintf("figure1, figure13\t");
SSIM(fig1, fig13, 1E-2, 1E-2);
nrmse(fig1,fig6);