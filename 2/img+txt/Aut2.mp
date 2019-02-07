verbatimtex
  %&latex
  \documentclass[pdf,envcountpart]{beamer}
  \usepackage{endl_Baeume}
%  \newcommand{\Strut}{\rule[-6pt]{0pt}{19pt}}
  \newcommand{\Strut}{\rule[-3pt]{0pt}{12pt}}
  \begin{document}
etex;

  input boxes;

  % ==============================================================================================
  % General defs and macros
  % ==============================================================================================

  ahangle := 40;
  ahlength := 2.4mm;

  color ddgreen, dgreen, lgreen, ddred, dred;
  ddgreen = (.0,.15,.0);
  dgreen = (.0,.31,.0);
  lgreen = .5[dgreen,white];
  
  ddred = (.3,0,0);
  dred  = (.6,0,0);

  picture q[];
  q0 := btex $\Strut q_0$ etex;
  q1 := btex $\Strut q_1$ etex;
  q2 := btex $\Strut q_2$ etex;
  q3 := btex $\Strut q_3$ etex;
  q4 := btex $\Strut q_4$ etex;
  q5 := btex $\Strut q_5$ etex;
  q6 := btex $\Strut q_6$ etex;

  dc := 1.3mm;
  def drawfinalstateSecondCircle(text Q) =
    wid := xpart(Q.e-Q.w);
    hei := ypart(Q.n-Q.s);
    path c;
    c := (bpath Q) shifted (-Q.c) xscaled ((wid-dc)/wid) yscaled ((hei-dc)/hei) shifted Q.c;
    draw c;
  enddef;

  def drawfinalstateBoundary(text Q) =
    draw bpath Q;
    drawfinalstateSecondCircle(Q);
  enddef;
  
  def drawfinalstate(text Q) =
    drawboxed(Q);
    drawfinalstateSecondCircle(Q);
  enddef;
  
  vardef arrow.@#(expr lab, corr)(expr ratio)(text Q)(text R) =
    path p;
    p := (Q.c--R.c) cutbefore bpath Q cutafter bpath R;
    drawarrow p;
    label.@#(lab, (point ratio*length p of p)+corr);
  enddef;
  
  vardef rdarrow.@#(expr lab, corr)(expr ddir)(expr ratio)(text Q)(text R) =
    an := angle(R.c-Q.c);
    path p;
    p := Q.c{dir (an+ddir)}..{dir (an-ddir)}R.c cutbefore bpath Q cutafter bpath R;
    drawarrow p;
    label.@#(lab, (point ratio*length p of p)+corr);
  enddef;
  
  def dblarrow(expr ddir)(text Q)(text R) =
    an := angle(R.c-Q.c);
    drawarrow Q.c{dir (an+ddir)}..{dir (an-ddir)}R.c cutbefore bpath Q cutafter bpath R;
    drawarrow R.c{dir (an+180+ddir)}..{dir (an+180-ddir)}Q.c cutbefore bpath R cutafter bpath Q;
  enddef;

  vardef line(text Q)(text R) =
    draw (Q.c--R.c) cutbefore bpath Q cutafter bpath R;
  enddef;

  vardef partline(expr r)(text Q)(text R) =
    path p;
    p := (Q.c--R.c) cutbefore bpath Q cutafter bpath R;
    draw (point 0 of p)--(point r*length p of p) dashed evenly;
  enddef;

  dloop  := 4mm;
  shloop := 1.3mm;
  
  def botloop(text Q)(text P) =
    path arr;
    arr := fullcircle rotated 90 scaled dloop shifted (Q.s+(0mm,-shloop)) cutbefore bpath Q cutafter bpath Q;
    drawarrow arr;
    label.bot(P, (point (.5 length arr) of arr) + (0mm,0mm));
  enddef;

  def toploop(text Q)(text P) =
    path arr;
    arr := fullcircle rotated 270 scaled dloop shifted (Q.n+(0mm,shloop)) cutbefore bpath Q cutafter bpath Q;
    drawarrow arr;
    label.top(P, (point (.5 length arr) of arr) + (0mm,0mm));
  enddef;

  def rightloop(text Q)(text P) =
    path arr;
    arr := fullcircle rotated 180 scaled dloop shifted (Q.e+(shloop,0mm)) cutbefore bpath Q cutafter bpath Q;
    drawarrow arr;
    label.rt(P, (point (.5 length arr) of arr) + (0mm,0mm));
  enddef;
  
  def adiam(text Q) =
    (xpart(Q.e-Q.w))
  enddef;

  def bdiam(text Q) =
    (ypart(Q.n-Q.s))
  enddef;

  % ==============================================================================================
  % Tree 1
  % ==============================================================================================
  begingroup;
    dx := 20mm;
    dy := 10mm;
    
    picture lab[];
    
    def settings(expr version) =
      lab0            := btex \small \texttt{Person} etex;
      lab1            := btex \small \texttt{Name} etex;
      lab2            := btex \small \texttt{Telnr} etex;
      lab3            := btex \small \texttt{Email} etex;
      lab11           := btex \small \texttt{Vorname} etex;
      lab12           := btex \small \texttt{Nachname} etex;
      lab[21+version] := btex \small \texttt{64432} etex;
      lab[22-version] := btex \small \texttt{43776243} etex;
      lab31           := btex \small \texttt{"ts@informatik..."} etex;
      lab111          := btex \small \texttt{"Thomas"} etex;
      lab121          := btex \small \texttt{"{}Schneider"} etex;

      for i = 0,1,2,3,11,12,21,22,31,111,121:
        boxit.node[i](lab[i]);
      endfor;

      node2.c = node0.c + (0,-dy);
      node2.c = node1.c + (1.8dx, 0);
      node3.c = node2.c + (1.8dx, 0);

      node11.c = node1.c + (-.5dx,-dy);
      node12.c = node1.c + (.5dx,-dy);
      node21.c = node2.c + (-.4dx,-dy);
      node22.c = node2.c + (.4dx,-dy);
      node31.c = node3.c + (0,-dy);

      node111.c = node11.c + (0,-dy);
      node121.c = node12.c + (0,-dy);

      fixpos(node[0] for i = 1,2,3,11,12,21,22,31,111,121:,node[i] endfor);
      fixsize(node[0] for i = 1,2,3,11,12,21,22,31,111,121:,node[i] endfor);    
    enddef;
    
    def drawall(expr version)(text drawopt) = 
      for i = 0,1,2,11,12,21,22 if version < 2:,3,31 fi:
        drawunboxed(node[i]);
      endfor;
      
      drawoptions(drawopt);
      for i = 111,121:
        drawunboxed(node[i]);
      endfor;
      drawoptions();
      
      pickup pencircle scaled .8pt;
      line(node0)(node1);
      line(node0)(node2);
      line(node1)(node11);
      line(node1)(node12);
      line(node2)(node21);
      line(node2)(node22);
      line(node11)(node111);
      line(node12)(node121);    
      
      if version = 2:
        partline(.3)(node0)(node3);
      else:
        line(node0)(node3);
        line(node3)(node31);
      fi
      
    enddef;
  
    beginfig(1);
      settings(0);
      drawall(0)();
    endfig;
    
    beginfig(2);
      settings(1);
      drawall(1)();
      
      a := xpart(node22.e-node21.w)+2.5mm;
      b := xpart(node21.n-node21.s)+8mm;
      
      pickup pencircle scaled .4pt;
      draw fullcircle xscaled a yscaled b shifted (.5[node21.w,node22.e]);
    endfig;
    
    beginfig(3);
      settings(2);
      drawall(2)(withcolor dgreen);
    endfig;
    
    dy := 8mm;
    beginfig(10);      
      picture lab[];
      lab0   := btex \small \texttt{Person} etex;
      lab1   := btex \small \texttt{Name} etex;
      lab11  := btex \small \texttt{VN} etex;
      lab12  := btex \small \texttt{NN} etex;
      lab111 := btex \small \texttt{"{}Ada"} etex;
      lab121 := btex \small \texttt{"{}Schulz"} etex;

      for i = 0,1,11,12,111,121:
        boxit.node[i](lab[i]);
      endfor;
      
      node1.c = node0.c + (0,-dy);
      node11.c = node1.c + (-.5dx,-dy);
      node12.c = node1.c + (.5dx,-dy);
      node111.c = node11.c + (0,-dy);
      node121.c = node12.c + (0,-dy);

      fixpos(node[0] for i = 1,11,12,111,121:,node[i] endfor);
      fixsize(node[0] for i = 1,11,12,111,121:,node[i] endfor);    
      
      for i = 0,1,11,12,111,121:
        drawunboxed(node[i]);
      endfor;
      
      pickup pencircle scaled .8pt;
      line(node0)(node1);
      line(node1)(node11);
      line(node1)(node12);
      line(node11)(node111);
      line(node12)(node121);      
    endfig;
    
    beginfig(11);
      picture lab[];
      lab0   := btex \small \texttt{Person} etex;
      lab1   := btex \small \texttt{Name} etex;
      lab2   := btex \small \texttt{Telnr} etex;
      lab11  := btex \small \texttt{VN} etex;
      lab21  := btex \small \texttt{12345} etex;
      lab111 := btex \small \texttt{"{}Bob"} etex;
      
      for i = 0,1,2,11,21,111:
        boxit.node[i](lab[i]);
      endfor;

      node1.c = node0.c + (-.5dx,-dy);
      node2.c = node0.c + (.5dx,-dy);
      node11.c = node1.c + (0,-dy);
      node21.c = node2.c + (0,-dy);
      node111.c = node11.c + (0,-dy);

      fixpos(node[0] for i = 0,1,2,11,21,111:,node[i] endfor);
      fixsize(node[0] for i = 0,1,2,11,21,111:,node[i] endfor);    

      for i = 0,1,2,11,21,111:
        drawunboxed(node[i]);
      endfor;
      
      pickup pencircle scaled .8pt;
      line(node0)(node1);
      line(node0)(node2);
      line(node1)(node11);
      line(node2)(node21);
      line(node11)(node111);
    endfig;
    
    beginfig(12);
      picture lab[];
      lab0   := btex \small \texttt{Person} etex;
      lab1   := btex \small \texttt{Name} etex;
      lab11  := btex \small \texttt{VN} etex;
      lab12  := btex \small \texttt{NN} etex;
      lab111 := btex \small \texttt{"{}Ada"} etex;
      lab121 := btex \small \texttt{"{}Schulz"} etex;

      for i = 0,1,11,12,111,121:
        boxit.node[i](lab[i]);
      endfor;
      
      node1.c = node0.c + (0,-dy);
      node11.c = node1.c + (-.5dx,-dy);
      node12.c = node1.c + (.5dx,-dy);
      node111.c = node11.c + (0,-dy);
      node121.c = node12.c + (0,-dy);

      fixpos(node[0] for i = 1,11,12,111,121:,node[i] endfor);
      fixsize(node[0] for i = 1,11,12,111,121:,node[i] endfor);    
      
      for i = 0,1,11,12:
        drawunboxed(node[i]);
      endfor;
      
      drawoptions(withcolor dgreen);
      for i = 111,121:
        drawunboxed(node[i]);
      endfor;
      drawoptions();
      
      pickup pencircle scaled .8pt;
      line(node0)(node1);
      line(node1)(node11);
      line(node1)(node12);
      line(node11)(node111);
      line(node12)(node121);      
    endfig;
    
    dx := 8mm;
    beginfig(20);
      picture lab[];
      lab0   := btex \small \strut $\varepsilon$ etex;
      lab1   := btex \small \strut $1$  etex;
      lab2   := btex \small \strut $2$  etex;
      lab3   := btex \small \strut $3$  etex;
      lab21  := btex \small \strut $21$ etex;
      lab22  := btex \small \strut $22$ etex;
    
      for i = 0,1,2,3,21,22:
        circleit.node[i](lab[i]);
      endfor;
      
      node2.c = node0.c + (0,-dy);
      node2.c = node1.c + (dx,0);
      node3.c = node2.c + (dx,0);
      node21.c = node2.c + (-.5dx,-dy);
      node22.c = node2.c + (.5dx,-dy);

      for i = 0,1,2,3,21,22:
        node[i].dx = node[i].dy = .5mm;
      endfor;
      
      fixpos(node[0] for i = 1,2,3,21,22:,node[i] endfor);
      fixsize(node[0] for i = 1,2,3,21,22:,node[i] endfor);    
      
      for i = 0,1,2,3,21,22:
        drawunboxed(node[i]);
      endfor;
      
      pickup pencircle scaled .8pt;
      line(node0)(node1);
      line(node0)(node2);
      line(node0)(node3);
      line(node2)(node21);
      line(node2)(node22);
    endfig;
    
    beginfig(21);
      picture lab[];
      lab0   := btex \small \strut $b$ etex;
      lab1   := btex \small \strut $c$ etex;
      lab2   := btex \small \strut $a$ etex;
      lab3   := btex \small \strut $c$ etex;
      lab21  := btex \small \strut $c$ etex;
      lab22  := btex \small \strut $d$ etex;
    
      for i = 0,1,2,3,21,22:
        boxit.node[i](lab[i]);
      endfor;
      
      node2.c = node0.c + (0,-dy);
      node2.c = node1.c + (dx,0);
      node3.c = node2.c + (dx,0);
      node21.c = node2.c + (-.5dx,-dy);
      node22.c = node2.c + (.5dx,-dy);

      for i = 0,1,2,3,21,22:
        node[i].dx = node[i].dy = .5mm;
      endfor;

      fixpos(node[0] for i = 1,2,3,21,22:,node[i] endfor);
      fixsize(node[0] for i = 1,2,3,21,22:,node[i] endfor);    
      
      for i = 0,1,2,3,21,22:
        drawunboxed(node[i]);
      endfor;
      
      pickup pencircle scaled .8pt;
      line(node0)(node1);
      line(node0)(node2);
      line(node0)(node3);
      line(node2)(node21);
      line(node2)(node22);
    endfig;
    
    dx := 12mm;
    dy := 6mm;
    beginfig(22);
      picture lab[];
      lab0    := btex \small \strut $\Plus$ etex;
      lab1    := btex \small \strut $\Succ$ etex;
      lab2    := btex \small \strut $\Succ$ etex;
      lab11   := btex \small \strut $\Plus$ etex;
      lab21   := btex \small \strut $0$ etex;
      lab111  := btex \small \strut $0$ etex;
      lab112  := btex \small \strut $\Succ$ etex;
      lab1121 := btex \small \strut $0$ etex;
    
      for i = 0,1,2,11,21,111,112,1121:
        boxit.node[i](lab[i]);
      endfor;
      
      node1.c    = node0.c   + (-.5dx,-dy);
      node2.c    = node1.c   + (dx,0);
      node11.c   = node1.c   + (0,-dy);
      node21.c   = node2.c   + (0,-dy);
      node111.c  = node11.c  + (-.5dx,-dy);
      node112.c  = node111.c + (dx,0);
      node1121.c = node112.c + (0,-dy);

      for i = 0,1,2,11,21,111,112,1121:
        node[i].dx = node[i].dy = .2mm;
      endfor;

      fixpos(node[0] for i = 1,2,11,21,111,112,1121:,node[i] endfor);
      fixsize(node[0] for i = 1,2,11,21,111,112,1121:,node[i] endfor);    
      
      for i = 0,1,2,11,21,111,112,1121:
        drawunboxed(node[i]);
      endfor;
      
      pickup pencircle scaled .8pt;
      line(node0)(node1);
      line(node0)(node2);
      line(node1)(node11);
      line(node2)(node21);
      line(node11)(node111);
      line(node11)(node112);
      line(node112)(node1121);
    endfig;
    
    % ==============NEBA-Beispiel 1 ===============================================================
    dx := 6mm;
    dy := 7mm;

    pair P[];
    
    def treedepthtwo =
      for i = 0,1,2,11,12,21,22:
        circleit.node[i](lab[i]);
      endfor;
      
      node0.c = .5[node1.c,node2.c] + (0,dy);
      node1.c = .5[node11.c,node12.c] + (0,dy);
      node2.c = .5[node21.c,node22.c] + (0,dy);
      node12.c - node11.c = node21.c - node12.c = node22.c - node21.c = (dx, 0);
      
      for i = 0,1,2,11,12,21,22:
        node[i].dx = node[i].dy = .5mm;
      endfor;
      
      for i = 0,1,2,11,12,21,22:
        fixpos(node[i]);
        fixsize(node[i]);
      endfor;

      P0 := (xpart(node11.w), ypart(node11.s));
      P1 := (xpart(node22.e), ypart(node0.n));

      for i = 0,1,2,11,12,21,22:
        drawunboxed(node[i]);
      endfor;
      
      pickup pencircle scaled .8pt;
      line(node0)(node1);
      line(node0)(node2);
      line(node1)(node11);
      line(node1)(node12);
      line(node2)(node21);
      line(node2)(node22);    
    enddef;
    
    beginfig(31);
      picture lab[];
      lab0   := btex \small \strut $a$ etex;
      lab1   := btex \small \strut $a$ etex;
      lab2   := btex \small \strut $a$ etex;
      lab11  := btex \small \strut $b$ etex;
      lab12  := btex \small \strut $c$ etex;
      lab21  := btex \small \strut $c$ etex;
      lab22  := btex \small \strut $c$ etex;
    
      treedepthtwo;
    endfig;
    
    beginfig(32);
      picture lab[];
      lab0   := btex \small \strut $q_2$ etex;
      lab1   := btex \small \strut $q_1$ etex;
      lab2   := btex \small \strut $q_1$ etex;
      lab11  := btex \small \strut $q_0$ etex;
      lab12  := btex \small \strut $q_0$ etex;
      lab21  := btex \small \strut $q_0$ etex;
      lab22  := btex \small \strut $q_0$ etex;
    
      treedepthtwo;
    endfig;
    
    beginfig(33);
      picture lab[];
      lab0   := btex \small \strut $q_3$ etex;
      lab1   := btex \small \strut $q_1$ etex;
      lab2   := btex \small \strut $q_1$ etex;
      lab11  := btex \small \strut $q_0$ etex;
      lab12  := btex \small \strut $q_0$ etex;
      lab21  := btex \small \strut $q_0$ etex;
      lab22  := btex \small \strut $q_0$ etex;
    
      treedepthtwo;
    endfig;
    
    beginfig(34);
      picture lab[];
      lab0   := btex \small \strut $q_0$ etex;
      lab1   := btex \small \strut $q_1$ etex;
      lab2   := btex \small \strut $q_1$ etex;
      lab11  := btex \small \strut $q_2$ etex;
      lab12  := btex \small \strut $q_2$ etex;
      lab21  := btex \small \strut $q_2$ etex;
      lab22  := btex \small \strut $q_2$ etex;

      treedepthtwo;
    endfig;

    beginfig(35);
      picture lab[];
      lab0   := btex \small \strut $q_0$ etex;
      lab1   := btex \small \strut $q_x$ etex;
      lab2   := btex \small \strut $q_x$ etex;
      lab11  := btex \small \strut $?$ etex;
      lab12  := btex \small \strut $?$ etex;
      lab21  := btex \small \strut $?$ etex;
      lab22  := btex \small \strut $?$ etex;

      treedepthtwo;
%       pickup pencircle scaled .4pt;
      draw P0--P1 dashed evenly withcolor dred;
    endfig;


    % ============== XML-Konferenzprogramm ===============================================================
    dx := 9mm;
    dy := 7mm;
    
    for pic = 0,1:
      beginfig(41+pic);
        picture lab[];
        lab0   := btex \small \texttt{conference} etex;
        lab1   := btex \small \texttt{track} etex;
        lab2   := btex \small \texttt{track} etex;
        lab11  := btex \small \texttt{speaker} etex;
        lab111 := btex \small \phantom{\_}\texttt{track}\phantom{\_} etex;
        
        for i = 0,1,2,11,111:
          boxit.node[i](lab[i]);
        endfor;

        node0.c = .5[node1.c,node2.c] + (0,dy);
        node2.c = node1.c + (1.8dx, 0);
        
        node11.c = node1.c + (0,-dy);
        node111.c = node11.c + (0,-dy);

        for i = 0,1,2,11,111:
          fixpos(node[i]);
          fixsize(node[i]);
        endfor;

        pair RO, LU;
        RO := (xpart node2.e,  ypart node0.n);
        LU := (xpart node111.w, ypart node111.s);
        
        pickup pencircle scaled .8pt;
        if pic = 0: draw RO--LU withcolor white; fi;

        for i = 0,1,2,11,111:
          drawunboxed(node[i]);
        endfor;
        
        line(node0)(node1);
        line(node0)(node2);
        line(node1)(node11);
        line(node11)(node111);
        
        if pic = 1: draw RO--LU withcolor dred; fi;
      endfig;
    endfor;

    for pic = 0,1:
      beginfig(43+pic);
        picture lab[];
        lab0   := btex \small \texttt{conference} etex;
        lab1   := btex \small \texttt{breakfast} etex;
        lab2   := btex \small \texttt{lunch} etex;
        lab3   := btex \small \texttt{coffee} etex;
        lab4   := btex \small \texttt{dinner} etex;
        lab31  := btex \small \phantom{p}\texttt{cake}\phantom{p} etex;
        lab311 := btex \small \texttt{more\_cake} etex;
        
        for i = 0,1,2,3,4,31,311:
          boxit.node[i](lab[i]);
        endfor;

        node0.c = .5[node2.c,node3.c] + (0,dy);
        node2.c = node1.c + (1.8dx, 0);
        node3.c = node2.c + (1.8dx, 0);
        node4.c = node3.c + (1.8dx, 0);
        
        node31.c = node3.c + (0,-dy);
        node311.c = node31.c + (0,-dy);

        for i = 0,1,2,3,4,31,311:
          fixpos(node[i]);
          fixsize(node[i]);
        endfor;

        pair RO, LU;
        RO := (xpart node4.e,  ypart node0.n);
        LU := (xpart node1.w, ypart node311.s);
        
        pickup pencircle scaled .8pt;
        if pic = 0: draw RO--LU withcolor white; fi;

        for i = 0,1,2,3,4,31,311:
          drawunboxed(node[i]);
        endfor;
        
        line(node0)(node1);
        line(node0)(node2);
        line(node0)(node3);
        line(node0)(node4);
        line(node3)(node31);
        line(node31)(node311);
        
        if pic = 1: draw RO--LU withcolor dred; fi;
      endfig;
    endfor;
  endgroup;
  
    
end.