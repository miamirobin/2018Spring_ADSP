%%% ADSP_HW4(1)  %%%%%%%%%%%%%%%%
%%% 電機碩一  r06921048  李友岐 %%%%
fig1 = double(imread('/home/jameslee/Desktop/2018adsp/Pic/47.gif'))* (1/255.0);
% The path should be modified under different environment

fig2 = fig1 * 0.61;

fig3 = double(imread('/home/jameslee/Desktop/2018adsp/Pic/48.gif'))* (1/255.0);
% The path should be modified under different environment

figure(1)
imshow(fig1);
figure(2)
imshow(fig2);
figure(3)
imshow(fig3);
fprintf("figure1, figure1\t");
SSIM(fig1, fig1, 1E-2, 1E-2)
fprintf("figure1, figure2\t");
SSIM(fig1, fig2, 1E-2, 1E-2)
fprintf("figure1, figure3\t");
SSIM(fig1, fig3, 1E-2, 1E-2);

