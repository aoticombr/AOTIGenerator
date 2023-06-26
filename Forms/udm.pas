unit udm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, PQConnection;

type

  { TDM }

  TDM = class(TDataModule)
    Conexao: TPQConnection;
  private

  public

  end;

var
  DM: TDM;

implementation

{$R *.lfm}

end.

