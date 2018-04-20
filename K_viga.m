%Created by Engineer Renan Bueno W. (https://github.com/EngRenanBW/)

function mtr=K_viga(E,I,l)
  mtr=(E*I/l^3)*[12,6*l,-12,6*l;
                6*l,4*l^2,-6*l,2*l^2;
                -12,-6*l,12,-6*l;
                6*l,2*l^2,-6*l,4*l^2];
%endfunction