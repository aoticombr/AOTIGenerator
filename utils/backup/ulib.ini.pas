unit ulib.ini;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ulib.path,IniFiles;

procedure CreateEnvFile;
procedure Gravar_ini(Conexao, campo, valor: String);
procedure RemoverSession(nome:string);

implementation

procedure CreateEnvFile;
var
  EnvFile: TextFile;
  _file:string;
begin

  _file  := GetEnvFile;
  if not FileExists(_file) then
  begin
    AssignFile(EnvFile, _file);
    try
      Rewrite(EnvFile);
    finally
      CloseFile(EnvFile);
    end;
  end;
end;

procedure GravarRegistro(xArquivo, xSection, xIdent, xValue: String);
var
  ArqReg: TIniFile;
begin
  ArqReg := TIniFile.Create(xArquivo);
  Try
    ArqReg.WriteString(xSection, xIdent, xValue);
  Finally
    ArqReg.Free;
  end;
end;

procedure Gravar_ini(Conexao, campo, valor: String);
begin
  GravarRegistro(GetEnvFile, Conexao, campo, valor);
end;

procedure RemoverSession(nome:string);
var
  ArqReg: TIniFile;
begin
  ArqReg := TIniFile.Create(GetEnvFile);
  Try
    ArqReg.EraseSection(nome);
  Finally
    ArqReg.Free;
  end;

end;

end.

