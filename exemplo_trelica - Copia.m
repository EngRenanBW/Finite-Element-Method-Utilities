%Created by Engineer Renan Bueno W. (https://github.com/EngRenanBW/)

more off
clc
clear

E=1.90E6 %lbf/in^2
AREA=8; %in^2
angulo=[0,135,0,90,45,0]
L=[3,sqrt(3^2+3^2),3,3,sqrt(3^2+3^2),3]*12 %convertendo ft para in
n_ele=size(L,2)

%Descobrindo o K de cada elemento
for(item=[1:n_ele])
  k(item)=AREA/L(item)*E;
endfor
AREA
k

%descobrindo a matrix de rigidez de cada elemento
for(item=[1:n_ele])
  K_ELEM{item}=K_glob_trelica(k(item),angulo(item));
endfor
K_ELEM=K_ELEM

%K_ELEM_GLOB{}=pos_glob(K_ELEM{},,,10);
K_ELEM_GLOB{1}=pos_glob(K_ELEM{1},0,0,5);
K_ELEM_GLOB{2}=pos_glob(K_ELEM{2},1,0,5);
K_ELEM_GLOB{3}=pos_glob(K_ELEM{3},2,0,5);
K_ELEM_GLOB{4}=pos_glob(K_ELEM{4},1,1,5);
K_ELEM_GLOB{5}=pos_glob(K_ELEM{5},1,2,5);
K_ELEM_GLOB{6}=pos_glob(K_ELEM{6},3,0,5);

K_ELEM_GLOB=K_ELEM_GLOB;

K_GLOB=sum_mtr(K_ELEM_GLOB)






