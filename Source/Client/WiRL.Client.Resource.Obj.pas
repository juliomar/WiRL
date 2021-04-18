{******************************************************************************}
{                                                                              }
{       WiRL: RESTful Library for Delphi                                       }
{                                                                              }
{       Copyright (c) 2015-2019 WiRL Team                                      }
{                                                                              }
{       https://github.com/delphi-blocks/WiRL                                  }
{                                                                              }
{******************************************************************************}
unit WiRL.Client.Resource.Obj;

{$I ..\Core\WiRL.inc}

interface

uses
  System.SysUtils, System.Classes,
  WiRL.Core.JSON,
  WiRL.Client.Resource,
  WiRL.http.Client.Interfaces,
  WiRL.http.Client;

type
  {$IFDEF HAS_NEW_PIDS}
  //[ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator32 or pidiOSDevice32 or pidAndroid32Arm)]
  {$ELSE}
  //[ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid)]
  {$ENDIF}
  TWiRLClientResourceObject = class(TWiRLClientResource)
  private
    FResponseObject: TComponent;
    FRequestObject: TComponent;
  published
    property ResponseObject: TComponent read FResponseObject write FResponseObject;
    property RequestObject: TComponent read FRequestObject write FRequestObject;
  end;

implementation

end.