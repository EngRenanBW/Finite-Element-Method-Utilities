%Created by Engineer Renan Bueno W. (https://github.com/EngRenanBW/)

more off
clc
clear

%NAO FINALIZADO

E=1.9E6 %psi
AREA=ones(1,6)*8; %in^2
angulo=[0,135,0,90,45,0]
L=[3,sqrt(3^2+3^2),3,3,sqrt(3^2+3^2),3]*12 %in
nos_conectados={[1,2],[2,3],[3,4],[2,4],[2,5],[4,5]} %A ordem dos nos conectados deve seguir a dos os elementos inseridos. Eg. {[no1_elemento1,no2_elemento1],[no1_elemento2,no2_elemento2],...,[no1_elementon,no2_elementon]}
posicoes_imoveis=[1,2,5,6] %como e em 2 dimensoes: 1 significa no1 nao move em X; 2 significa no1 nao move em Y; 3 significa no2 nao move em X; 4 significa no2 nao move em Y
%matriz de forcas
F=[0;0;0;0;0;0;0;-500;0;-500] %N

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
  DEFORMACAO_LOCAL_ELEMENTO{item} = [cos(angulo(item)*pi/180),sin(angulo(item)*pi/180),0,0;-sin(angulo(item)*pi/180),cos(angulo(item)*pi/180),0,0;0,0,cos(angulo(item)*pi/180),sin(angulo(item)*pi/180);0,0,-sin(angulo(item)*pi/180),cos(angulo(item)*pi/180)] * X([nos_conectados(item){1}(1)*2-1,nos_conectados(item){1}(1)*2,nos_conectados(item){1}(2)*2-1,nos_conectados(item){1}(2)*2]); %Matriz pag 134
  TENSAO{item} = -E*(DEFORMACAO_LOCAL_ELEMENTO{item}(1)-DEFORMACAO_LOCAL_ELEMENTO{item}(3))/L(item); %Equação 3.18
  FORCA_X_LOCAL_ELEMENTO_NO_i{item} = k(item) * (DEFORMACAO_LOCAL_ELEMENTO{item}(1) - DEFORMACAO_LOCAL_ELEMENTO{item}(3)); %Equação 3.17
  FORCA_X_LOCAL_ELEMENTO_NO_j{item} = k(item) * (DEFORMACAO_LOCAL_ELEMENTO{item}(3) - DEFORMACAO_LOCAL_ELEMENTO{item}(1)); %Equação 3.17

  DEFORMACAO_x_GLOBAL(item)=abs(X(2*nos_conectados{item}(1)-1)-X(2*nos_conectados{item}(2)-1));
  DEFORMACAO_y_GLOBAL(item)=abs(X(2*nos_conectados{item}(1))-X(2*nos_conectados{item}(2)));

endfor

DEFORMACAO_x_GLOBAL
DEFORMACAO_y_GLOBAL

%DEFORMACAO=DEFORMACAO
%FORCA_ELEMENTO=FORCA_ELEMENTO
TENSAO=TENSAO

REACAO=round(K_GLOB*X-F)
