%Created by Engineer Renan Bueno W. (https://github.com/EngRenanBW/)

%Funcao pra resolucao de problemas de Elementos Finitos.
%Define a matriz global atravez de uma matiz original e q quantidade de fileiras no inicio,meio e totais.

%ex:
%pos_glob([1,1,2,2;1,1,2,2;2,2,3,3;2,2,3,3],2,1,4)
%pos_glob([1,2;2,3],2,1,4)

function mtr_out=pos_glob(mtr,fileiras_iniciais,fileiras_meio,fileiras_totais,repetir)
  if(nargin!= 4 && nargin!=5)
    error("Esperava-se 4 argumentos"); % o ultimo argumento e utilizado apenas para a recursao
  endif
  
  fileiras_finais=fileiras_totais-(fileiras_iniciais+fileiras_meio+2); %ajustando para oder digitar a quantidade total de fileiras ao inves das finais
  if(fileiras_finais<0)
    error("O numero de fileiras totais e menor que as iniciais, do meio e originais somadas");
  endif
  
  
  if(nargin==4)
    dimensoes=size(mtr,1)/2;
    fileiras_iniciais=fileiras_iniciais*dimensoes;
    fileiras_meio=fileiras_meio*dimensoes;
    fileiras_finais=fileiras_finais*dimensoes;
  endif
  
  
  mtr=[mtr(:,1:size(mtr,2)/2),zeros(size(mtr,1),fileiras_meio),mtr(:,size(mtr,2)/2+1:end)];%colocando fileiras do meio 
  
  mtr=[zeros(size(mtr,1),fileiras_iniciais),mtr];%colocando fileiras iniciais
  
  
  mtr=[mtr,zeros(size(mtr,1),fileiras_finais)];%colocando fileiras finais
  
  %%{
  if(nargin==4)
    mtr
    %clipboard(mtr)
    fileiras_totais=2+fileiras_iniciais+fileiras_meio+fileiras_finais;
    mtr=pos_glob(mtr',fileiras_iniciais,fileiras_meio,fileiras_totais,"repetir");
  elseif(nargin==5 && !strcmp(repetir,"repetir"))
    error("argumento repetir utilizado da forma errada. Ele e utilizado apeas para a recursao da funcao e nao deve ser utilizado or usuarios");
  endif
  %}
  
  mtr_out=mtr;
endfunction