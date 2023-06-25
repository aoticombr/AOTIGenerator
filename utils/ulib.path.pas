unit ulib.path;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

const
  _init_file = '.env';

function GetApplicationFolder: string;
function GetEnvFile:string;

implementation

function GetApplicationFolder: string;
begin
  Result := GetCurrentDir;
end;

function GetEnvFile:string;
var
  _c,_p,_e:string;
begin
  _c:=  ExtractFilePath(ParamStr(0));
  _p:=  PathDelim;
  _e:=  _init_file;
  result:=  _c+_p+_e ;
end;

end.
