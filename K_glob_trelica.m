%Created by Engineer Renan Bueno W. (https://github.com/EngRenanBW/)
function mtr_rigidez=K_glob_trelica(k,ang) %coeficiente elestico e angulo com o sistema de coordenadas globais
  mtr_transformacao=trans(ang);
  Ktrelica=K_trelica(k);
  
  mtr_rigidez=mtr_transformacao*Ktrelica*inv(mtr_transformacao);
  
%endfunction