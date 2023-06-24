unit ulib.path;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

const
  _init_file = '.env';

function GetApplicationFolder: string;

implementation

function GetApplicationFolder: string;
begin
  Result := GetCurrentDir;
end;

function GetInitFile:string;
begin
  result:= GetApplicationFolder+_init_file;
end;

end.

