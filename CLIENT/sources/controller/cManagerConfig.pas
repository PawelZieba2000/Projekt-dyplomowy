unit cManagerConfig;

interface

type
  TManagerConfig = class
    private
    const
      INI_API_REGION = 'API';
      INI_API_KEY_URL = 'API_URL';
      INI_API_KEY_LOG_PATH = 'API_LOG_PATH';

      INI_SCALE_REGION = 'SCALE';
      INI_SCALE_KEY_IP = 'SCALE_IP';
      INI_SCALE_KEY_PORT = 'SCALE_PORT';
    private
      FApiUrl : String;
      FApiLogPath : String;

      FScaleIP : String;
      FScalePort : Integer;

      function GetConfigFilePath() : String;

      property ConfigFilePath : String read GetConfigFilePath;

      class var FInstance : TManagerConfig;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      property ApiUrl : String read FApiUrl write FApiUrl;
      property ApiLogPath : String read FApiLogPath write FApiLogPath;
      property ScaleIP : String read FScaleIP write FScaleIP;
      property ScalePort : Integer read FScalePort write FScalePort;

      procedure SaveConfig();
      procedure LoadConfig();

      constructor Create(); overload;
      class function Instance : TManagerConfig;
      class procedure ReleaseInstance;
  end;


implementation

uses
  System.SysUtils, System.IniFiles, Vcl.Forms, uConsts, cHelpFunctions;

{ TManagerAdditionalData }

constructor TManagerConfig.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
  FreeAndNil(Self);
end;

constructor TManagerConfig.CreateInstance;
begin
  inherited Create;

  Self.FApiUrl := '';
  Self.FApiLogPath := '';
  Self.FScaleIP := '0.0.0.0';
  Self.FScalePort := 0;
end;

destructor TManagerConfig.Destroy;
begin
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
      Self.ApiUrl := ReadString(INI_API_REGION, INI_API_KEY_URL, EMPTY_STR);
      Self.ApiLogPath := ReadString(INI_API_REGION, INI_API_KEY_LOG_PATH, EMPTY_STR);

      Self.ScaleIP := ReadString(INI_SCALE_REGION, INI_SCALE_KEY_IP, EMPTY_STR);
      Self.ScalePort := ReadInteger(INI_SCALE_REGION, INI_SCALE_KEY_PORT, EMPTY_INT);
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
      WriteString(INI_API_REGION, INI_API_KEY_URL, Self.ApiUrl);
      WriteString(INI_API_REGION, INI_API_KEY_LOG_PATH, Self.ApiLogPath);

      WriteString(INI_SCALE_REGION, INI_SCALE_KEY_IP, Self.ScaleIP);
      WriteInteger(INI_SCALE_REGION, INI_SCALE_KEY_PORT, Self.ScalePort);
    end;
  finally
    confIniFile.Free;
  end;

  Self.LoadConfig();
end;

end.
