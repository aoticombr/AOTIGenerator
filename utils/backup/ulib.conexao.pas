unit ulib.conexao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IniFiles, ulib.ini, ulib.path;

type

  { TConexoes }

  TConexoes = class
  private
    FItens: Tstrings;
    procedure SetItens(AValue: Tstrings);
    function GetIndexConexao(NOME: string): INTEGER;
  public
    class var FConexoes : TConexoes;
    class function New(): TConexoes;
    constructor Create;
    procedure Load;
    procedure Add(_Nome: string);
    procedure Remove(_Nome: string);
    procedure Clear();
  published
    property Itens: Tstrings read FItens write SetItens;

  end;

implementation


{ TConexoes }

procedure TConexoes.SetItens(AValue: Tstrings);
begin
  if FItens=AValue then Exit;
  FItens:=AValue;
end;

function TConexoes.GetIndexConexao(NOME: string): INTEGER;
var
  _I: INTEGER;
begin
  Result := -1;
  for _I := 0 to self.Itens.Count - 1 do
    if self.Itens.Strings[_I] = NOME then
      Result := _I;

end;

class function TConexoes.New: TConexoes;
begin
   if not assigned(Fconexoes) then
    FConexoes:= TConexoes.Create;
  result:= FConexoes;
end;

constructor TConexoes.Create;
begin
  FItens:= TStringList.create;
end;

procedure TConexoes.Load;
var
  Arquivo: TIniFile;
begin
  CreateEnvFile;
  Arquivo := TIniFile.Create(GetEnvFile);
  try
    Arquivo.ReadSections(FItens);
  finally
    FreeAndNil(Arquivo);
  end;
end;

procedure TConexoes.Add(_Nome: string);
begin
  self.Itens.Add(_Nome);
end;

procedure TConexoes.Remove(_Nome: string);
var
  _I: INTEGER;
begin
  _I := GetIndexConexao(_Nome);
  RemoverSession(_Nome);

end;

procedure TConexoes.Clear;
begin
  FItens.Clear;
end;




end.

