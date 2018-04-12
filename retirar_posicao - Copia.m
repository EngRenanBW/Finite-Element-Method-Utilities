%Created by Engineer Renan Bueno W. (https://github.com/EngRenanBW/)

%[1:10;11:20;21:30;31:40;41:50;51:60;61:70;71:80;81:90;91:100]
function mtr_out=retirar_posicao(mtr,posicao)
  mtr_out=mtr;
  for(item=[1:prod(size(posicao))])
    if(posicao(item)!=1)
      mtr_out=mtr_out([1:posicao(item)-1,posicao(item)+1:end],[1:posicao(item)-1,posicao(item)+1:end])
    else
      mtr_out=mtr_out(2:end,2:end);
    endif
    
    posicao_atual=posicao(item);
    for(i=[1:prod(size(posicao))]) %concertando a solicitacao de retirar as posicoes futuras
      if(posicao(i)>posicao_atual)
        posicao(i)=posicao(i)-1;
      endif
    endfor
    
    
    
  endfor
endfunction