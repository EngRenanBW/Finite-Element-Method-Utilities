%Created by Engineer Renan Bueno W. (https://github.com/EngRenanBW/)

function mtr=sum_mtr(mtr)
  mtr=sum(cat(3,mtr{:}),3); %codigo otimizado quanto ao uso de memoria
%endfunction