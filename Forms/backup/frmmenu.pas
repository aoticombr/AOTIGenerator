unit frmmenu;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus,
  StdCtrls, PQTEventMonitor, frmpai, ulib.ini, ulib.conexao, uConst,
  ulib.form.registro, PQConnection;

type

  { TFMenu }

  TFMenu = class(TFPai)
    Button1: TButton;
    DropDow_TreeView: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem3: TMenuItem;
    PQConnection1: TPQConnection;
    tvDados: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure tvDadosDblClick(Sender: TObject);
  private

  public
    procedure CreateTreeView;
  end;

var
  FMenu: TFMenu;

implementation

{$R *.lfm}

USES
   frmregisterdatasource;

{ TFMenu }

procedure TFMenu.tvDadosDblClick(Sender: TObject);
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

procedure TFMenu.FormCreate(Sender: TObject);
begin
  TConexoes.new().Load;
  CreateTreeView;
end;

procedure TFMenu.Button1Click(Sender: TObject);
begin
  PQConnection1.Open;

end;

procedure TFMenu.MenuItem1Click(Sender: TObject);
var
  frmClass: TFormClass;
  frm: TForm;
begin
  inherited;
  frmClass:= TRegisterForms.New.FindClassByChave('TFRegisterDataSource');
  frm:= frmClass.Create(self) ;
  try
    frm.ShowModal;
    TConexoes.new().Load;
    CreateTreeView;
    //CarregarConexoes;
    //CreateRecreateDataSource;
    //CreateTreeView_DB;

  finally
    freeandnil(frm);
  end;

end;

procedure TFMenu.MenuItem3Click(Sender: TObject);
var
  _TN_SELECIONADO: TTreeNode;
  _ConexaoId: INTEGER;
  _nome_conexao, _nome_schema: string;
  frmClass: TFormClass;
  frm: TForm;

begin
  inherited;

  _TN_SELECIONADO := tvDados.Selected;
  _nome_conexao := _TN_SELECIONADO.Text;
  _ConexaoId := TConexoes.New().GetIndexConexao(_nome_conexao);

  frmClass:= TRegisterForms.New.FindClassByChave('TFRegisterDataSource');
  frm:= frmClass.Create(self) ;
  try
    TFRegisterDataSource(frm).Modo := mEdit;
    TFRegisterDataSource(frm).edtConexao.Text := _nome_conexao;
    TFRegisterDataSource(frm).GetDados;
    frm.ShowModal;
    TConexoes.new().Load;
    CreateTreeView;
  finally
    freeandnil(frm)
  end;

end;

procedure TFMenu.CreateTreeView;
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

