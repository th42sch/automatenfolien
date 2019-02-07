verbatimtex
  %&latex
  \documentclass[pdf,envcountpart]{beamer}
  \usepackage{unendl_Woerter}
%  \newcommand{\Strut}{\rule[-6pt]{0pt}{19pt}}
  \newcommand{\Strut}{\rule[-3pt]{0pt}{12pt}}
  \renewcommand{\strut}{\rule[-2.5pt]{0pt}{9pt}}
  \begin{document}
etex;

  input boxes;

  % ==============================================================================================
  % General defs and macros
  % ==============================================================================================

  ahangle := 40;
  ahlength := 2mm;

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

  def leftloop(text Q)(text P) =
    path arr;
    arr := fullcircle scaled dloop shifted (Q.w+(-shloop,0mm)) cutbefore bpath Q cutafter bpath Q;
    drawarrow arr;
    label.lft(P, (point (.5 length arr) of arr) + (0mm,0mm));
  enddef;

  
  def adiam(text Q) =
    (xpart(Q.e-Q.w))
  enddef;

  def bdiam(text Q) =
    (ypart(Q.n-Q.s))
  enddef;

  % ==============================================================================================
  % Philosophers
  % ==============================================================================================
  begingroup;
%     def fillplate(expr c, r) =
%       for i = 0 upto 100:
%         x := uniformdeviate(2)-1;
%         y := uniformdeviate(2)-1;
%         sc := .3pt+uniformdeviate(.3pt);
%         if (x++y) + sc/r < 1:
%           fill (fullcircle scaled 2sc) shifted (c+r*(x,y));
%         fi;
%       endfor;
%     enddef;
%
    maxdish := 100;
    
    pair cplate[], cphil[];
    numeric xx[][], yy[][], sc[][];
    
    def makedish(expr i) =
      j := 0;
      forever:
        exitunless j < maxdish;
        xx[i][j] := uniformdeviate(2)-1;
        yy[i][j] := uniformdeviate(2)-1;
        sc[i][j] := .3pt+uniformdeviate(.3pt);
        if (xx[i][j]++yy[i][j]) + sc[i][j]/rplate < 1:
          j := j+1;
        fi;
        
      endfor;
    enddef;

    def fillplate(expr i) =
      for j = 0 upto maxdish-1:
        fill (fullcircle scaled 2sc[i][j]) shifted (cplate[i]+rplate*(xx[i][j],yy[i][j]));
      endfor;
    enddef;
    
    aoffs   := 210;
    unit    := .7mm;
    rtable  := 20unit;
    rplate  :=  6unit;
    rplctr  := rtable - rplate - 2unit;
    rphil   :=  4unit;
    rphctr  := rtable + rphil + 2unit;
    rforki  := rplctr - rplate;
    rforko  := rplctr + rplate;

    picture lab[];
    lab0 := btex \small $P_1$ etex;
    lab1 := btex \small $P_2$ etex;
    lab2 := btex \small $P_3$ etex;

    path table, fork[], plate[], phil[];
    table = fullcircle scaled 2rtable;

    for i = 0 upto 2:
      cplate[i] := rplctr*dir(120i+aoffs);
      cphil[i]  := rphctr*dir(120i+aoffs);

      plate[i] := fullcircle scaled 2rplate shifted cplate[i];
      phil[i]  := fullcircle scaled 2rphil  shifted cphil[i];

      fork[i]  := (rforki*dir(120i+60+aoffs))--(rforko*dir(120i+60+aoffs));

      makedish(i);
    endfor;

    def drawcommon =
      pickup pencircle scaled .8pt;
      draw table;
      for i = 0 upto 2:
        fillplate(i);

        draw plate[i];
        draw fork[i];
        draw phil[i];

        label(lab[i], rphctr*dir(120i+aoffs)+(0mm,0mm));
      endfor;
    enddef;

    def wiggly (expr p, devmax) =
      (
        (point 0 of p)
        for i = 1 upto 100:
          --((point (i/100*length p) of p) + (uniformdeviate(devmax)-.5devmax, uniformdeviate(devmax)-.5devmax))
        endfor
        --cycle
      )
    enddef;

    def drawbubbles(expr i) =
      if i = 0: dirn := -1; else: dirn := 1; fi;
      r0 := .8unit;
      r1 := 1.2unit;
      r2 := 1.7unit;
      dc := 1unit;

      pair refpoint;
      path cbubb[];
      refpoint := point (.25-dirn*.1)*length phil[i] of phil[i];
      cbubb0 := fullcircle scaled 2r0 shifted (refpoint + (dirn*(r0+2dc),0));
      cbubb1 := fullcircle scaled 2r1 shifted (refpoint + (dirn*(2r0+r1+3dc),r1-r0));
      cbubb2 := fullcircle scaled 2r2 shifted (refpoint + (dirn*(2r0+2r1+r2+4dc),r2-r0));

      pickup pencircle scaled .8pt;
      for j = 0 upto 2:
%         draw wiggly(cbubb[j], .5pt) withcolor dred;
        draw cbubb[j] withcolor dred dashed evenly scaled .4;
      endfor;
    enddef;

    beginfig(0);
      drawcommon;
      for i = 0 upto 2:
        drawbubbles(i);
      endfor;
    endfig;

    beginfig(1);
      drawcommon;

      for i = 0, 2:
        drawbubbles(i);
      endfor;

      pickup pencircle scaled .8pt;
      
      drawarrow ((point .25length phil1 of phil1) + (0, 2pt))
                {up}..{dir 120}
                ((point .5length fork1 of fork1) + (1.4pt, -1.4pt))
                withcolor dred dashed evenly scaled .4;

      drawarrow ((point (210/360)*length phil1 of phil1) + (-1.4pt, -1.4pt))
                {dir 210}..{left}
                ((point .5length fork0 of fork0) + (2pt, 0pt))
                withcolor dred dashed evenly scaled .4;
    endfig;
  endgroup;
  
  % ==============================================================================================
  % Transition system for philosophers
  % ==============================================================================================
  begingroup;
    beginfig(10);
      dx := 26mm;
      dy := 12mm;

      picture lab[][], edgee, edged;
      lab[0]0 := btex \small ddd1 etex;
      lab[1]0 := btex \small ddd2 etex;
      lab[2]0 := btex \small ddd3 etex;
      lab[0]1 := btex \small edd2 etex;
      lab[1]1 := btex \small ded3 etex;
      lab[2]1 := btex \small dde1 etex;
      lab[0]2 := btex \small edd3 etex;
      lab[1]2 := btex \small ded1 etex;
      lab[2]2 := btex \small dde2 etex;
      lab[0]3 := btex \small edd1 etex;
      lab[1]3 := btex \small ded2 etex;
      lab[2]3 := btex \small dde3 etex;

      edgee := btex \small $e$ etex;
      edged := btex \small $d$ etex;

      for i = 0 upto 2:
        for j = 0 upto 3:
          circleit.q[i][j](lab[i][j]);
          q[i][j].c = (i*dx, j*dy);
          q[i][j].dx = q[i][j].dy = 1.5mm;
          fixsize(q[i][j]);
          fixpos(q[i][j]);
        endfor
      endfor;

      pickup pencircle scaled .8pt;
      for i = 0 upto 2:
        for j = 0 upto 3:
          fill bpath q[i][j] withcolor .8[dgreen,white];
          drawboxed(q[i][j]);
        endfor;

        for j = 0 upto 2:
          drawarrow (q[i][j].n--q[i][j+1].s);
        endfor;

        drawarrow q[i]3.w {left}.. (q[i]2.w+(-4mm,0)) ..{right} q[i]1.w;
        
        label.lft(edgee, .4[q[i]0.n,q[i]1.s]+(0,0));
        label.lft(edged, .4[q[i]1.n,q[i]2.s]+(0,0));
        label.lft(edged, .4[q[i]2.n,q[i]3.s]+(0,0));
        label.lft(edgee, q[i]2.w+(-4mm,0)+(0,0));
      endfor;

      path fullarr;
      for i = 0 upto 1:
        drawarrow (q[i]0.e--q[i+1]0.w);
        label.top(edged, .4[q[i]0.e,q[i+1]0.w]+(0,0));

%         fullarr := q[i]3.c--(q[i+1]0.c+(-2mm,0));
        fullarr := q[i]3.c {dir 305}..{dir 325}q[i+1]0.c;
        drawarrow fullarr cutbefore bpath q[i]3 cutafter bpath q[i+1]0;
        label.llft(edged, (point .5length fullarr of fullarr)+(0,0));
      endfor;

      fullarr := q[2]0.c {dir 210}.. (q[1]0.s+(0,-2mm)) ..{dir 150} q[0]0.c;
      drawarrow fullarr cutbefore bpath q[2]0 cutafter bpath q[0]0;
      label.top(edged, (point .30length fullarr of fullarr)+(0,0));

      fullarr := q[2]3.c {dir 340}.. {down} (q[2]0.e+(4mm,0)) ..{left} (q[2]0.s+(0,-4mm)) ..{left} (q[1]0.s+(0,-4mm)) ..{dir 120} q[0]0.c;
      drawarrow fullarr cutbefore bpath q[2]3 cutafter bpath q[0]0;
      label.lft(edged, (point .15length fullarr of fullarr)+(0,0));

    endfig;
  endgroup;

  % ==============================================================================================
  % Transition system for consumer/producer
  % ==============================================================================================
  begingroup;
    beginfig(20);
      dx := 18mm;
      dy := 12mm;

      picture lab[], edgep, edgec;
      lab0 := btex \small 0 etex;
      lab1 := btex \small 1 etex;
      lab2 := btex \small 2 etex;
      lab3 := btex \small 3 etex;
      lab4 := btex \small U etex;
      lab5 := lab4;
      lab6 := lab4;
      lab7 := btex \small \"U etex;

      edgep := btex \small $p$ etex;
      edgec := btex \small $k$ etex;

      for i = 0 upto 3:
        for j = 0 upto 1:
          circleit.q[4j+i](lab[4j+i]);
          q[4j+i].c = (i*dx, j*dy);
          q[4j+i].dx = q[4j+i].dy = 1.5mm;
          fixsize(q[4j+i]);
          fixpos(q[4j+i]);
        endfor
      endfor;

      pickup pencircle scaled .8pt;
      for i = 0,1,2,3,4,7:
        fill bpath q[i] withcolor .8[dgreen,white];
        drawboxed(q[i]);
      endfor;

      path fullarr;
      for i = 0,1,2:
        fullarr := q[i].c..(.5[q[i].c, q[i+1].c] + (0,1.5mm))..q[i+1].c;
        drawarrow fullarr cutbefore bpath q[i] cutafter bpath q[i+1];
        label.top(edgep, (point (.4+.1i)*length fullarr of fullarr)+(0,0));

        fullarr := q[i+1].c..(.5[q[i].c, q[i+1].c] + (0,-1.5mm))..q[i].c;
        drawarrow fullarr cutbefore bpath q[i+1] cutafter bpath q[i];
        label.bot(edgec, (point .5length fullarr of fullarr)+(0,0));
      endfor;

      fullarr := q0.c--q4.c;
      drawarrow fullarr cutbefore bpath q0 cutafter bpath q4;
      label.lft(edgec, (point .5length fullarr of fullarr)+(0,0));

      fullarr := q4.c {dir 330}..{dir 300} q1.c;
      drawarrow fullarr cutbefore bpath q4 cutafter bpath q1;
      label.urt(edgep, (point .5length fullarr of fullarr)+(0,0));

      fullarr := q3.c--q7.c;
      drawarrow fullarr cutbefore bpath q3 cutafter bpath q7;
      label.rt(edgep, (point .5length fullarr of fullarr)+(0,0));

      fullarr := q7.c {dir 210}..{dir 240} q2.c;
      drawarrow fullarr cutbefore bpath q7 cutafter bpath q2;
      label.ulft(edgec, (point .5length fullarr of fullarr)+(0,0));

      rightloop(q7)(edgep);
      leftloop(q4)(edgec);
    endfig;
  endgroup;
    
  % ==============================================================================================
  % Büchi-Automata example 1
  % ==============================================================================================
  begingroup;
    dc := 1.3mm;

    % -------------------- settings -----------------------------------------------------------
    def settings =
      dx := 20mm;

      picture qi;
      qi := btex $\Strut q_i$ etex;

      for i = 0 upto 1: circleit.Q[i](q[i]); endfor;
      circleit.Q2(qi);
      Q1.c = Q0.c + (dx, 0);

      fixsize(Q0, Q1, Q2);
      fixpos(Q0, Q1, Q2);

      pair Start;
      Start := Q0.w + (-5mm,-4mm);
    enddef;

    % -------------------- 30 -----------------------------------------------------------
    beginfig(30);
      settings;

      pickup pencircle scaled .8pt;
      drawboxed(Q0);
      drawfinalstate(Q1);

      drawarrow (Start--Q0.c) cutafter bpath Q0;
      arrow.top (btex $a$ etex, (0mm,0mm))(.5)(Q0)(Q1);

      toploop(Q0)(btex $a$ etex);
      toploop(Q1)(btex $b$ etex);
    endfig;

    % -------------------- 31 -----------------------------------------------------------
    beginfig(31);
      settings;

      pickup pencircle scaled .8pt;
      drawboxed(Q0);
      drawfinalstate(Q1);

      drawarrow (Start--Q0.c) cutafter bpath Q0;
      arrow.top (btex $b$ etex, (0mm,0mm))(.5)(Q0)(Q1);

      toploop(Q0)(btex $a,b$ etex);
      toploop(Q1)(btex $b$ etex);
    endfig;

    % -------------------- 32 -----------------------------------------------------------
    beginfig(32);
      settings;

      pickup pencircle scaled .8pt;
      drawfinalstate(Q0);
      drawboxed(Q1);

      drawarrow (Start--Q0.c) cutafter bpath Q0;
      rdarrow.top (btex $b$ etex, (0mm,0mm))(20)(.5)(Q0)(Q1);
      rdarrow.bot (btex $b$ etex, (0mm,0mm))(20)(.5)(Q1)(Q0);

      toploop(Q0)(btex $a$ etex);
    endfig;

  endgroup;
    
  % ==============================================================================================
  % Büchi-Automata example 2
  % ==============================================================================================
  begingroup;
    dc := 1.3mm;

    % -------------------- settings -----------------------------------------------------------
    def settings =
      dx := 15mm;

      picture qs[];
      qs0 := btex \strut \small $q_0$ etex;
      qs1 := btex \strut \small $q_1$ etex;
      qs2 := btex \strut \small $q_2$ etex;

      for i = 0 upto 2: circleit.Q[i](qs[i]); endfor;
      Q1.c = Q0.c + (dx, 0);
      Q2.c = Q1.c + (dx, 0);

      fixsize(Q0, Q1, Q2);
      fixpos(Q0, Q1, Q2);

      pair Start;
      Start := Q0.w + (-3.75mm,-3mm);
    enddef;
    
    def drawarrows =
      drawarrow (Start--Q0.c) cutafter bpath Q0;
      arrow.top (btex \small $a$ etex, (0mm,0mm))(.5)(Q0)(Q1);
      arrow.top (btex \small $b$ etex, (0mm,0mm))(.5)(Q1)(Q2);

      toploop(Q0)(btex \small $b$ etex);
      toploop(Q1)(btex \small $a$ etex);
      
      path arr;
      arr := Q2.c {dir 70}..{dir 230} Q1.c;
      drawarrow arr cutbefore bpath Q2 cutafter bpath Q1;
      label.top(btex \small $a$ etex, (point .6length arr of arr)+(0,0));
      
      arr := Q2.c {dir 220}..{dir 140} Q0.c;
      drawarrow arr cutbefore bpath Q2 cutafter bpath Q0;
      label.bot(btex \small $b$ etex, (point .2length arr of arr)+(0,0));
    enddef;

    % -------------------- 40 -----------------------------------------------------------
    beginfig(40);
      settings;
      
      pickup pencircle scaled .8pt;
      drawfinalstate(Q2);
      drawboxed(Q0,Q1);
      
      drawarrows;
    endfig;

    % -------------------- 41 -----------------------------------------------------------
    beginfig(41);
      settings;
      
      pickup pencircle scaled .8pt;
      drawfinalstate(Q1);
      drawboxed(Q0,Q2);
      
      drawarrows;
    endfig;

    % -------------------- 42 -----------------------------------------------------------
    beginfig(42);
      settings;
      
      pickup pencircle scaled .8pt;
      drawfinalstate(Q0);
      drawboxed(Q1,Q2);
      
      drawarrows;
    endfig;

  endgroup;
    
  % ==============================================================================================
  % Büchi-Automata example 3
  % ==============================================================================================
  begingroup;
    dc := 1.3mm;

    % -------------------- 60 -----------------------------------------------------------
    beginfig(50);
      dx := 20mm;
      dy := 5mm;

      for i = 0 upto 2: circleit.Q[i](q[i]); endfor;
      Q1.c = Q0.c + (dx, dy);
      Q2.c = Q0.c + (dx, -dy);

      fixsize(Q0, Q1, Q2);
      fixpos(Q0, Q1, Q2);

      pair Start;
      Start := Q0.w + (-5mm,-4mm);

      pickup pencircle scaled .8pt;
      drawboxed(Q0);
      drawfinalstate(Q1);
      drawfinalstate(Q2);

      drawarrow (Start--Q0.c) cutafter bpath Q0;
      arrow.top (btex $b$ etex, (0mm,0mm))(.5)(Q0)(Q1);
      arrow.bot (btex $a$ etex, (0mm,0mm))(.5)(Q0)(Q2);

      toploop(Q0)(btex $a,b$ etex);
      rightloop(Q1)(btex $b$ etex);
      rightloop(Q2)(btex $a$ etex);
    endfig;

    % -------------------- 61 -----------------------------------------------------------
    beginfig(51);
      dx := 20mm;
      dy := 12mm;

      for i = 0 upto 4: circleit.Q[i](q[i]); endfor;
      Q1.c = Q0.c + (dx, 0);
      Q2.c = Q0.c + (0, -dy);
      Q3.c = Q2.c + (dx, 0);
      Q4.c = .5[Q2.c,Q3.c] + (0, -dy);

      fixsize(Q0, Q1, Q2, Q3, Q4);
      fixpos(Q0, Q1, Q2, Q3, Q4);

      pair Start[];
      for i = 0,2:
        Start[i] := Q[i].w + (-5mm,-4mm);
      endfor;

      pickup pencircle scaled .8pt;
      drawboxed(Q0, Q2);
      drawfinalstate(Q1);
      drawfinalstate(Q3);
      drawfinalstate(Q4);

      for i = 0,2:
        drawarrow (Start[i]--Q[i].c) cutafter bpath Q[i];
      endfor;

      arrow.top (btex $b$ etex, (0mm,0mm))(.5)(Q0)(Q1);
      arrow.top (btex $a$ etex, (0mm,0mm))(.5)(Q2)(Q3);
      arrow.lft (btex $b$ etex, (0mm,0mm))(.5)(Q2)(Q4);
      dblarrow(20)(Q3)(Q4);
      label.ulft(btex $a$ etex, (.5[Q3.c,Q4.c])+(-1mm,0mm));
      label.lrt (btex $b$ etex, (.5[Q3.c,Q4.c])+(1mm,0mm));

      toploop(Q0)(btex $a,b$ etex);
      rightloop(Q1)(btex $b$ etex);
      botloop(Q4)(btex $b$ etex);
    endfig;


  endgroup;
    
  % ==============================================================================================
  % Kripke structure for parallel programs
  % ==============================================================================================
  begingroup;
    dx := 10mm;
    dy := 8mm;
    
    picture lab[];
    lab0  := btex \small $\bot$ $\bot$ 0 etex;
    lab1  := btex \small 10 20 0 etex;
    lab2  := btex \small 10 21 0 etex;
    lab3  := btex \small 11 20 0 etex;
    lab4  := btex \small 11 21 0 etex;
    lab5  := btex \small \uuline{12} 20 0 etex;
    lab6  := btex \small \uuline{12} 21 0 etex;
    lab10 := btex \small $\bot$ $\bot$ 1 etex;
    lab11 := btex \small 10 20 1 etex;
    lab12 := btex \small 11 20 1 etex;
    lab13 := btex \small 10 21 1 etex;
    lab14 := btex \small 11 21 1 etex;
    lab15 := btex \small 10 \uuline{22} 1 etex;
    lab16 := btex \small 11 \uuline{22} 1 etex;
    
    def settings =
      sgn0 := -1;
      sgn1 := 1;

      for i = 0 upto 1: for j = 0 upto 6: circleit.S[10i+j](lab[10i+j]); endfor; endfor;
      
      S10.c = S0.c + (6dx, 0);
      for i = 0 upto 1:
        S[10i+1].c = S[10i].c + (0,-1.1dy);
        S[10i+2].c = S[10i+1].c + (sgn[i]*dx, -dy);
        S[10i+3].c = S[10i+1].c + (-sgn[i]*dx, -dy);
        S[10i+4].c = S[10i+1].c + (0,-2dy);
        S[10i+5].c = S[10i+3].c + (-sgn[i]*dx, -dy);
        S[10i+6].c = S[10i+3].c + (0,-2dy);
      endfor;
      
      for i = 0 upto 1:
        for j = 0 upto 6:
          S[10i+j].dx = S[10i+j].dy = 1.5mm;
          fixpos(S[10i+j]); fixsize(S[10i+j]);
        endfor;
      endfor;
      
      pair Start[];
      for i = 0 upto 1: Start[i] := S[10i].n + (0mm,.45dy); endfor;
    enddef;
    
    def drawings =
      pickup pencircle scaled .8pt;
      for i = 0 upto 1:
        for j = 0 upto 6: drawboxed(S[10i+j]); endfor;
        
        drawarrow Start[i]--S[10i].n;
        arrow.top (btex etex, (0mm,0mm))(.5)(S[10i])(S[10i+1]);
        arrow.top (btex etex, (0mm,0mm))(.5)(S[10i+1])(S[10i+2]);
        arrow.top (btex etex, (0mm,0mm))(.5)(S[10i+1])(S[10i+3]);
        arrow.top (btex etex, (0mm,0mm))(.5)(S[10i+2])(S[10i+4]);
        arrow.top (btex etex, (0mm,0mm))(.5)(S[10i+3])(S[10i+4]);
        arrow.top (btex etex, (0mm,0mm))(.5)(S[10i+3])(S[10i+5]);
        arrow.top (btex etex, (0mm,0mm))(.5)(S[10i+4])(S[10i+6]);
        arrow.top (btex etex, (0mm,0mm))(.5)(S[10i+5])(S[10i+6]);
        
        drawarrow S[10i+5].c{dir (90+sgn[i]*20)}..{dir (i*180)}S[10(1-i)+1].c cutbefore bpath S[10i+5] cutafter bpath S[10(1-i)+1];
        drawarrow S[10i+6].c{dir (i*180)}..{dir (90+sgn[i]*25)}.5[S5.c,S15.c]..{dir (i*180)}S[10(1-i)+3].c cutbefore bpath S[10i+6] cutafter bpath S[10(1-i)+3];
        
%        arrow.top (btex etex, (0mm,0mm))(.5)(S[10i+5])(S[10(1-i)+1]);
%        arrow.top (btex etex, (0mm,0mm))(.5)(S[10i+6])(S[10(1-i)+3]);        
      endfor;
      
      for j = 2,4,6:
        leftloop(S[j])(btex etex);
        rightloop(S[10+j])(btex etex);
      endfor;
    enddef;
    
    beginfig(60);
      settings;
      drawings;
    endfig;
    
  endgroup;
end.