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
      INI_SCALE_IS_ACTIVE = 'SCALE_IS_ACTIVE';
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
      FRestClientConfig : TRestServerConfig;
      FDatabaseConfig : TDataBaseConfig;

      function GetConfigFilePath() : String;

      property ConfigFilePath : String read GetConfigFilePath;

      class var FInstance : TManagerConfig;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      property RestClientConfig : TRestServerConfig read FRestClientConfig write FRestClientConfig;
      property DatabaseConfig : TDataBaseConfig read FDatabaseConfig write FDatabaseConfig;

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

  Self.FRestClientConfig := TRestServerConfig.Create();
  Self.FDatabaseConfig := TDataBaseConfig.Create();
end;

destructor TManagerConfig.Destroy;
begin
  Self.FRestClientConfig.Free;
  Self.FDatabaseConfig.Free;

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

//      Self.DatabaseConfig.IsActive := ReadBool(INI_SCALE_REGION, INI_SCALE_IS_ACTIVE, False);
//      Self.DatabaseConfig.ConnType := TScaleConnType(ReadInteger(INI_SCALE_REGION, INI_SCALE_CONN_TYPE, EMPTY_INT));
//      Self.DatabaseConfig.ScaleProtocolType := TScaleProtocolType(ReadInteger(INI_SCALE_REGION, INI_SCALE_PROTOCOL_TYPE, EMPTY_INT));
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

      //WriteBool(INI_SCALE_REGION, INI_SCALE_IS_ACTIVE, Self.FDatabaseConfig.IsActive);
      //WriteInteger(INI_SCALE_REGION, INI_SCALE_CONN_TYPE, Integer(Self.FDatabaseConfig.ConnType));
      //WriteInteger(INI_SCALE_REGION, INI_SCALE_PROTOCOL_TYPE, Integer(Self.FDatabaseConfig.ScaleProtocolType));
      //WriteString(INI_SCALE_REGION, INI_SCALE_KEY_IP, Self.FDatabaseConfig.TcpIpAddress);
      //WriteInteger(INI_SCALE_REGION, INI_SCALE_KEY_PORT, Self.FDatabaseConfig.TcpPort);
      //WriteString(INI_SCALE_REGION, INI_SCALE_COM_PORT, Self.FDatabaseConfig.ComPort);
      //WriteInteger(INI_SCALE_REGION, INI_SCALE_BAUD_RATE, Integer(Self.FDatabaseConfig.BaudRate));
      //WriteInteger(INI_SCALE_REGION, INI_SCALE_DATA_BITS, Integer(Self.FDatabaseConfig.DataBits));
      //WriteInteger(INI_SCALE_REGION, INI_SCALE_PARITY_BITS, Integer(Self.FDatabaseConfig.ParityBits));
      //WriteInteger(INI_SCALE_REGION, INI_SCALE_STOP_BITS, Integer(Self.FDatabaseConfig.StopBits));
      //WriteInteger(INI_SCALE_REGION, INI_SCALE_FLOW_CONTROL, Integer(Self.FDatabaseConfig.FlowControl));
    end;
  finally
    confIniFile.Free;
  end;

  Self.LoadConfig();
end;

end.
