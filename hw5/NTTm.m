function  [A, B] = NTTm(N, M)  	
       bool=0;
       alpha=1;
       % find £\
       while bool==0
		        alpha=alpha+1;
                bool=1;
                mod_temp=1;
                for k=1:N
		           if k<N
                      mod_temp=mod(alpha*mod_temp,M);
			          if mod_temp==1
			      	    	bool=0;
                            break;
                      end
                   else
                      mod_temp=mod(alpha*mod_temp,M);
			          if mod_temp~=1
					       bool=0;
                      end
                   end
		        end
	
       end
       A=ones(N,N);
       % find A
       product=1;
       for k=1:N-1
            product=product*alpha;
            
       	    for n=1:N-1
                A(k+1,n+1)=mod(product*A(k+1,n),M);
            end
       end
       % find N^-1
       N_1=0;
       bool=0;
       while bool==0
		     N_1=N_1+1;
                
             if mod(N_1*N,M)==1
                break;
             end
       end
       % find £\^-1
       alpha_1=0;
       bool=0;
       while bool==0
		     alpha_1=alpha_1+1;
                
             if mod(alpha_1*alpha,M)==1
                break;
             end
       end
       B=ones(N,N)*N_1;
       % find B  
       product=1;
       for k=1:N-1
           
	         product=product*alpha_1;
            
       	     for n=1:N-1
                 B(k+1,n+1)=mod(product*B(k+1,n),M);
             end
       end
       
       

