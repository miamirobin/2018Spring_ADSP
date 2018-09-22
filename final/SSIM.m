function  SSIM(A, B, c1, c2)	
	
	u_x = mean(A);
	u_y = mean(B);
	v_x = var(A,1);
	v_y = var(B,1);
    % We don't need L since c1 and c2 are adjustable constants
    % We can view c1*L and c2*L as another adjustable constants 
	item1=  (2* u_x.*u_y+c1);
    item2= (2* (mean(A.*B) - u_x.*u_y) +c2);
    item3= (u_x.*u_x+u_y.*u_y+c1);
    item4= (v_x+v_y+c2);
	ssim = mean(  (item1.* item2 ) ./ ( item3.*item4)   );
    fprintf("SSIM: %f\n",ssim);

