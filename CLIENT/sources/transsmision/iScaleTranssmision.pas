unit IScaleTranssmision;

interface

uses
  cTypes;

type
  IScaleTranss = interface
  ['{C0D6C191-1613-4131-B26E-F0DF312F7D1C}']
    function GetScaleConnected() : Boolean;
    function GetReadMassEvent() : TReadMassFromDeviceEvent;
    procedure SetReadMassEvent(const pValue : TReadMassFromDeviceEvent);
    function GetConnectionEvent() : TTransmisionWithDeviceEvent;
    procedure SetConnectionEvent(const pValue : TTransmisionWithDeviceEvent);
    function GetMassFromDevice() : Double;

    property ScaleConnected : Boolean read GetScaleConnected;
    property MassFromDevice : Double read GetMassFromDevice;
    property ConnectionEvent : TTransmisionWithDeviceEvent read GetConnectionEvent write SetConnectionEvent;
    property ReadMassEvent : TReadMassFromDeviceEvent read GetReadMassEvent write SetReadMassEvent;

    procedure Connect();
    procedure Disconnect();
  end;

implementation

end.
