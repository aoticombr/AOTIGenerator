unit frmcadastro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, ActnList, frmfilho;

type

  { TFCadastro }

  TFCadastro = class(TFFilho)
    actExcluir: TAction;
    actGravar: TAction;
    actGravarSair: TAction;
    actCancelar: TAction;
    actOpcoes: TAction;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Notebook1: TNotebook;
    Page2: TPage;
    pgPadrao: TPageControl;
    Panel1: TPanel;
    tsPadrao: TTabSheet;
  private

  public

  end;
  TCadClass = class of TFCadastro;

var
  FCadastro: TFCadastro;

implementation

{$R *.lfm}

end.

