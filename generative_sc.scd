
// salle du trône

(
fork{
  loop{
    play{
     Splay.ar(
 {Klank.ar(`[((55/2)+(7.rand*2*(55/24)))*(2**(0..8))],Crackle.ar(2,0.005))*LFGauss.ar(9,1/4,0,0,2)}!5
     )
    };
    1.wait;
  }
};
)


//glauquerie géné

(
fork{
  loop{
    play{
     Splay.ar(.

{Klank.ar(`[99.rand*(1..9)],Crackle.ar(2,0.01))*LFGauss.ar(9,1/4,0,0,2)}!2
     )
    };
    1.wait;
  }
};
)



