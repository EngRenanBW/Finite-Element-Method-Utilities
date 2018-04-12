%Created by Engineer Renan Bueno W. (https://github.com/EngRenanBW/)

function mtr_out=pos_glob_e(mtr,n_no1,no2,n_total_nos)
  if(nargin!=4)
    error("Esperava-se 4 argumentos");
  elseif(!all(floor([n_no1,no2,n_total_nos])==[n_no1,no2,n_total_nos]))
    error("os numeros dos elementos precisam ser inteiros");
  elseif(!all([n_no1,no2,n_total_nos]>0))
    error("os numeros dos elementos deve ser positivos");
  elseif(n_no1>=no2)
    error("o numero do no2 deve ser maior que o no1");
  elseif(no2>n_total_nos)
    error("o numero total de nós deve ser maior que a identificacao do no2")
  endif
  
  
  fileiras_iniciais=n_no1-1;
  fileiras_meio=no2-n_no1-1;
  fileiras_totais=n_total_nos;
  
  
  mtr_out=pos_glob(mtr,fileiras_iniciais,fileiras_meio,fileiras_totais);
  
endfunction