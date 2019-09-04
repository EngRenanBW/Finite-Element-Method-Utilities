%Created by Engineer Renan Bueno W. (https://github.com/EngRenanBW/)

function mtr=K_trelica(A,E,l)
  if(nargin==1)
    k=A;
    mtr=[k,0,-k,0;0,0,0,0;-k,0,k,0;0,0,0,0];
  elseif(nargin==3)
    mtr=A*E/l*[1,0,-1,0;0,0,0,0;-1,0,1,0;0,0,0,0];
  else
    error("Esperava-se 1 ou 3 argumentos");
  end
  
%endfunction