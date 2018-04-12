function matriz_booleana = cmp_lin_col (mtr1,mtr2)
  if(size(mtr2,2)~=1 || size(mtr1,1)~=1)
    error("A primeira matriz deve conter uma linha e a segunda uma coluna"); 
  endif
  
  
  matriz_booleana=[];
  for(i=[1:size(mtr2,1)])
    aux=[];
    for(j=[1:size(mtr1,2)])
      mtr2(i)==mtr1(j);
      aux(j)= mtr2(i)==mtr1(j);
    end
    matriz_booleana=[matriz_booleana;aux];
  end
  
  %matrix_aux=matriz_booleana;
  
