verbatimtex
  %&latex
  \documentclass[pdf,envcountpart]{beamer}
  \usepackage{unendl_Baeume}
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
  % Transition example for CTL =!= LTL
  % ==============================================================================================
  begingroup;

    % -------------------- 0 -----------------------------------------------------------
    beginfig(0);
      dx := 12mm;

      picture lab[];
      lab0 := btex \strut$p$ etex;
      lab1 := btex \strut~ etex;
      lab2 := btex \strut$p$ etex;

      for i = 0 upto 2: circleit.Q[i](lab[i]); endfor;
      Q1.c = Q0.c + (dx, 0);
      Q2.c = Q1.c + (dx, 0);

      fixsize(Q0, Q1, Q2);
      fixpos(Q0, Q1, Q2);

      pair Start;
%       Start := Q0.w + (-5mm,-4mm);
      Start := Q0.w + (-4mm,0mm);

      pickup pencircle scaled .8pt;
      drawboxed(Q0, Q1, Q2);

      drawarrow (Start--Q0.c) cutafter bpath Q0;
      arrow.top (btex etex, (0mm,0mm))(.5)(Q0)(Q1);
      arrow.top (btex etex, (0mm,0mm))(.5)(Q1)(Q2);

      toploop(Q0)(btex etex);
      toploop(Q2)(btex etex);

      label.urt(btex $s_0$ etex, (point .25length bpath Q0 of bpath Q0)+(2mm,-1.5mm));
      label.urt(btex $s_1$ etex, (point .25length bpath Q1 of bpath Q1)+(0mm,-.5mm));
      label.urt(btex $s_2$ etex, (point .25length bpath Q2 of bpath Q2)+(2mm,-1.5mm));
    endfig;


  endgroup;
end.