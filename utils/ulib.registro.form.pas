unit ulib.registro.form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms;

type
  TRegisterForms = class
  strict private
    class var FRegistrarFormClass: TRegisterForms;
  private
    FRegisteredClasses: TStringList;
    function GetClasses: TStringList;
    constructor Create;
  public
    destructor Destroy; override;
    class function New: TRegisterForms;
    class procedure PrivateDestroy;
  public
    procedure RegisterClass(const Chave: string; Clazz: TFormClass);
    function FindClassByChave(const Chave: string): TFormClass;
    function FindClassByChaveAndNewAsObjeto(const Chave: string): TObject;
    function FindClassByChaveAndNewAsInterface(const Chave: string): IInterface;
    function FindClassByNome(const Nome: string): TFormClass;
    function InstanciarOperacaoAsObjeto(Clazz: TFormClass): TObject;
    function InstanciarOperacaoAsInterface(Clazz: TFormClass): IInterface;

    procedure Clear;
    function IsEmpty: Boolean;

    property Classes: TStringList read GetClasses;
  end;

  procedure RegistrarFormClasse(const Chave: string; Clazz: TFormClass);

implementation

class function TRegisterForms.New: TRegisterForms;
begin
  if FRegistrarFormClass = nil then
    FRegistrarFormClass := TRegisterForms.Create;
  Result := FRegistrarFormClass;
end;

class procedure TRegisterForms.PrivateDestroy;
begin
  FRegistrarFormClass.Free;
end;

constructor TRegisterForms.Create;
begin
  FRegisteredClasses := TStringList.Create;
  FRegisteredClasses.CaseSensitive := False;
  FRegisteredClasses.Duplicates := dupError;
end;

destructor TRegisterForms.Destroy;
begin
  FRegisteredClasses.Free;
  inherited;
end;

procedure TRegisterForms.RegisterClass(const Chave: string; Clazz: TFormClass);
begin
  FRegisteredClasses.AddObject(Chave, TObject(Clazz));
end;

function TRegisterForms.FindClassByChave(const Chave: string): TFormClass;
var
  Index: Integer;
begin
  Index := FRegisteredClasses.IndexOf(Chave);
  if Index <> -1 then
    Result := TFormClass(FRegisteredClasses.Objects[Index])
  else
    Result := nil;
end;

function TRegisterForms.FindClassByChaveAndNewAsObjeto(const Chave: string): TObject;
var
  Clazz: TFormClass;
begin
  Result := nil;
  Clazz := FindClassByChave(Chave);
  if Assigned(Clazz) then
    Result := InstanciarOperacaoAsObjeto(Clazz);
end;

function TRegisterForms.FindClassByChaveAndNewAsInterface(const Chave: string): IInterface;
var
  Clazz: TFormClass;
begin
  Result := nil;
  Clazz := FindClassByChave(Chave);
  if Assigned(Clazz) then
    Result := InstanciarOperacaoAsInterface(Clazz);
end;

function TRegisterForms.FindClassByNome(const Nome: string): TFormClass;
var
  Index: Integer;
begin
  Index := FRegisteredClasses.IndexOfObject(TObject(Nome));
  if Index <> -1 then
    Result := TFormClass(FRegisteredClasses.Objects[Index])
  else
    Result := nil;
end;

function TRegisterForms.InstanciarOperacaoAsObjeto(Clazz: TFormClass): TObject;
begin
  Result := Clazz.Create(nil);
end;

function TRegisterForms.InstanciarOperacaoAsInterface(Clazz: TFormClass): IInterface;
begin
  Result := Clazz.Create(nil) as IInterface;
end;

procedure TRegisterForms.Clear;
begin
  FRegisteredClasses.Clear;
end;

function TRegisterForms.IsEmpty: Boolean;
begin
  Result := FRegisteredClasses.Count = 0;
end;

function TRegisterForms.GetClasses: TStringList;
begin
  Result := FRegisteredClasses;
end;

procedure RegistrarFormClasse(const Chave: string; Clazz: TFormClass);
begin
  TRegisterForms.New.RegisterClass(Chave, Clazz);
end;

initialization

finalization
  TRegisterForms.PrivateDestroy;

end.

