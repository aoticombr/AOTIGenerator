unit ulib.registro.cad;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, ufrm.padrao.cad;

type
  TRegisterCad = class
  strict private
    class var FRegistrarFormClass: TRegisterCad;
  private
    FRegisteredClasses: TStringList;
    function GetClasses: TStringList;
    constructor Create;
  public
    destructor Destroy; override;
    class function New: TRegisterCad;
    class procedure PrivateDestroy;
  public
    procedure RegisterClass(const Chave: string; Clazz: TCadClass);
    function FindClassByChave(const Chave: string): TCadClass;
    function FindClassByChaveAndNewAsObjeto(const Chave: string): TObject;
    function FindClassByChaveAndNewAsInterface(const Chave: string): IInterface;
    function FindClassByNome(const Nome: string): TCadClass;
    function InstanciarOperacaoAsObjeto(Clazz: TCadClass): TObject;
    function InstanciarOperacaoAsInterface(Clazz: TCadClass): IInterface;

    procedure Clear;
    function IsEmpty: Boolean;

    property Classes: TStringList read GetClasses;
  end;

  procedure RegistrarCadClasse(const Chave: string; Clazz: TCadClass);

implementation

class function TRegisterCad.New: TRegisterCad;
begin
  if FRegistrarFormClass = nil then
    FRegistrarFormClass := TRegisterCad.Create;
  Result := FRegistrarFormClass;
end;

class procedure TRegisterCad.PrivateDestroy;
begin
  FRegistrarFormClass.Free;
end;

constructor TRegisterCad.Create;
begin
  FRegisteredClasses := TStringList.Create;
  FRegisteredClasses.CaseSensitive := False;
  FRegisteredClasses.Duplicates := dupError;
end;

destructor TRegisterCad.Destroy;
begin
  FRegisteredClasses.Free;
  inherited;
end;

procedure TRegisterCad.RegisterClass(const Chave: string; Clazz: TCadClass);
begin
  FRegisteredClasses.AddObject(Chave, TObject(Clazz));
end;

function TRegisterCad.FindClassByChave(const Chave: string): TCadClass;
var
  Index: Integer;
begin
  Index := FRegisteredClasses.IndexOf(Chave);
  if Index <> -1 then
    Result := TCadClass(FRegisteredClasses.Objects[Index])
  else
    Result := nil;
end;

function TRegisterCad.FindClassByChaveAndNewAsObjeto(const Chave: string): TObject;
var
  Clazz: TCadClass;
begin
  Result := nil;
  Clazz := FindClassByChave(Chave);
  if Assigned(Clazz) then
    Result := InstanciarOperacaoAsObjeto(Clazz);
end;

function TRegisterCad.FindClassByChaveAndNewAsInterface(const Chave: string): IInterface;
var
  Clazz: TCadClass;
begin
  Result := nil;
  Clazz := FindClassByChave(Chave);
  if Assigned(Clazz) then
    Result := InstanciarOperacaoAsInterface(Clazz);
end;

function TRegisterCad.FindClassByNome(const Nome: string): TCadClass;
var
  Index: Integer;
begin
  Index := FRegisteredClasses.IndexOfObject(TObject(Nome));
  if Index <> -1 then
    Result := TCadClass(FRegisteredClasses.Objects[Index])
  else
    Result := nil;
end;

function TRegisterCad.InstanciarOperacaoAsObjeto(Clazz: TCadClass): TObject;
begin
  Result := Clazz.Create(nil);
end;

function TRegisterCad.InstanciarOperacaoAsInterface(Clazz: TCadClass): IInterface;
begin
  Result := Clazz.Create(nil) as IInterface;
end;

procedure TRegisterCad.Clear;
begin
  FRegisteredClasses.Clear;
end;

function TRegisterCad.IsEmpty: Boolean;
begin
  Result := FRegisteredClasses.Count = 0;
end;

function TRegisterCad.GetClasses: TStringList;
begin
  Result := FRegisteredClasses;
end;

procedure RegistrarCadClasse(const Chave: string; Clazz: TCadClass);
begin
  TRegisterCad.New.RegisterClass(Chave, Clazz);
end;

initialization

finalization
  TRegisterCad.PrivateDestroy;

end.

