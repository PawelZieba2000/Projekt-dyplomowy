unit IScaleTranssmision;

interface

uses
  cTypes;

type
  IScaleTranss = interface
  ['{C0D6C191-1613-4131-B26E-F0DF312F7D1C}']
    function GetScaleConnected() : Boolean;
    function GetMassFromDevice() : Double;
    function GetScaleStable() : Boolean;

    property ScaleConnected : Boolean read GetScaleConnected;
    property MassFromDevice : Double read GetMassFromDevice;
    property MassStable : Boolean read GetScaleStable;

    procedure Connect();
    procedure Disconnect();
  end;

implementation

end.
