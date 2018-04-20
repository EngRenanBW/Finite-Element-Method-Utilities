%Created by Engineer Renan Bueno W. (https://github.com/EngRenanBW/)

more off
clc
clear


E=70E6 %Pa
AREA=ones(1,5)*15E-4; %m^2
angulo=[0,90+(atan(1.5/1))*180/pi,0,90]
L=[1.5,sqrt(1.5^2+1^2),1.5,1] %m
nos_conectados={[1,2],[2,3],[3,4],[2,4]}
posicoes_imoveis=[1,2,5,6] %como e em 2 dimensoes: 1 significa no1 nao move em X; 2 significa no1 nao move em Y; 3 significa no2 nao move em X; 4 significa no2 nao move em Y
%matriz de forcas
F=[0;0;0;0;0;0;0;-2000] %N

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

%retirando posicoes dos nos pinados
K_GLOB_calc=retirar_posicao(K_GLOB,posicoes_imoveis)
F_calc=retirar_posicao(F,posicoes_imoveis)

%descobrindo a matriz de DEFORMACAO F=K*X
X_calc=inv(K_GLOB_calc)*F_calc
%recolocando os valores iguais a zero
X=zeros(n_nos*dimensoes,1);
for(i=[1:size(posicoes_nao_imoveis,2)])
  X(posicoes_nao_imoveis(i))=X_calc(i);
endfor
X


%Fase de posprocessamento
%calculando o stress
%size(k,2)
%disp("DEFORMACAO")
for(item=[1:size(k,2)])
  
  %2*nos_conectados{item}(1)
  %2*nos_conectados{item}(2)
  DEFORMACAO_x(item)=abs(X(2*nos_conectados{item}(1)-1)-X(2*nos_conectados{item}(2)-1));
  DEFORMACAO_y(item)=abs(X(2*nos_conectados{item}(1))-X(2*nos_conectados{item}(2)));
  
  DEFORMACAO(item)=sqrt(DEFORMACAO_x(item)^2+DEFORMACAO_y(item)^2);
  FORCA_ELEMENTO_x(item)=k(item)*DEFORMACAO_x(item);
  FORCA_ELEMENTO_y(item)=k(item)*DEFORMACAO_y(item);
  FORCA_ELEMENTO(item)=k(item)*DEFORMACAO(item);
  TENSAO(item)=FORCA_ELEMENTO(item)/AREA(item);
endfor

%DEFORMACAO_x
%DEFORMACAO_y
%FORCA_ELEMENTO_x
%FORCA_ELEMENTO_y

DEFORMACAO=DEFORMACAO
FORCA_ELEMENTO=FORCA_ELEMENTO
TENSAO=TENSAO

REACAO=round(K_GLOB*X-F)

disp("Como visto na matriz de reacao o somatorio das forcas em Y e igual a forca aplicada e o somatorio das em X e zero verificando os resultados");