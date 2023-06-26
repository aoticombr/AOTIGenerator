unit ulib.registro.pesq;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, ufrm.padrao.pesq;

type
  TRegisterPesq = class
  strict private
    class var FRegistrarFormClass: TRegisterPesq;
  private
    FRegisteredClasses: TStringList;
    function GetClasses: TStringList;
    constructor Create;
  public
    destructor Destroy; override;
    class function New: TRegisterPesq;
    class procedure PrivateDestroy;
  public
    procedure RegisterClass(const Chave: string; Clazz: TPesqClass);
    function FindClassByChave(const Chave: string): TPesqClass;
    function FindClassByChaveAndNewAsObjeto(const Chave: string): TObject;
    function FindClassByChaveAndNewAsInterface(const Chave: string): IInterface;
    function FindClassByNome(const Nome: string): TPesqClass;
    function InstanciarOperacaoAsObjeto(Clazz: TPesqClass): TObject;
    function InstanciarOperacaoAsInterface(Clazz: TPesqClass): IInterface;

    procedure Clear;
    function IsEmpty: Boolean;

    property Classes: TStringList read GetClasses;
  end;

  procedure RegistrarPesqClasse(const Chave: string; Clazz: TPesqClass);

implementation

class function TRegisterPesq.New: TRegisterPesq;
begin
  if FRegistrarFormClass = nil then
    FRegistrarFormClass := TRegisterPesq.Create;
  Result := FRegistrarFormClass;
end;

class procedure TRegisterPesq.PrivateDestroy;
begin
  FRegistrarFormClass.Free;
end;

constructor TRegisterPesq.Create;
begin
  FRegisteredClasses := TStringList.Create;
  FRegisteredClasses.CaseSensitive := False;
  FRegisteredClasses.Duplicates := dupError;
end;

destructor TRegisterPesq.Destroy;
begin
  FRegisteredClasses.Free;
  inherited;
end;

procedure TRegisterPesq.RegisterClass(const Chave: string; Clazz: TPesqClass);
begin
  FRegisteredClasses.AddObject(Chave, TObject(Clazz));
end;

function TRegisterPesq.FindClassByChave(const Chave: string): TPesqClass;
var
  Index: Integer;
begin
  Index := FRegisteredClasses.IndexOf(Chave);
  if Index <> -1 then
    Result := TPesqClass(FRegisteredClasses.Objects[Index])
  else
    Result := nil;
end;

function TRegisterPesq.FindClassByChaveAndNewAsObjeto(const Chave: string): TObject;
var
  Clazz: TPesqClass;
begin
  Result := nil;
  Clazz := FindClassByChave(Chave);
  if Assigned(Clazz) then
    Result := InstanciarOperacaoAsObjeto(Clazz);
end;

function TRegisterPesq.FindClassByChaveAndNewAsInterface(const Chave: string): IInterface;
var
  Clazz: TPesqClass;
begin
  Result := nil;
  Clazz := FindClassByChave(Chave);
  if Assigned(Clazz) then
    Result := InstanciarOperacaoAsInterface(Clazz);
end;

function TRegisterPesq.FindClassByNome(const Nome: string): TPesqClass;
var
  Index: Integer;
begin
  Index := FRegisteredClasses.IndexOfObject(TObject(Nome));
  if Index <> -1 then
    Result := TPesqClass(FRegisteredClasses.Objects[Index])
  else
    Result := nil;
end;

function TRegisterPesq.InstanciarOperacaoAsObjeto(Clazz: TPesqClass): TObject;
begin
  Result := Clazz.Create(nil);
end;

function TRegisterPesq.InstanciarOperacaoAsInterface(Clazz: TPesqClass): IInterface;
begin
  Result := Clazz.Create(nil) as IInterface;
end;

procedure TRegisterPesq.Clear;
begin
  FRegisteredClasses.Clear;
end;

function TRegisterPesq.IsEmpty: Boolean;
begin
  Result := FRegisteredClasses.Count = 0;
end;

function TRegisterPesq.GetClasses: TStringList;
begin
  Result := FRegisteredClasses;
end;

procedure RegistrarPesqClasse(const Chave: string; Clazz: TPesqClass);
begin
  TRegisterPesq.New.RegisterClass(Chave, Clazz);
end;

initialization

finalization
  TRegisterPesq.PrivateDestroy;

end.

