{******************************************************************************}
{                                                                              }
{       WiRL: RESTful Library for Delphi                                       }
{                                                                              }
{       Copyright (c) 2015-2021 WiRL Team                                      }
{                                                                              }
{       https://github.com/delphi-blocks/WiRL                                  }
{                                                                              }
{******************************************************************************}
unit WiRL.Core.GarbageCollector;

interface

uses
  System.SysUtils, System.Rtti, System.Generics.Defaults, System.Generics.Collections;

type
  TWiRLGarbageCollector = class
  private
    FGarbage: TArray<TValue>;
    procedure CollectSingleGarbage(const AValue: TValue);
  public
    constructor Create;

    procedure AddGarbage(const AValue: TValue);
    procedure CollectGarbage();
  end;

implementation

uses
  WiRL.Core.Attributes,
  WiRL.Rtti.Utils;

{ TWiRLGarbageCollector }

constructor TWiRLGarbageCollector.Create;
begin
  FGarbage := [];
end;

procedure TWiRLGarbageCollector.AddGarbage(const AValue: TValue);
begin
  FGarbage := FGarbage + [AValue];
end;

procedure TWiRLGarbageCollector.CollectGarbage;
var
  LIndex: Integer;
begin
  for LIndex := 0 to High(FGarbage) do
    CollectSingleGarbage(FGarbage[LIndex]);
  FGarbage := [];
end;

procedure TWiRLGarbageCollector.CollectSingleGarbage(const AValue: TValue);
var
  LIndex: Integer;
  //LIntfObj: TObject;
begin
  case AValue.Kind of
    tkClass:
    begin
      if (AValue.AsObject <> nil) then
        if not TRttiHelper.HasAttribute<SingletonAttribute>(AValue.AsObject.ClassType) then
          AValue.AsObject.Free;
    end;

    { TODO -opaolo -c : RefCounted or Not?? 24/10/2021 10:47:46 }
//    tkInterface:
//    begin
//      AValue.AsInterface.QueryInterface()
//      LIntfObj := TObject(AValue.AsInterface);
//      // If RefCounted do nothing
//      // If not RefCounted call free on the implementor (TObject)
//
//    end;

    tkArray,
    tkDynArray:
    begin
      for LIndex := 0 to AValue.GetArrayLength - 1 do
        CollectSingleGarbage(AValue.GetArrayElement(LIndex));
    end;
  end;
end;

end.
