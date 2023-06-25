unit frmpesquisa;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ActnList,
  ExtCtrls, StdCtrls, PairSplitter, DBGrids, frmfilho;

type

  { TFPesquisa }

  TFPesquisa = class(TFFilho)
    actCadastrar: TAction;
    actAlterar: TAction;
    actExcluir: TAction;
    actConfirmar: TAction;
    actProcurar: TAction;
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ScrollBox1: TScrollBox;
  private

  public

  end;
  TPesqClass = class of TFPesquisa;

var
  FPesquisa: TFPesquisa;

implementation

{$R *.lfm}

end.

