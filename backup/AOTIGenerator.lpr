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
  Forms, ulib.conexao, ulib.path, ulib.ini, uConst,
  ulib.registro.cad, frmmenu, frmPadrao, frmpai, frmregisterdatasource,
frmfilho, frmpesquisa, frmcadastro, frmprojeto;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFMenu, FMenu);
  Application.Run;
end.

