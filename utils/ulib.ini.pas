unit ulib.ini;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ulib.path,IniFiles;

procedure CreateEnvFile;
procedure Gravar_ini(Conexao, campo, valor: String);
procedure RemoverSession(nome:string);
procedure Ler_Ini(_Conexao:STRING; var  _Host, _SID, _Usuario,
    _Senha, _Schema, _ConnectAs, _Banco, _Porta, _DBFile: string);

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

procedure Ler_Ini(_Conexao:STRING; var  _Host, _SID, _Usuario, _Senha, _Schema, _ConnectAs, _Banco, _Porta, _DBFile: string);
var
  Arquivo: TIniFile;
begin

  Arquivo := TIniFile.Create(GetEnvFile);
  try
    with Arquivo do
    begin

      _Host       := ReadString(_Conexao, 'Host'     , 'localhost');
      _DBFile     := ReadString(_Conexao, 'DBFile'  , 'c:\file.gdb');
      _SID        := ReadString(_Conexao, 'SID'      , 'XE');
      _Usuario    := ReadString(_Conexao, 'Usuario'  , 'SYS');
      _Banco      := ReadString(_Conexao, 'Banco'    , '0');
      _Porta      := ReadString(_Conexao, 'Porta'    , '1521');
      _Schema     := ReadString(_Conexao, 'Schema'   , 'SYSTEM');
      _Senha      := ReadString(_Conexao, 'Senha'    , '123');
      _ConnectAs  := ReadString(_Conexao, 'ConnectAs', '0');

    end;
  finally
    FreeAndNil(Arquivo);
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

