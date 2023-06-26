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
  ufrm.menu,
  ufrm.padrao,
  ufrm.padrao.pai,
  ufrm.padrao.pesq,
  ufrm.padrao.cad,
  ufrm.config.ini,
  ufrm.padrao.filho,

  ufrm.projeto, udm;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFMenu, FMenu);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.

