%Created by Engineer Renan Bueno W. (https://github.com/EngRenanBW/)

function mtr_transformacao=trans(ang)% o angulo deve ser dado em graus
  ang=ang/180*pi;% transformando em radianos
  
  mtr_transformacao=[[cos(ang),sin(ang),0,0];[-sin(ang),cos(ang),0,0];[0,0,cos(ang),sin(ang)];[0,0,-sin(ang),cos(ang)]];
  
  %mtr_transposta=mtr_transposta/pi()*180;% transformando em radianos
  
%endfunction