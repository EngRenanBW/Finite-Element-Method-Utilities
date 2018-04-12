%Created by Engineer Renan Bueno W. (https://github.com/EngRenanBW/)

more off
clc
clear
disp("Exercicio 3 cap 2 Moaveni")

E=10E6 %lbf/in^2
AREA=ones(1,2)*2.3; %in^2
angulo=[60,120]
L=[3,3]*12 %convertendo ft para in
nos_conectados={[1,2],[2,3]}
posicoes_imoveis=[1,2,5,6] %como e em 2 dimensoes: 1 significa no1 nao move em X; 2 significa no1 nao move em Y; 3 significa no2 nao move em X; 4 significa no2 nao move em Y

%recuperando informacoes necessarias
n_ele=size(L,2) %numero de elementos
n_nos=max(max([nos_conectados{1:end}]));


%Descobrindo o K de cada elemento
for(item=[1:n_ele])
  k(item)=AREA(item)/L(item)*E;
endfor
k

%Descobrindo a matrix de rigidez de cada elemento
for(item=[1:n_ele])
  K_ELEM{item}=K_glob_trelica(k(item),angulo(item));
endfor
K_ELEM=K_ELEM

dimensoes=size(K_ELEM{1},1)/2; %informacao importante para a etapa final
posicoes_nao_imoveis=find(!any([1:n_nos*dimensoes]==posicoes_imoveis'));

%Descobrindo a matriz de rigidez global para cada elemento
for(item=[1:n_ele])
  K_ELEM_GLOB{item}=pos_glob_e(K_ELEM{item},nos_conectados{item}(1),nos_conectados{item}(2),n_nos);
endfor
K_ELEM_GLOB=K_ELEM_GLOB

%matriz de rigidez global
K_GLOB=sum_mtr(K_ELEM_GLOB)

%matriz de forcas
F=[0;0;0;-200;0;0]

%retirando posicoes dos nos pinados
K_GLOB_calc=retirar_posicao(K_GLOB,posicoes_imoveis)
F_calc=retirar_posicao(F,posicoes_imoveis)

%descobrindo a matriz de deslocamento F=K*X
X_calc=inv(K_GLOB_calc)*F_calc
%recolocando os valores iguais a zero
X=zeros(n_nos*dimensoes,1);
for(i=[1:size(posicoes_nao_imoveis,2)])
  X(posicoes_nao_imoveis(i))=X_calc(i);
endfor
X


%Fase de posprocessamento
%calculando o stress
size(k,2)
disp("deslocamento")
for(item=[1:size(k,2)])
  
  %2*nos_conectados{item}(1)
  2*nos_conectados{item}(2)
  DESLOCAMENTO_x(item)=abs(X(2*nos_conectados{item}(1)-1)-X(2*nos_conectados{item}(2)-1));
  DESLOCAMENTO_y(item)=abs(X(2*nos_conectados{item}(1))-X(2*nos_conectados{item}(2)));
  
  DESLOCAMENTO(item)=sqrt(DESLOCAMENTO_x(item)^2+DESLOCAMENTO_y(item)^2)
  FORCA_ELEMENTO(item)=k(item)*DESLOCAMENTO(item);
  TENSAO(item)=FORCA_ELEMENTO(item)/AREA(item);
endfor

DESLOCAMENTO=DESLOCAMENTO
FORCA_ELEMENTO=FORCA_ELEMENTO
TENSAO=TENSAO

REACAO=round(K_GLOB*X-F)

disp("Como visto na matriz de reacao o somatorio das forcar em Y e igual a forca aplicada e o somatorio das em X e zero");
