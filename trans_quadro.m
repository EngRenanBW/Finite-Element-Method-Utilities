function mtr_transformacao=trans_quadro(ang)
  ang=ang/180*pi;% transformando em radianos
  c=cos(ang);
  s=sin(ang);
  mtr_transformacao=[c,s,0,0,0,0;
                     -s,c,0,0,0,0;
                     0,0,1,0,0,0;
                     0,0,0,c,s,0;
                     0,0,0,-s,c,0;
                     0,0,0,0,0,1];