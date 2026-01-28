unit cManagerConfig;

interface

uses
  cConfig;

type
  TManagerConfig = class
    private
    const
      INI_API_REGION = 'API';
      INI_API_KEY_URL = 'API_URL';
      INI_API_KEY_LOG_PATH = 'API_LOG_PATH';

      INI_SCALE_REGION = 'SCALE';
      INI_SCALE_CONN_TYPE = 'SCALE_CONN_TYPE';
      INI_SCALE_PROTOCOL_TYPE = 'SCALE_PROTOCOL_TYPE';
      INI_SCALE_KEY_IP = 'SCALE_IP';
      INI_SCALE_KEY_PORT = 'SCALE_PORT';

      INI_SCALE_COM_PORT = 'SCALE_COM_PORT';
      INI_SCALE_BAUD_RATE = 'SCALE_BAUD_RATE';
      INI_SCALE_DATA_BITS = 'SCALE_DATA_BITS';
      INI_SCALE_PARITY_BITS = 'SCALE_PARITY_BITS';
      INI_SCALE_STOP_BITS = 'SCALE_STOP_BITS';
      INI_SCALE_FLOW_CONTROL = 'SCALE_FLOW_CONTROL';
    private
      FRestClientConfig : TRestClientConfig;
      FScaleConfig : TScaleConfig;

      function GetConfigFilePath() : String;

      property ConfigFilePath : String read GetConfigFilePath;

      class var FInstance : TManagerConfig;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      property RestClientConfig : TRestClientConfig read FRestClientConfig write FRestClientConfig;
      property ScaleConfig : TScaleConfig read FScaleConfig write FScaleConfig;

      procedure SaveConfig();
      procedure LoadConfig();

      constructor Create(); overload;
      class function Instance : TManagerConfig;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils, System.IniFiles, Vcl.Forms, uConsts, cHelpFunctions, cTypes,
  CPort;

{ TManagerConfig }

constructor TManagerConfig.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
  FreeAndNil(Self);
end;

constructor TManagerConfig.CreateInstance;
begin
  inherited Create;

  Self.FRestClientConfig := TRestClientConfig.Create();
  Self.FScaleConfig := TScaleConfig.Create();
end;

destructor TManagerConfig.Destroy;
begin
  Self.FRestClientConfig.Free;
  Self.FScaleConfig.Free;

  inherited;
end;

function TManagerConfig.GetConfigFilePath: String;
begin
  Result := THelpFunctions.GetCurrentDirectory + ChangeFileExt(THelpFunctions.GetAppName, '.ini');

  if not FileExists(Result) then
  begin
    FileCreate(Result);
    Self.SaveConfig;
  end;
end;

class function TManagerConfig.Instance: TManagerConfig;
begin
  if not Assigned(FInstance) then
    FInstance := TManagerConfig.CreateInstance;

  Result := FInstance;
end;

procedure TManagerConfig.LoadConfig;
begin
  var confIniFile : TIniFile := TIniFile.Create(Self.ConfigFilePath);
  try
    with confIniFile do
    begin
      Self.RestClientConfig.ApiUrl := ReadString(INI_API_REGION, INI_API_KEY_URL, EMPTY_STR);
      Self.RestClientConfig.ApiLogPath := ReadString(INI_API_REGION, INI_API_KEY_LOG_PATH, EMPTY_STR);

      Self.ScaleConfig.ConnType := TScaleConnType(ReadInteger(INI_SCALE_REGION, INI_SCALE_CONN_TYPE, EMPTY_INT));
      Self.ScaleConfig.ScaleProtocolType := TScaleProtocolType(ReadInteger(INI_SCALE_REGION, INI_SCALE_PROTOCOL_TYPE, EMPTY_INT));

      Self.ScaleConfig.TcpIpAddress := ReadString(INI_SCALE_REGION, INI_SCALE_KEY_IP, EMPTY_STR);
      Self.ScaleConfig.TcpPort := ReadInteger(INI_SCALE_REGION, INI_SCALE_KEY_PORT, EMPTY_INT);

      Self.ScaleConfig.ComPort := ReadString(INI_SCALE_REGION, INI_SCALE_COM_PORT, EMPTY_STR);
      Self.ScaleConfig.BaudRate := TBaudRate(ReadInteger(INI_SCALE_REGION, INI_SCALE_BAUD_RATE, EMPTY_INT));
      Self.ScaleConfig.DataBits := TDataBits(ReadInteger(INI_SCALE_REGION, INI_SCALE_DATA_BITS, EMPTY_INT));
      Self.ScaleConfig.ParityBits := TParityBits(ReadInteger(INI_SCALE_REGION, INI_SCALE_PARITY_BITS, EMPTY_INT));
      Self.ScaleConfig.StopBits := TStopBits(ReadInteger(INI_SCALE_REGION, INI_SCALE_STOP_BITS, EMPTY_INT));
      Self.ScaleConfig.FlowControl := TFlowControl(ReadInteger(INI_SCALE_REGION, INI_SCALE_FLOW_CONTROL, EMPTY_INT));
    end;
  finally
    confIniFile.Free;
  end;
end;

class procedure TManagerConfig.ReleaseInstance;
begin
  if Assigned(Self.FInstance) then
    FreeAndNil(Self.FInstance);
end;

procedure TManagerConfig.SaveConfig;
begin
  var confIniFile : TIniFile := TIniFile.Create(Self.ConfigFilePath);
  try
    with confIniFile do
    begin
      WriteString(INI_API_REGION, INI_API_KEY_URL, Self.RestClientConfig.ApiUrl);
      WriteString(INI_API_REGION, INI_API_KEY_LOG_PATH, Self.RestClientConfig.ApiLogPath);

      WriteInteger(INI_SCALE_REGION, INI_SCALE_CONN_TYPE, Integer(Self.ScaleConfig.ConnType));
      WriteInteger(INI_SCALE_REGION, INI_SCALE_PROTOCOL_TYPE, Integer(Self.ScaleConfig.ScaleProtocolType));
      WriteString(INI_SCALE_REGION, INI_SCALE_KEY_IP, Self.ScaleConfig.TcpIpAddress);
      WriteInteger(INI_SCALE_REGION, INI_SCALE_KEY_PORT, Self.ScaleConfig.TcpPort);
      WriteString(INI_SCALE_REGION, INI_SCALE_COM_PORT, Self.ScaleConfig.ComPort);
      WriteInteger(INI_SCALE_REGION, INI_SCALE_BAUD_RATE, Integer(Self.ScaleConfig.BaudRate));
      WriteInteger(INI_SCALE_REGION, INI_SCALE_DATA_BITS, Integer(Self.ScaleConfig.DataBits));
      WriteInteger(INI_SCALE_REGION, INI_SCALE_PARITY_BITS, Integer(Self.ScaleConfig.ParityBits));
      WriteInteger(INI_SCALE_REGION, INI_SCALE_STOP_BITS, Integer(Self.ScaleConfig.StopBits));
      WriteInteger(INI_SCALE_REGION, INI_SCALE_FLOW_CONTROL, Integer(Self.ScaleConfig.FlowControl));
    end;
  finally
    confIniFile.Free;
  end;

  Self.LoadConfig();
end;

end.
