function mse(A,B)
	err = immse(A, B);
	fprintf('\n The mean-squared error is %0.4f\n', err*255*255);
