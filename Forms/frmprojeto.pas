unit frmprojeto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, frmpesquisa,
  ulib.registro.pesq;

type
  TFProjeto = class(TFPesquisa)
  private

  public

  end;

var
  FProjeto: TFProjeto;

implementation

{$R *.lfm}

initialization
  RegistrarPesqClasse('TFProjeto', TFProjeto);

end.

