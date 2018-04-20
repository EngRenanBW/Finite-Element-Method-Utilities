function mtr=K_quadro(A,E,I,l)
  %matriz de rigidez da trelica
  mtr_trelica=zeros(6,6);
  mtr_trelica(1,1)=K_trelica(A,E,l)(1,1);
  mtr_trelica(1,4)=K_trelica(A,E,l)(1,3);
  mtr_trelica(4,1)=K_trelica(A,E,l)(3,1);
  mtr_trelica(4,4)=K_trelica(A,E,l)(3,3);
  
  %matriz de rigidez da viga
  mtr_viga=K_viga(E,I,l);
  mtr_viga=[[0;0;0;0],mtr_viga(1:end,1:2),[0;0;0;0],mtr_viga(1:end,3:end)];
  mtr_viga=mtr_viga';
  mtr_viga=[[0;0;0;0;0;0],mtr_viga(1:end,1:2),[0;0;0;0;0;0],mtr_viga(1:end,3:end)];
  mtr_viga=mtr_viga';
  
  %somando as duas matrizes
  mtr=mtr_trelica+mtr_viga;