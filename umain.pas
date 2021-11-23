unit UMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Grids, StdCtrls, Unitbeute;

type
  (* Datentyp fuer die virtuelle Welt*)


  { TfrmMain }

  TfrmMain = class(TForm)
    btnZufall: TButton;
    btnNext: TButton;
    btnStart: TButton;
    btnStopp: TButton;
    btnLeer: TButton;
    Spielfeld: TDrawGrid;
    pnlBottom: TPanel;
    tmrAnimation: TTimer;
    procedure btnLeerClick(Sender: TObject);
    procedure Auswerten(Sender: TObject);
    procedure btnStoppClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnZufallClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpielfeldDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure SpielfeldSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
  private
    { private declarations }

    (* virtuelle Spielwelt *)


  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  aufbau;
  FillByte (a,SizeOf(a),0);
  FillByte (b,SizeOf(b),0);
end;







procedure TfrmMain.SpielfeldDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin

  if a[aCol+1, aRow+1] = 10 then
    Spielfeld.Canvas.Brush.Color := clRed
  else
   if a[aCol+1, aRow+1] = 1 then
    Spielfeld.Canvas.Brush.Color := clGreen
  else
    Spielfeld.Canvas.Brush.Color := clWhite;

 Spielfeld.Canvas.FillRect(aRect);
end;

procedure TfrmMain.SpielfeldSelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin


  if a[aCol+1, aRow+1] = 0 then
    a[aCol+1, aRow+1] := 1
  else
   if a[aCol+1, aRow+1] = 1 then
    a[aCol+1, aRow+1] := 10
  else
    a[aCol+1, aRow+1] := 0;
end;




procedure TfrmMain.btnLeerClick(Sender: TObject);
begin
  FillByte (a,SizeOf(a),0);
  FillByte (b,SizeOf(b),0);
  Spielfeld.Repaint;
end;

procedure TfrmMain.Auswerten(Sender: TObject);

begin

    spiel(a,b);
    Spielfeld.Refresh;
    a:= b;
end;

procedure TfrmMain.btnStoppClick(Sender: TObject);
begin
  tmrAnimation.Enabled := false;
  a:=b;
  Spielfeld.Refresh;
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
  tmrAnimation.Enabled := true;
end;

procedure TfrmMain.btnZufallClick(Sender: TObject);
begin
  zufall(a);
  Spielfeld.Repaint;
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  tmrAnimation.Enabled := false;
  x := xa;
 abbaux(x);
 y := ya;
 abbauy(y);
end;

end.

