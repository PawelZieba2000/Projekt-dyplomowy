unit cManagerConfig;

interface

uses
  cConfig, System.Generics.Collections, cItemTranssProtocol,
  cDataSourceTranssProtocols;

type
  TManagerConfig = class
    private
    const
      INI_GENERAL_REGION = 'GENERAL';
      INI_GENERAL_TRNSS_PRTCL_NO = 'TRNSS_PRTCL_NO';

      INI_API_REGION = 'API';
      INI_API_KEY_URL = 'API_URL';
      INI_API_KEY_LOG_PATH = 'API_LOG_PATH';

      INI_SCALE_REGION = 'SCALE';
      INI_SCALE_IS_ACTIVE = 'SCALE_IS_ACTIVE';
      INI_SCALE_CONN_TYPE = 'SCALE_CONN_TYPE';
      INI_SCALE_PROTOCOL_ID = 'SCALE_PROTOCOL_ID';
      INI_SCALE_KEY_IP = 'SCALE_IP';
      INI_SCALE_KEY_PORT = 'SCALE_PORT';

      INI_SCALE_COM_PORT = 'SCALE_COM_PORT';
      INI_SCALE_BAUD_RATE = 'SCALE_BAUD_RATE';
      INI_SCALE_DATA_BITS = 'SCALE_DATA_BITS';
      INI_SCALE_PARITY_BITS = 'SCALE_PARITY_BITS';
      INI_SCALE_STOP_BITS = 'SCALE_STOP_BITS';
      INI_SCALE_FLOW_CONTROL = 'SCALE_FLOW_CONTROL';

      INI_TRANSS_PROTO_REGION_PREFIX = 'TRANSS_PROTO_';
      INI_TRANSS_PROTO_NAME = 'NAME';
      INI_TRANSS_PROTO_MESSAGE_TO_DEVICE = 'MESSAGE_TO_DEVICE';
      INI_TRANSS_PROTO_FRAME_BEGINNING = 'FRAME_BEGINNING';
      INI_TRANSS_PROTO_FRAME_ENDING = 'FRAME_ENDING';
      INI_TRANSS_PROTO_FRAME_LENGTH = 'FRAME_LENGTH';
      INI_TRANSS_PROTO_MASS_POS_START = 'MASS_POS_START';
      INI_TRANSS_PROTO_MASS_POS_END = 'MASS_POS_END';
      INI_TRANSS_PROTO_STABLE_POS = 'STABLE_POS';
      INI_TRANSS_PROTO_STABLE_SYMBOL = 'STABLE_SYMBOL';
    private
      FRestClientConfig : TRestClientConfig;
      FScaleConfig : TScaleConfig;

      FTranssProtocolList : TObjectList<TItemTranssProtocol>;
      FTranssProtocolDS : TDataSourceTranssProtocols;

      function GetConfigFilePath() : String;

      property ConfigFilePath : String read GetConfigFilePath;

      class var FInstance : TManagerConfig;
      constructor CreateInstance;
      destructor Destroy(); override;
    public
      property RestClientConfig : TRestClientConfig read FRestClientConfig write FRestClientConfig;
      property ScaleConfig : TScaleConfig read FScaleConfig write FScaleConfig;
      property TranssProtocolList : TObjectList<TItemTranssProtocol> read FTranssProtocolList;
      property TranssProtocolDS : TDataSourceTranssProtocols read FTranssProtocolDS;

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

  Self.FTranssProtocolList := TObjectList<TItemTranssProtocol>.Create();
  Self.FTranssProtocolDS := TDataSourceTranssProtocols.Create(Self.FTranssProtocolList);
end;

destructor TManagerConfig.Destroy;
begin
  Self.FRestClientConfig.Free;
  Self.FScaleConfig.Free;
  Self.FTranssProtocolList.Free;

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

      Self.ScaleConfig.IsActive := ReadBool(INI_SCALE_REGION, INI_SCALE_IS_ACTIVE, False);
      Self.ScaleConfig.ConnType := TScaleConnType(ReadInteger(INI_SCALE_REGION, INI_SCALE_CONN_TYPE, EMPTY_INT));

      var scaleProtocolId : Integer := ReadInteger(INI_SCALE_REGION, INI_SCALE_PROTOCOL_ID, EMPTY_INT);

      Self.ScaleConfig.TcpIpAddress := ReadString(INI_SCALE_REGION, INI_SCALE_KEY_IP, EMPTY_STR);
      Self.ScaleConfig.TcpPort := ReadInteger(INI_SCALE_REGION, INI_SCALE_KEY_PORT, EMPTY_INT);

      Self.ScaleConfig.ComPort := ReadString(INI_SCALE_REGION, INI_SCALE_COM_PORT, EMPTY_STR);
      Self.ScaleConfig.BaudRate := TBaudRate(ReadInteger(INI_SCALE_REGION, INI_SCALE_BAUD_RATE, EMPTY_INT));
      Self.ScaleConfig.DataBits := TDataBits(ReadInteger(INI_SCALE_REGION, INI_SCALE_DATA_BITS, EMPTY_INT));
      Self.ScaleConfig.ParityBits := TParityBits(ReadInteger(INI_SCALE_REGION, INI_SCALE_PARITY_BITS, EMPTY_INT));
      Self.ScaleConfig.StopBits := TStopBits(ReadInteger(INI_SCALE_REGION, INI_SCALE_STOP_BITS, EMPTY_INT));
      Self.ScaleConfig.FlowControl := TFlowControl(ReadInteger(INI_SCALE_REGION, INI_SCALE_FLOW_CONTROL, EMPTY_INT));

      Self.TranssProtocolList.Clear;
      var protocolCount : Integer := ReadInteger(INI_GENERAL_REGION, INI_GENERAL_TRNSS_PRTCL_NO, EMPTY_INT);
      for var I : Integer := 1 to protocolCount do
      begin
        var transsProtocol : TItemTranssProtocol := TItemTranssProtocol.Create();
        var transsRegion : String := INI_TRANSS_PROTO_REGION_PREFIX + I.ToString;

        transsProtocol.Id := I;
        transsProtocol.Name := ReadString(transsRegion, INI_TRANSS_PROTO_NAME, EMPTY_STR);
        transsProtocol.MessageToDevice := ReadString(transsRegion, INI_TRANSS_PROTO_MESSAGE_TO_DEVICE, EMPTY_STR);
        transsProtocol.FrameBeginning := ReadString(transsRegion, INI_TRANSS_PROTO_FRAME_BEGINNING, EMPTY_STR);
        transsProtocol.FrameEnding := ReadString(transsRegion, INI_TRANSS_PROTO_FRAME_ENDING, EMPTY_STR);
        transsProtocol.FrameLength := ReadInteger(transsRegion, INI_TRANSS_PROTO_FRAME_LENGTH, EMPTY_INT);
        transsProtocol.MassPosStart := ReadInteger(transsRegion, INI_TRANSS_PROTO_MASS_POS_START, EMPTY_INT);
        transsProtocol.MassPosEnd := ReadInteger(transsRegion, INI_TRANSS_PROTO_MASS_POS_END, EMPTY_INT);
        transsProtocol.StablePos := ReadInteger(transsRegion, INI_TRANSS_PROTO_STABLE_POS, EMPTY_INT);
        transsProtocol.StableSymbol := ReadString(transsRegion, INI_TRANSS_PROTO_STABLE_SYMBOL, EMPTY_STR);

        Self.TranssProtocolList.Add(transsProtocol);

        if transsProtocol.Id = scaleProtocolId then
          ScaleConfig.ScaleTranssProtocol.AssignValues(transsProtocol);
      end;
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
  var memIniFile : TMemIniFile := TMemIniFile.Create(Self.ConfigFilePath);
  try
    memIniFile.Clear;
  finally
    memIniFile.Free;
  end;

  var confIniFile : TIniFile := TIniFile.Create(Self.ConfigFilePath);
  try
    with confIniFile do
    begin
      WriteString(INI_API_REGION, INI_API_KEY_URL, Self.RestClientConfig.ApiUrl);
      WriteString(INI_API_REGION, INI_API_KEY_LOG_PATH, Self.RestClientConfig.ApiLogPath);

      WriteBool(INI_SCALE_REGION, INI_SCALE_IS_ACTIVE, Self.ScaleConfig.IsActive);
      WriteInteger(INI_SCALE_REGION, INI_SCALE_CONN_TYPE, Integer(Self.ScaleConfig.ConnType));
      WriteInteger(INI_SCALE_REGION, INI_SCALE_PROTOCOL_ID, Self.ScaleConfig.ScaleTranssProtocol.Id);
      WriteString(INI_SCALE_REGION, INI_SCALE_KEY_IP, Self.ScaleConfig.TcpIpAddress);
      WriteInteger(INI_SCALE_REGION, INI_SCALE_KEY_PORT, Self.ScaleConfig.TcpPort);
      WriteString(INI_SCALE_REGION, INI_SCALE_COM_PORT, Self.ScaleConfig.ComPort);
      WriteInteger(INI_SCALE_REGION, INI_SCALE_BAUD_RATE, Integer(Self.ScaleConfig.BaudRate));
      WriteInteger(INI_SCALE_REGION, INI_SCALE_DATA_BITS, Integer(Self.ScaleConfig.DataBits));
      WriteInteger(INI_SCALE_REGION, INI_SCALE_PARITY_BITS, Integer(Self.ScaleConfig.ParityBits));
      WriteInteger(INI_SCALE_REGION, INI_SCALE_STOP_BITS, Integer(Self.ScaleConfig.StopBits));
      WriteInteger(INI_SCALE_REGION, INI_SCALE_FLOW_CONTROL, Integer(Self.ScaleConfig.FlowControl));

      WriteInteger(INI_GENERAL_REGION, INI_GENERAL_TRNSS_PRTCL_NO, Self.TranssProtocolList.Count);

      for var I : Integer := 0 to Self.TranssProtocolList.Count - 1 do
      begin
        var transsProtocol : TItemTranssProtocol := Self.TranssProtocolList.Items[I];
        var transsRegion : String := INI_TRANSS_PROTO_REGION_PREFIX + (I + 1).ToString;

        WriteString(transsRegion, INI_TRANSS_PROTO_NAME, transsProtocol.Name);
        WriteString(transsRegion, INI_TRANSS_PROTO_MESSAGE_TO_DEVICE, transsProtocol.MessageToDevice);
        WriteString(transsRegion, INI_TRANSS_PROTO_FRAME_BEGINNING, transsProtocol.FrameBeginning);
        WriteString(transsRegion, INI_TRANSS_PROTO_FRAME_ENDING, transsProtocol.FrameEnding);
        WriteInteger(transsRegion, INI_TRANSS_PROTO_FRAME_LENGTH, transsProtocol.FrameLength);
        WriteInteger(transsRegion, INI_TRANSS_PROTO_MASS_POS_START, transsProtocol.MassPosStart);
        WriteInteger(transsRegion, INI_TRANSS_PROTO_MASS_POS_END, transsProtocol.MassPosEnd);
        WriteInteger(transsRegion, INI_TRANSS_PROTO_STABLE_POS, transsProtocol.StablePos);
        WriteString(transsRegion, INI_TRANSS_PROTO_STABLE_SYMBOL, transsProtocol.StableSymbol);
      end;
    end;
  finally
    confIniFile.Free;
  end;

  Self.LoadConfig();
end;

end.
