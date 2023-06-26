unit ufrm.padrao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList;

type

  { TFPadrao }

  TFPadrao = class(TForm)
    actListPadrao: TActionList;
    ColDiagPadrao: TColorDialog;
    imgListPadrao: TImageList;
    OpenDialogPadrao: TOpenDialog;
    SavDiagPadrao: TSaveDialog;
  private

  public

  end;

var
  FPadrao: TFPadrao;

implementation

{$R *.lfm}

end.

