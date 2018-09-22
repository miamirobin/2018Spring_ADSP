function  nrmse( A, B)
	C = ( B - A );
	sum0=0;
	for i=1:size(A,1)
    		for j=1:size(A,2)
        		A(i,j)=A(i,j)*A(i,j);
    		end
	end

	sum1=0;
	for i=1:size(C,1)
    		for j=1:size(C,2)
        		C(i,j)=C(i,j)*C(i,j);
    		end
	end
        
	D=sum(C,1);
	sum1=sum(D);  
	E=sum(A,1);
	sum0=sum(E);  
	NRMSE = sqrt( sum1/sum0 );
	fprintf('\n The nrmse is %0.4f\n', NRMSE);
