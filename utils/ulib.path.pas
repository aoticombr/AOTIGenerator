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
begin
  result:= GetApplicationFolder +PathDelim+ _init_file;
end;

end.

