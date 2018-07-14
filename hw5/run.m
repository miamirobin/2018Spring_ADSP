%%% ADSP_HW5(1)  %%%%%%%%%%%%%%%%
%%% 電機碩一  r06921048  李友岐 %%%%
N=4;  %user defined
M=5;  %user defined
[A,B]=NTTm(N, M) ;

fprintf("A:\n");disp(A);
fprintf("B:\n");disp(B);
fprintf("(A*B)mod M: \n");disp(mod(A*B,M));fprintf("     = I\n\n");
