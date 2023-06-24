unit frmRegisterDataSource;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Spin, ExtCtrls, FrmPadrao, ulib.form.registro, ulib.ini, ulib.conexao;

type
  TModo = (mInsert, mEdit);
  { TFRegisterDataSource }

  TFRegisterDataSource = class(TFPadrao)
    btnVoltar: TButton;
    btnAvancar: TButton;
    btnConcluir: TButton;
    btnCancelar: TButton;
    cbxBanco: TComboBox;
    edtConexao: TEdit;
    edtHost: TEdit;
    edtSID: TEdit;
    edtDefaultSchema: TEdit;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    lblNomeConexao: TLabel;
    lblBancoDado: TLabel;
    lblServidorIP: TLabel;
    lblPort: TLabel;
    lblDatabase: TLabel;
    lblDefaultSchema: TLabel;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    pcPassos: TPageControl;
    edtPort: TSpinEdit;
    Panel1: TPanel;
    tsPasso1: TTabSheet;
    tsPasso2: TTabSheet;
    procedure btnConcluirClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    FModo: TModo;
    procedure SetModo(AValue: TModo);

  public
    property Modo: TModo read FModo write SetModo;
    procedure GetDados;
  end;

var
  FRegisterDataSource: TFRegisterDataSource;

implementation

{$R *.lfm}


{ TFRegisterDataSource }

procedure TFRegisterDataSource.Panel1Click(Sender: TObject);
begin

end;

procedure TFRegisterDataSource.btnConcluirClick(Sender: TObject);
var
  _i: integer;
  _existe: boolean;
begin
  if self.Modo = mInsert then
    begin
      _existe:= false;
      for _I := 0 to TConexoes.New().Itens.Count - 1 do
        if TConexoes.New().Itens.Strings[_i] = edtConexao.Text then _existe:= true;
      if _existe = true then
      begin
        MessageDlg('Conexão "'+edtConexao.Text+'" já existe, escolha outro nome!',mtInformation,[mbOK],0);
        pcPassos.ActivePage:= tsPasso1;
        edtConexao.SetFocus;
        edtConexao.SelText;
      end
      else
      begin
        Gravar_ini(edtConexao.Text, 'Host', edtHost.Text);
        Gravar_ini(edtConexao.Text, 'SID', edtSID.Text);
        Gravar_ini(edtConexao.Text, 'Usuario', edtUsuario.Text);
        Gravar_ini(edtConexao.Text, 'Senha', edtSenha.Text);
        Gravar_ini(edtConexao.Text, 'Banco', inttostr(cbxBanco.ItemIndex));
        Gravar_ini(edtConexao.Text, 'Porta', edtPort.Text);
        Gravar_ini(edtConexao.Text, 'Schema', edtDefaultSchema.Text);
        //
        TConexoes.New.Add(edtConexao.Text);
         self.Close;
      end;
    end
    else
    begin
      Gravar_ini(edtConexao.Text, 'Host', edtHost.Text);
      Gravar_ini(edtConexao.Text, 'SID', edtSID.Text);
      Gravar_ini(edtConexao.Text, 'Usuario', edtUsuario.Text);
      Gravar_ini(edtConexao.Text, 'Senha', edtSenha.Text);
      Gravar_ini(edtConexao.Text, 'Banco', inttostr(cbxBanco.ItemIndex));
      Gravar_ini(edtConexao.Text, 'Porta', edtPort.Text);
      Gravar_ini(edtConexao.Text, 'Schema', edtDefaultSchema.Text);
      //
       self.Close;
    end;
end;

procedure TFRegisterDataSource.SetModo(AValue: TModo);
begin
  if FModo=AValue then Exit;
  FModo:=AValue;
end;

procedure TFRegisterDataSource.GetDados;
var
  _Host, _SID, _Schema, _Usuario, _Senha, _Banco, _ConnectAs, _Porta, _DBFile: string;
begin
  if Self.Modo = mEdit then
  begin

    Ler_Ini(edtConexao.Text, _Host, _SID, _Usuario, _Senha, _Schema, _ConnectAs, _Banco, _Porta, _DBFile);
    //
    edtHost.Text          := _Host;
    edtSID.Text           := _SID;
    edtUsuario.Text       := _Usuario;
    edtSenha.Text         := _Senha;
    edtPort.Value         := STRTOINT(_Porta);
    edtDefaultSchema.Text := _Schema;

     cbxBanco.ItemIndex    := 0;


  end;

end;

initialization
  RegistrarFormClasse('TFRegisterDataSource', TFRegisterDataSource);

end.

