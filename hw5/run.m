%%% ADSP_HW5(1)  %%%%%%%%%%%%%%%%
%%% �q���Ӥ@  r06921048  ���ͧ� %%%%
N=4;  %user defined
M=5;  %user defined
[A,B]=NTTm(N, M) ;

fprintf("A:\n");disp(A);
fprintf("B:\n");disp(B);
fprintf("(A*B)mod M: \n");disp(mod(A*B,M));fprintf("     = I\n\n");
