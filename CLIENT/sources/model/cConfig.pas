unit cConfig;

interface

uses
  cTypes, CPort;

type
  TScaleConfig = class;
  TRestClientConfig = class;

  TScaleConfig = class
    private
      FConnType : TScaleConnType;
      FScaleProtocolType : TScaleProtocolType;

      FTcpIpAddress : String;
      FTcpPort : Integer;

      FComPort : TPort;
      FBaudRate : TBaudRate;
      FDataBits : TDataBits;
      FParityBits : TParityBits;
      FStopBits : TStopBits;
      FFlowControl : TFlowControl;
    public
      property ConnType : TScaleConnType read FConnType write FConnType;
      property ScaleProtocolType : TScaleProtocolType read FScaleProtocolType write FScaleProtocolType;

      property TcpIpAddress : String read FTcpIpAddress write FTcpIpAddress;
      property TcpPort : Integer read FTcpPort write FTcpPort;

      property ComPort : TPort read FComPort write FComPort;
      property BaudRate : TBaudRate read FBaudRate write FBaudRate;
      property DataBits : TDataBits read FDataBits write FDataBits;
      property ParityBits : TParityBits read FParityBits write FParityBits;
      property StopBits : TStopBits read FStopBits write FStopBits;
      property FlowControl : TFlowControl read FFlowControl write FFlowControl;

      procedure SetDefaultValues();

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

  TRestClientConfig = class
    private
      FApiUrl : String;
      FApiLogPath : String;
    public
      property ApiUrl : String read FApiUrl write FApiUrl;
      property ApiLogPath : String read FApiLogPath write FApiLogPath;

      procedure SetDefaultValues();

      constructor Create(); overload;
      destructor Destroy(); override;
  end;

implementation

{ TScaleConfig }

constructor TScaleConfig.Create;
begin
  inherited;
  Self.SetDefaultValues();
end;

destructor TScaleConfig.Destroy;
begin
  inherited;
end;

procedure TScaleConfig.SetDefaultValues;
begin
  Self.ConnType := sctNone;
  Self.ScaleProtocolType := sptNone;

  Self.TcpIpAddress := '';
  Self.TcpPort := 0;

  Self.ComPort := '';
  Self.BaudRate := brCustom;
  Self.DataBits := dbFive;
  Self.ParityBits := prNone;
  Self.StopBits := sbOneStopBit;
  Self.FlowControl := fcHardware;
end;

{ TRestClientConfig }

constructor TRestClientConfig.Create;
begin
  inherited;
  Self.SetDefaultValues;
end;

destructor TRestClientConfig.Destroy;
begin
  inherited;
end;

procedure TRestClientConfig.SetDefaultValues;
begin
  Self.ApiUrl := '';
  Self.ApiLogPath := '';
end;

end.
