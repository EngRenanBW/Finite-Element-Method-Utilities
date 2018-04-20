%Created by Engineer Renan Bueno W. (https://github.com/EngRenanBW/)

%calcula a matriz com o sistema de coodenadas globais

function mtr_rigidez=K_glob_quadro(A,E,I,l,ang) %coeficiente elestico e angulo com o sistema de coordenadas globais
  mtr_transformacao=trans_quadro(ang);
  K=K_quadro(A,E,I,l);
  
  %mtr_rigidez=mtr_transformacao*K*inv(mtr_transformacao);
  mtr_rigidez=mtr_transformacao'*K*mtr_transformacao;
  
%endfunction