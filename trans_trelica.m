function mtr_transformacao=trans_trelica(ang)
  ang=ang/180*pi;% transformando em radianos
  
  mtr_transformacao=[[cos(ang),sin(ang),0,0];[-sin(ang),cos(ang),0,0];[0,0,cos(ang),sin(ang)];[0,0,-sin(ang),cos(ang)]];
