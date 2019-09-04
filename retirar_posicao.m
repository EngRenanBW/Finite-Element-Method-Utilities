%Created by Engineer Renan Bueno W. (https://github.com/EngRenanBW/)

%retira a linha e coluna da(s) posicao(oes) informada(s)

%K=[1:10;11:20;21:30;31:40;41:50;51:60;61:70;71:80;81:90;91:100]
%mtr_out=retirar_posicao(mtr,posicao)
function mtr_out=retirar_posicao(mtr,posicao)
  %nomeando parametros
  %mtr=varargin{1};
  %posicao=varargin{end};
  
  
  mtr_out=mtr;
  

  for(item=[1:prod(size(posicao))])
    if(posicao(item)~=1)
      if(size(mtr,2)==1) %tornando possivel tambem inserir um vetor ao inves de matriz
        mtr_out=mtr_out([1:posicao(item)-1,posicao(item)+1:end]);
      else
        mtr_out=mtr_out([1:posicao(item)-1,posicao(item)+1:end],[1:posicao(item)-1,posicao(item)+1:end]);
      end
    else
      if(size(mtr,2)==1) %tornando possivel tambem inserir um vetor ao inves de matriz
        mtr_out=mtr_out(2:end,1);
      else
        mtr_out=mtr_out(2:end,2:end);
      end
    end
    
    posicao_atual=posicao(item);
    for(i=[1:prod(size(posicao))]) %concertando a solicitacao de retirar as posicoes futuras
      if(posicao(i)>posicao_atual)
        posicao(i)=posicao(i)-1;
      end
    end
  end
%endfunction