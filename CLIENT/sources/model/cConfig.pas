unit cConfig;

interface

uses
  cTypes, CPort, cItemTranssProtocol;

type
  TScaleConfig = class;
  TRestClientConfig = class;

  TScaleConfig = class
    private
      FIsActive : Boolean;

      FConnType : TScaleConnType;
      FScaleTranssProtocol : TItemTranssProtocol;

      FTcpIpAddress : String;
      FTcpPort : Integer;

      FComPort : TPort;
      FBaudRate : TBaudRate;
      FDataBits : TDataBits;
      FParityBits : TParityBits;
      FStopBits : TStopBits;
      FFlowControl : TFlowControl;
    public
      property IsActive : Boolean read FIsActive write FIsActive;
      property ConnType : TScaleConnType read FConnType write FConnType;
      property ScaleTranssProtocol : TItemTranssProtocol read FScaleTranssProtocol write FScaleTranssProtocol;

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
  Self.FScaleTranssProtocol := TItemTranssProtocol.Create();
  Self.SetDefaultValues();
end;

destructor TScaleConfig.Destroy;
begin
  Self.FScaleTranssProtocol.Free;
  inherited;
end;

procedure TScaleConfig.SetDefaultValues;
begin
  Self.IsActive := False;

  Self.ConnType := sctNone;
  Self.ScaleTranssProtocol.SetDefaultValues;

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
