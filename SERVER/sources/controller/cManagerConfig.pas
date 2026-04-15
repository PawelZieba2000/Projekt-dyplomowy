unit cManagerConfig;

interface

uses
  cConfig;

type
  TManagerConfig = class
    private
    const
      INI_API_REGION = 'API';
      INI_API_KEY_PORT = 'API_PORT';
      INI_API_KEY_LOG_PATH = 'API_LOG_PATH';
      INI_API_KEY_USE_SSL = 'API_USE_SSL';
      INI_API_KEY_CERT_FILE = 'API_CERT_FILE';
      INI_API_KEY_ROOT_CERT_FILE = 'API_ROOT_CERT_FILE';
      INI_API_KEY_KEY_FILE = 'API_KEY_FILE';

      INI_DATABASE_REGION = 'DATABASE';
      INI_DATABASE_KEY_DB_SERVER = 'DB_SERVER';
      INI_DATABASE_KEY_DB_PORT = 'DB_PORT';
      INI_DATABASE_KEY_DB_PATH = 'DB_PATH';
      INI_DATABASE_KEY_DB_USERNAME = 'DB_USERNAME';
      INI_DATABASE_KEY_DB_PASSWORD = 'DB_PASSWORD';
    private
      FRestServerConfig : TRestServerConfig;
      FDatabaseConfig : TDataBaseConfig;

      function GetConfigFilePath() : String;

      property ConfigFilePath : String read GetConfigFilePath;

      class var FInstance : TManagerConfig;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      property RestServerConfig : TRestServerConfig read FRestServerConfig write FRestServerConfig;
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

  Self.FRestServerConfig := TRestServerConfig.Create();
  Self.FDatabaseConfig := TDataBaseConfig.Create();
end;

destructor TManagerConfig.Destroy;
begin
  Self.FRestServerConfig.Free;
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
      Self.RestServerConfig.ApiPort := ReadInteger(INI_API_REGION, INI_API_KEY_PORT, EMPTY_INT);
      Self.RestServerConfig.ApiLogPath := ReadString(INI_API_REGION, INI_API_KEY_LOG_PATH, EMPTY_STR);
      Self.RestServerConfig.ApiUseSSL := ReadBool(INI_API_REGION, INI_API_KEY_USE_SSL, EMPTY_BOOL);
      Self.RestServerConfig.ApiCertFile := ReadString(INI_API_REGION, INI_API_KEY_CERT_FILE, EMPTY_STR);
      Self.RestServerConfig.ApiRootCertFile := ReadString(INI_API_REGION, INI_API_KEY_ROOT_CERT_FILE, EMPTY_STR);
      Self.RestServerConfig.ApiKeyFile := ReadString(INI_API_REGION, INI_API_KEY_KEY_FILE, EMPTY_STR);

      Self.DatabaseConfig.DbServer := ReadString(INI_DATABASE_REGION, INI_DATABASE_KEY_DB_SERVER, EMPTY_STR);
      Self.DatabaseConfig.DbPort := ReadInteger(INI_DATABASE_REGION, INI_DATABASE_KEY_DB_PORT, EMPTY_INT);
      Self.DatabaseConfig.DbPath := ReadString(INI_DATABASE_REGION, INI_DATABASE_KEY_DB_PATH, EMPTY_STR);
      Self.DatabaseConfig.DbUsername := ReadString(INI_DATABASE_REGION, INI_DATABASE_KEY_DB_USERNAME, EMPTY_STR);
      Self.DatabaseConfig.DbPassword := ReadString(INI_DATABASE_REGION, INI_DATABASE_KEY_DB_PASSWORD, EMPTY_STR);
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
      WriteInteger(INI_API_REGION, INI_API_KEY_PORT, Self.RestServerConfig.ApiPort);
      WriteString(INI_API_REGION, INI_API_KEY_LOG_PATH, Self.RestServerConfig.ApiLogPath);
      WriteBool(INI_API_REGION, INI_API_KEY_USE_SSL, Self.RestServerConfig.ApiUseSSL);
      WriteString(INI_API_REGION, INI_API_KEY_CERT_FILE, Self.RestServerConfig.ApiCertFile);
      WriteString(INI_API_REGION, INI_API_KEY_ROOT_CERT_FILE, Self.RestServerConfig.ApiRootCertFile);
      WriteString(INI_API_REGION, INI_API_KEY_KEY_FILE, Self.RestServerConfig.ApiKeyFile);

      WriteString(INI_DATABASE_REGION, INI_DATABASE_KEY_DB_SERVER, Self.DatabaseConfig.DbServer);
      WriteInteger(INI_DATABASE_REGION, INI_DATABASE_KEY_DB_PORT, Self.DatabaseConfig.DbPort);
      WriteString(INI_DATABASE_REGION, INI_DATABASE_KEY_DB_PATH, Self.DatabaseConfig.DbPath);
      WriteString(INI_DATABASE_REGION, INI_DATABASE_KEY_DB_USERNAME, Self.DatabaseConfig.DbUsername);
      WriteString(INI_DATABASE_REGION, INI_DATABASE_KEY_DB_PASSWORD, Self.DatabaseConfig.DbPassword);
    end;
  finally
    confIniFile.Free;
  end;

  Self.LoadConfig();
end;

end.
