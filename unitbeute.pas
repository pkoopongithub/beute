unit Unitbeute;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

(******************************************************************)
(* Paul Koop M.A. Raeuber Beute System                            *)
(* Die Simulation wurde ursprunglich entwickelt,                  *)
(* um die Verwendbarkeit von Zellularautomaten                     *)
(* fuer die Algorithmisch Rekursive Sequanzanalyse                *)
(* zu ueberpruefen								*)
(* Modellcharakter hat allein der Quelltext. Eine Compilierung    *)
(* dient nur als Falsifikationsversuch                            *)
(******************************************************************)

(*------------------------------------ Datenstruktur -----------------*)
CONST

 l = char(2);

TYPE
 s = 0..10;
raum = array[1..80,1..24] of s;
 zahl = ^inhalt;
 inhalt = RECORD
           i:integer;
           v:zahl;
           n:zahl;
          END;
VAR
 a,b:raum;
 n,x,y,xa,ya:zahl;

PROCEDURE aufbau;
PROCEDURE abbaux(x:zahl);
PROCEDURE abbauy(y:zahl);
FUNCTION neu (VAR r:raum; VAR x,y:zahl):s;
PROCEDURE zufall(VAR von:raum);
PROCEDURE spiel(VAR von,nach :raum);

implementation


USES dos,crt;



(*---------------------------------------- Prozeduren ---------------*)
PROCEDURE aufbau;
 VAR z:integer;
 BEGIN
  z := 1;
  new(n);
  xa := n;
  x := n;
  x^.i := z;
  REPEAT
   z := z +1;
   new(n);
   x^.n := n;
   n^.v := x;
   x := n;
   x^.i := z;
  UNTIL z = 80;
  x^.n := xa;
  xa^.v := x;

  z := 1;
  new(n);
  ya := n;
  y := n;
  y^.i := z;
  REPEAT
   z := z +1;
   new(n);
   y^.n := n;
   n^.v := y;
   y := n;
   y^.i := z;
  UNTIL z = 24;
  y^.n := ya;
  ya^.v := y;
 END;

PROCEDURE abbaux(x:zahl);
 BEGIN
  IF x^.n <> xa THEN abbaux(x^.n);
  dispose(x);
 END;

PROCEDURE abbauy(y:zahl);
 BEGIN
  IF y^.n <> ya THEN abbauy(y^.n);
  dispose(y);
 END;

FUNCTION neu (VAR r:raum; VAR x,y:zahl):s;
 VAR z1,z2,z:integer;
 BEGIN
  z:=(
   r(.x^.v^.i,y^.v^.i.)+
   r(.x^.i   ,y^.v^.i.)+
   r(.x^.n^.i,y^.v^.i.)+
   r(.x^.v^.i,y^.i   .)+
   r(.x^.n^.i,y^.i   .)+
   r(.x^.v^.i,y^.n^.i.)+
   r(.x^.i   ,y^.n^.i.)+
   r(.x^.n^.i,y^.n^.i.));

  z2 := z div 10;
  z1 := z mod 10;

  IF (r(.x^.i,y^.i.) =0)
   THEN
    BEGIN
     IF z1 > 1
      THEN neu:= 1
      ELSE neu := 0
    END
   ELSE
    BEGIN
     IF (r(.x^.i,y^.i.) =1)
      THEN
       BEGIN
        IF z2  > 1
         THEN neu := 10
          ELSE
           BEGIN
            IF z1 in (.2,3.)
             THEN neu := 1
             ELSE neu := 0
           END
       END
      ELSE
       IF z1 <1
        THEN
          neu := 0
        ELSE
         BEGIN
          IF z2 in (.2,3.)
           THEN neu := 10
           ELSE neu := 0
         END
    END
 END;



PROCEDURE zufall(VAR von:raum);
 VAR x,y,z:integer;
 BEGIN
  randomize;gotoxy(1,1);
  FOR y := 1 TO 24
   DO
   FOR x := 1 TO 80
    DO
     BEGIN
      z := random(3);
      IF z = 2 THEN
         z := 10;
      von(.x,y.):=z;

     END;
 END;




PROCEDURE spiel(VAR von,nach :raum);
 BEGIN
  y :=ya;
  x :=xa;
  REPEAT
   REPEAT
    nach(.x^.i,y^.i.):=neu(von,x,y);
    x := x^.n
   UNTIL x =xa;
   y := y^.n
  UNTIL y =ya;
 END;




end.

