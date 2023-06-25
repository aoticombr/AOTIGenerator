program AOTIGenerator;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  ulib.conexao,
  ulib.path,
  ulib.ini,
  ulib.registro.cad,
  uConst,
  frmmenu,
  frmPadrao,
  frmpai,
  frmpesquisa,
  frmcadastro,
  frmregisterdatasource,
  frmfilho,

  frmprojeto;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFMenu, FMenu);
  Application.Run;
end.

