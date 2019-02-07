verbatimtex
  %&latex
  \documentclass[pdf,envcountpart]{beamer}
  \usepackage{endl_Woerter}
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
  % NFA for Ex. 1
  % ==============================================================================================
  begingroup;
    
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
    
    % -------------------- 0 -----------------------------------------------------------
    beginfig(0);
      settings;
      pickup pencircle scaled .8pt;
      drawboxed(Q2);
    endfig;
    
    % -------------------- 1 -----------------------------------------------------------
    beginfig(1);
      settings;
      pickup pencircle scaled .8pt;
      drawboxed(Q0);
      toploop(Q0)(btex $a$ etex);
    endfig;
    
    % -------------------- 2 -----------------------------------------------------------
    beginfig(2);
      settings;
      pickup pencircle scaled .8pt;
      drawboxed(Q0);
      drawarrow (Start--Q0.c) cutafter bpath Q0;
    endfig;
    
    % -------------------- 3 -----------------------------------------------------------
    beginfig(3);
      settings;
      pickup pencircle scaled .8pt;
      drawfinalstate(Q1);
    endfig;
    
    % -------------------- 4 -----------------------------------------------------------
    beginfig(4);
      settings;
      
      pickup pencircle scaled .8pt;
      drawboxed(Q0);
      drawfinalstate(Q1);

      drawarrow (Start--Q0.c) cutafter bpath Q0;
      arrow.top (btex $b$ etex, (0mm,0mm))(.5)(Q0)(Q1);

      toploop(Q0)(btex $a$ etex);
      toploop(Q1)(btex $b$ etex);
    endfig;
    
  endgroup;

  % ==============================================================================================
  % NFA for Ex. 2
  % ==============================================================================================
  begingroup;
    beginfig(10);
      dx := 20mm;

      for i = 0 upto 2: circleit.Q[i](q[i]); endfor;
      Q1.c = Q0.c + (dx, 0);
      Q2.c = Q1.c + (dx, 0);

      fixsize(Q0, Q1, Q2);
      fixpos(Q0, Q1, Q2);

      pair Start;
      Start := Q0.w + (-5mm,-4mm);    

      pickup pencircle scaled .8pt;
      drawboxed(Q0, Q1);
      drawfinalstate(Q2);

      drawarrow (Start--Q0.c) cutafter bpath Q0;
      arrow.top (btex $a$ etex, (0mm,0mm))(.5)(Q0)(Q1);
      arrow.top (btex $b$ etex, (0mm,0mm))(.5)(Q1)(Q2);

      toploop(Q0)(btex $b$ etex);
      toploop(Q1)(btex $a$ etex);
      toploop(Q2)(btex $a,b$ etex);
    endfig;

    beginfig(11);
      dx := 20mm;

      for i = 0 upto 2: circleit.Q[i](q[i]); endfor;
      Q1.c = Q0.c + (dx, 0);
      Q2.c = Q1.c + (dx, 0);

      fixsize(Q0, Q1, Q2);
      fixpos(Q0, Q1, Q2);

      pair Start;
      Start := Q0.w + (-5mm,-4mm);    

      pickup pencircle scaled .8pt;
      drawboxed(Q0, Q1);
      drawfinalstate(Q2);

      drawarrow (Start--Q0.c) cutafter bpath Q0;
      arrow.top (btex $a$ etex, (0mm,0mm))(.5)(Q0)(Q1);
      arrow.top (btex $b$ etex, (0mm,0mm))(.5)(Q1)(Q2);

      toploop(Q0)(btex $a,b$ etex);
    endfig;
  endgroup;

  % ==============================================================================================
  % Decision problem (black box and reduction)
  % ==============================================================================================
  begingroup;
    beginfig(20);
      dx := 20mm;
      dy := 10mm;
      da := 15mm;
      
      pair E[], B[], A[];
      E0 := (0,  0);
      E1 := (da, 0);
      B0 := (da, .5dy);
      B3 := (da, -.5dy);
      B1 := (da+dx, .5dy);
      B2 := (da+dx, -.5dy);
      B4 := .5[B0,B2];
      A0 := (da+dx, 0);
      A1 := (2da+dx, 0);
      A2 := A1 + 5mm*dir(30);
      A3 := A1 + 5mm*dir(330);
      
      transform T[];
      for i = 2, 3:
        (0,0) transformed T[i] = A1;
        (1,0) transformed T[i] = A[i];
        (0,1) transformed T[i] = A1;
      endfor;
      
      pickup pencircle scaled .8pt;
      fill B0--B1--B2--B3--cycle withcolor (.25,.25,.25);
      draw B0--B1--B2--B3--cycle;
      drawarrow E0--E1;
      drawarrow A0--A1;
      draw ((.3,0)--(1,0)) transformed T2;
      draw ((.3,0)--(1,0)) transformed T3;
      
      label.top(btex \small Eingabe etex,                                    .5[E0,E1]);
      label.top(btex \small Ausgabe etex,                                    .5[A0,A1]);
      label.lft(btex \small $m \in M$ etex,                                  E0);
      label    (btex $m \in X\,?$ etex,                                      B4)         withcolor white;
      label.rt (btex \small \glqq ja\grqq\ ~~\,$\Rightarrow$ $m \in X$ etex,      A2);
      label.rt (btex \small \glqq nein\grqq\ $\Rightarrow$ $m \notin X$ etex, A3);
    endfig;
    
    beginfig(21);
      dx := 5mm;
      dy := 2mm;
      
      x0 := 0;
      x1 := x0 + dx;
      x2 := x1 + 2dx;
      x3 := x2 + 2.5dx;
      x4 := x3 + 4.5dx;
      x5 := x4 + 2dx;
      
      x[-1] := x0 - 3dx;
      x6    := x5 + 2.5dx;
      
      y0 := 0;
      y1 := y0 + dy;
      y2 := y1 + .2dy;
      y5 := y1 + 4dy;
      y4 := y5 - .2dy;
      y3 := .5[y1,y5];
      y6 := y5 + 4dy;
      
      y[3.5] := .6[y3,y4];
      y[2.5] := .6[y3,y2];
      
      path Ppi, Pin, Pout, Arr[];
      Pout := (x0,y0)--(x5,y0)--(x5,y6)--(x0,y6)--cycle;
      Ppi  := (x1,y1)--(x2,y1)--(x2,y5)--(x1,y5)--cycle;
      Pin  := (x3,y1)--(x4,y1)--(x4,y5)--(x3,y5)--cycle;
      Arr0 := (x[-1],y3)--(x0,y3);
      Arr1 := (x0,y3)--(x1,y3);
      Arr2 := (x2,y3)--(x3,y3);
      Arr3 := (x4,y[3.5])--(x5,y4);
      Arr4 := (x4,y[2.5])--(x5,y2);
      Arr5 := (x5,y4)--(x6,y4);
      Arr6 := (x5,y2)--(x6,y2);
      
      pickup pencircle scaled .8pt;
      fill Pout withcolor (.75,.75,.75);
      draw Pout;
      fill Ppi withcolor white;
      draw Ppi;
      fill Pin withcolor (.25,.25,.25);
      draw Pin;
      
      for i = 0 upto 6: drawarrow Arr[i]; endfor;
      
      label.top (btex $m\!\!\:\in\!\!\: M$ etex, (point .45 length Arr0 of Arr0)+(0mm,0mm));
      label.top (btex $\pi(m)$ etex,             (point .5 length Arr2 of Arr2)+(0mm,0mm));
      label.ulft(btex ja etex,                   (point .6 length Arr3 of Arr3)+(0mm,0mm));
      label.urt (btex nein etex,                 (point .2 length Arr4 of Arr4)+(0mm,0mm));
      label.top (btex ja etex,                   (point .45 length Arr5 of Arr5)+(0mm,0mm));
      label.top (btex nein etex,                 (point .45 length Arr6 of Arr6)+(0mm,0mm));

%       label.bot (btex $\strut\pi$ etex,                         ((.5[x1,x2]), y5)+(0mm,0mm));
%       label.bot (btex $\strut\pi(m)\!\!\:\in\!\!\: P'$\,? etex, ((.5[x3,x4]), y5)+(0mm,0mm));
      label     (btex $\strut\pi$ etex,                         ((.5[x1,x2]), y3)+(0mm,0mm));
      label     (btex $\strut\pi(m)\!\!\:\in\!\!\: X'$\,? etex, ((.5[x3,x4]), y3)+(0mm,0mm)) withcolor white;
      label.bot (btex $\strut m\!\!\: \in\!\!\: X$\,? etex,     ((.5[x0,x5]), y6)+(0mm,0mm));
    endfig;
  endgroup;
end.