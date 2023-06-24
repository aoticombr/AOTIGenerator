unit FMenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ulib.conexao, ulib.path, ulib.ini, uConst;

type

  { TForm1 }

  TForm1 = class(TForm)
    tvDados: TTreeView;
    procedure FormCreate(Sender: TObject);
    procedure tvDadosClick(Sender: TObject);
  private

  public
    procedure CreateTreeView;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  TConexoes.new().Load;
  CreateTreeView;
end;

procedure TForm1.tvDadosClick(Sender: TObject);
var
  _TN_SELECIONADO: TTreeNode;
begin
  _TN_SELECIONADO := tvDados.Selected;
  case _TN_SELECIONADO.Level of
    lvBanco:
      begin
      end;
    lvSchema:
      begin
      end;
    lvObjeto:
      begin
      end;
  end;
end;

procedure TForm1.CreateTreeView;
var
  _i:integer;
  _tn : TTreeNode;
begin
 tvDados.Items.BeginUpdate;
 try
   tvDados.Items.Clear;
   for _i:= 0 to TConexoes.new().Itens.Count - 1 do
   begin
     _tn:= tvDados.Items.Add(nil,TConexoes.New().Itens.Strings[_i]);
     _tn.StateIndex:= _i;
   end;

 finally
   tvDados.Items.EndUpdate;
 end;
end;

end.

