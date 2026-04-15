unit cScaleTranssmision;

interface

uses
  System.Classes, OverbyteIcsWndControl, OverbyteIcsWSocket, Vcl.ExtCtrls,
  System.SysUtils, cTypes, CPort, cConfig, iScaleTranssmision,
  cItemTranssProtocol;

type
  TScaleTranss = class(TInterfacedObject, IScaleTranss)
    private
      FDeviceClient : TWSocket;
      FComPort : TComPort;

      FConnConfig : TScaleConfig;
      FScaleTranssProtocol : TItemTranssProtocol;

      FTimerTimeOut : TTimer;
      FTimerSend : TTimer;

      FTimeOutCounter : Integer;
      FReceiveData : AnsiString;
      FConnectedWithDevice : Boolean;
      FMassFromDevice : Double;

      FNewMassDT : TDateTime;

      FMassStable : Boolean;

      procedure AfterConnect(Sender: TObject; Error: Word);
      procedure AfterDisconnect(Sender: TObject; Error: Word);
      procedure DataAvailable(Sender: TObject; Error: Word);

      procedure AfterOpen(Sender: TObject);
      procedure AfterClose(Sender: TObject);
      procedure OnRxChar(Sender: TObject; Count: Integer);

      function ReceiveData(pTxt : AnsiString) : Boolean;
      function FormatReceivedData() : Boolean;

      procedure TimerSendExecute(Sender: TObject);
      procedure TimerTimeOutExecute(Sender: TObject);

      procedure SetConnConfig(const pValue : TScaleConfig);

      function GetScaleConnected() : Boolean;
      function GetMassFromDevice() : Double;

      procedure ConnectTcpIp;
      procedure ConnectSerial;

      procedure DisconnectTcpIp;
      procedure DisconnectSerial;

      procedure SetMassFromDevice(const Value: Double);

      function GetScaleStable() : Boolean;

      property MassFromDevicePriv : Double read GetMassFromDevice write SetMassFromDevice;
    public
      property ScaleConnected : Boolean read GetScaleConnected;
      property MassFromDevice : Double read GetMassFromDevice;
      property MassStable : Boolean read GetScaleStable;

      procedure Connect;
      procedure Disconnect;

      constructor Create(); overload;
      constructor Create(const pValue : TScaleConfig); overload;
      destructor  Destroy; override;
  end;

implementation
uses
  Vcl.Dialogs, OverbyteIcsTypes, uConsts, Winapi.Windows,
  System.DateUtils, frmWeighing;

procedure TScaleTranss.AfterClose(Sender: TObject);
begin
  FConnectedWithDevice := False;
end;

procedure TScaleTranss.AfterConnect(Sender: TObject; Error: Word);
begin
  FTimeOutCounter := 0;
  FReceiveData := '';
  if Self.FScaleTranssProtocol.MessageToDevice <> '' then
    FTimerSend.Enabled := True;
end;

procedure TScaleTranss.AfterDisconnect(Sender: TObject; Error: Word);
begin
  FConnectedWithDevice := False;
  if Self.ScaleConnected then
    FDeviceClient.Close;
end;

procedure TScaleTranss.AfterOpen(Sender: TObject);
begin
  FTimeOutCounter := 0;
  FReceiveData := '';

  if Self.FScaleTranssProtocol.MessageToDevice <> '' then
    FTimerSend.Enabled := True;
end;

procedure TScaleTranss.Connect;
begin
  Self.MassFromDevicePriv := SCALE_WRONG_MASS;
  Self.FMassStable := False;

  case Self.FConnConfig.ConnType of
    sctSerialPort: Self.ConnectSerial;
    sctTcpIp: Self.ConnectTcpIp;
  end;
end;

procedure TScaleTranss.ConnectSerial;
begin
  if FComPort.Connected then
    Exit;

  FComPort.Port := Self.FConnConfig.ComPort;
  FComPort.BaudRate := Self.FConnConfig.BaudRate;
  FComPort.DataBits := Self.FConnConfig.DataBits;
  FComPort.Parity.Bits := Self.FConnConfig.ParityBits;
  FComPort.Parity.Check := FComPort.Parity.Bits <> prNone;
  FComPort.StopBits := Self.FConnConfig.StopBits;
  FComPort.FlowControl.FlowControl := Self.FConnConfig.FlowControl;

  FComPort.OnAfterOpen := Self.AfterOpen;
  FComPort.OnAfterClose := Self.AfterClose;
  FComPort.OnRxChar := Self.OnRxChar;

  try
    FComPort.Open;

    SendMessage(FormWeighing.Handle, WM_SET_SCALE_STATUS, WPARAM(0), LPARAM(PChar(True.ToInteger.ToString)));
  except
    SendMessage(FormWeighing.Handle, WM_SET_SCALE_STATUS, WPARAM(0), LPARAM(PChar(False.ToInteger.ToString)));
  end;
end;

procedure TScaleTranss.ConnectTcpIp;
begin
  if FDeviceClient.State = wsConnected then
    Exit;

  FDeviceClient.Proto := 'tcp';
  FDeviceClient.KeepAliveOnOff := wsKeepAliveOnCustom;
  FDeviceClient.KeepAliveInterval := 2000;
  FDeviceClient.KeepAliveTime := 5000;

  FDeviceClient.Addr := Self.FConnConfig.TcpIpAddress;
  FDeviceClient.Port := Self.FConnConfig.TcpPort.ToString;

  FDeviceClient.OnSessionConnected := AfterConnect;
  FDeviceClient.OnDataAvailable    := DataAvailable;
  FDeviceClient.OnSessionClosed    := AfterDisconnect;

  try
    FDeviceClient.Connect;
    SendMessage(FormWeighing.Handle, WM_SET_SCALE_STATUS, WPARAM(0), LPARAM(PChar(True.ToInteger.ToString)));
  except
    SendMessage(FormWeighing.Handle, WM_SET_SCALE_STATUS, WPARAM(0), LPARAM(PChar(False.ToInteger.ToString)));
  end;
end;

constructor TScaleTranss.Create(const pValue: TScaleConfig);
begin
  Self.Create();

  Self.SetConnConfig(pValue);
end;

constructor TScaleTranss.Create;
begin
  inherited Create;

  FDeviceClient := TWSocket.Create(nil);
  FComPort := TComPort.Create(nil);

  FScaleTranssProtocol := TItemTranssProtocol.Create();

  FTimerSend := TTimer.Create(nil);
  FTimerSend.Interval := SCALE_TIMER_SEND_INTERVAL;
  FTimerSend.Enabled  := False;
  FTimerSend.OnTimer  := TimerSendExecute;

  FTimerTimeOut := TTimer.Create(nil);
  FTimerTimeOut.Interval := SCALE_TIMER_TIME_OUT_INTERVAL;
  FTimerTimeOut.Enabled  := False;
  FTimerTimeOut.OnTimer  := TimerTimeOutExecute;
end;

procedure TScaleTranss.DataAvailable(Sender: TObject; Error: Word);
begin
  FTimerTimeOut.Enabled := False;

  var txt : AnsiString := FDeviceClient.ReceiveStr;
  if ReceiveData(txt) then
  begin
    FConnectedWithDevice := True;
    FTimeOutCounter := 0;

    var scaleMassMsg : String := Self.MassFromDevicePriv.ToString + SCALE_STATUS_SEPARATOR + Self.MassStable.ToInteger.ToString;
    SendMessage(FormWeighing.Handle, WM_SET_SCALE_MASS, WPARAM(0), LPARAM(PChar(scaleMassMsg)));

    FTimerSend.Enabled := True;
  end else
  begin
    FTimerTimeOut.Enabled := True;
  end;
end;

destructor TScaleTranss.Destroy;
begin
  FDeviceClient.Free;
  FTimerSend.Free;
  FTimerTimeOut.Free;
  FScaleTranssProtocol.Free;
  inherited;
end;


procedure TScaleTranss.Disconnect;
begin
  FTimerSend.Enabled := False;
  FTimerTimeOut.Enabled := False;

  case Self.FConnConfig.ConnType of
    sctSerialPort: Self.DisconnectSerial;
    sctTcpIp: Self.DisconnectTcpIp;
  end;
end;


procedure TScaleTranss.DisconnectSerial;
begin
  try
    if FComPort.Connected then begin
      FComPort.Close;
      //if Assigned(FLogInfoEvent) then
      //  FLogInfoEvent(5);
    end;
  except
    //if Assigned(FLogInfoEvent) then FLogInfoEvent(6);
  end;
end;

procedure TScaleTranss.DisconnectTcpIp;
begin
  try
    FDeviceClient.Close;
  except
    //
  end;
end;

function TScaleTranss.FormatReceivedData: Boolean;
begin
  /// w zale¿noœci od warunków sprawdzania, formatujemy odbierane dane - wyci¹gamy z nich np fragment od okreœlonego pocz¹tku do koñca ramki
  /// przygotowanie danych do próby wyci¹gniecia z nich masy
  Result := False;

  var tmpDataLength : Integer := Length(Self.FReceiveData);
  var checkBeginning : Boolean := (Self.FScaleTranssProtocol.FrameBeginning <> '');
  var checkEnding : Boolean := (Self.FScaleTranssProtocol.FrameEnding <> '');

  for var i : Integer := 1 to tmpDataLength do
  begin
    if checkBeginning and (not checkEnding) then
    begin
      if Copy(FReceiveData, i, i + Length(Self.FScaleTranssProtocol.FrameBeginning) - 1) = Self.FScaleTranssProtocol.FrameBeginning then
      begin
        if (i + Self.FScaleTranssProtocol.FrameLength - 1) <= tmpDataLength then
        begin
          FReceiveData := Copy(FReceiveData, i, Self.FScaleTranssProtocol.FrameLength);
          Exit(True);
        end;
      end;
    end else if (not checkBeginning) and checkEnding then
    begin
      if Copy(FReceiveData, i - Length(Self.FScaleTranssProtocol.FrameEnding) + 1, i) = Self.FScaleTranssProtocol.FrameEnding then
      begin
        if (i - Self.FScaleTranssProtocol.FrameLength + 1) >= 0 then
        begin
          FReceiveData := Copy(FReceiveData, i - Self.FScaleTranssProtocol.FrameLength - 1, Self.FScaleTranssProtocol.FrameLength);
          Exit(True);
        end;
      end;
    end else if checkBeginning and checkEnding then
    begin
      if (Copy(FReceiveData, i, i + Length(Self.FScaleTranssProtocol.FrameBeginning) - 1) = Self.FScaleTranssProtocol.FrameBeginning)
         and ((i + Self.FScaleTranssProtocol.FrameLength - 1) <= tmpDataLength)
         and (Copy(FReceiveData, i + Self.FScaleTranssProtocol.FrameLength - Length(Self.FScaleTranssProtocol.FrameEnding), i + Self.FScaleTranssProtocol.FrameLength - 1) = Self.FScaleTranssProtocol.FrameEnding) then
      begin
        if (i + Self.FScaleTranssProtocol.FrameLength - 1) <= tmpDataLength then
        begin
          FReceiveData := Copy(FReceiveData, i, Self.FScaleTranssProtocol.FrameLength);
          Exit(True);
        end;
      end;
    end else
    begin
      Result := True;
      Break;
    end;
  end;
end;

function TScaleTranss.GetMassFromDevice: Double;
begin
  Result := Self.FMassFromDevice;
end;

function TScaleTranss.GetScaleConnected: Boolean;
begin
  Result := False;
  case Self.FConnConfig.ConnType of
    sctSerialPort: Result := Self.FComPort.Connected;
    sctTcpIp: Result := Self.FDeviceClient.State = wsConnected;
  end;

//  if Self.FScaleTranssProtocol.StableSymbol <> '' then
//    Result := Result and Self.FMassStable;
end;

function TScaleTranss.GetScaleStable: Boolean;
begin
  Result := (SecondsBetween(Now(), Self.FNewMassDT) >= SCALE_MIN_STABLE_TIME_SEC);
  if Self.FScaleTranssProtocol.StableSymbol <> '' then
    Result := Result and Self.FMassStable;
end;

procedure TScaleTranss.OnRxChar(Sender: TObject; Count: Integer);
begin
  FTimerTimeOut.Enabled := False;
  var txt : AnsiString;
  FComPort.ReadAnsiStr(txt, Count);

  //if Assigned(FLogInfoEvent) then FLogInfoEvent(2, txt);
  if ReceiveData(txt) then
  begin
    FConnectedWithDevice := True;
    FTimeOutCounter := 0;

    var scaleMassMsg : String := Self.MassFromDevicePriv.ToString + SCALE_STATUS_SEPARATOR + Self.MassStable.ToInteger.ToString;
    SendMessage(FormWeighing.Handle, WM_SET_SCALE_MASS, WPARAM(0), LPARAM(PChar(scaleMassMsg)));

    FTimerSend.Enabled := True;
  end else
  begin
    FTimerTimeOut.Enabled := True;
  end;
end;

function TScaleTranss.ReceiveData(pTxt: AnsiString): Boolean;
begin
  Result := False;
  FReceiveData := FReceiveData + pTxt;

  var dataLenght : Integer := Length(FReceiveData);

  if (Self.FScaleTranssProtocol.FrameLength = 0)
     or ((Self.FScaleTranssProtocol.FrameLength <> 0) and (dataLenght >= Self.FScaleTranssProtocol.FrameLength)) then
  begin
    if Self.FormatReceivedData then
    begin
      var massAsString : AnsiString;
      for var I : Integer := Self.FScaleTranssProtocol.MassPosStart to Self.FScaleTranssProtocol.MassPosEnd do
        massAsString := massAsString + FReceiveData[I];

      massAsString := Trim(massAsString);
      massAsString := StringReplace(massAsString, ' ', '', [rfReplaceAll]);
      massAsString := StringReplace(massAsString, '.', FormatSettings.DecimalSeparator, [rfReplaceAll]);
      massAsString := StringReplace(massAsString, ',', FormatSettings.DecimalSeparator, [rfReplaceAll]);

      var tmpMass : Integer := StrToIntDef(massAsString, SCALE_WRONG_MASS);
      Result := tmpMass <> SCALE_WRONG_MASS;
      if Result then
        Self.MassFromDevicePriv := tmpMass
      else
        Self.MassFromDevicePriv := SCALE_WRONG_MASS;

      if Result and (Self.FScaleTranssProtocol.StableSymbol <> '') then
      begin
        var stableFlag : AnsiChar := FReceiveData[Self.FScaleTranssProtocol.StablePos];
        Self.FMassStable := stableFlag = Self.FScaleTranssProtocol.StableSymbol;
      end;
    end;

    FReceiveData := '';
  end else if ((Self.FScaleTranssProtocol.FrameLength <> 0) and (dataLenght > 2 * Self.FScaleTranssProtocol.FrameLength)) then
    FReceiveData := '';
end;

procedure TScaleTranss.SetConnConfig(const pValue: TScaleConfig);
  function TransStrToHexStr(pSource : AnsiString): AnsiString;
  begin
    var I : Integer := 1;
    var tmpString : AnsiString := '';
    var tmpInt : Integer := 0;
    Result := '';
    while I < Length(pSource) do
    begin
      tmpString := '$' + pSource[i] + pSource[i + 1];
      TryStrToInt(tmpString, tmpInt);
      Result := Result + Char(tmpInt);

      Inc(I, 2);
    end;
  end;
begin
  if not Assigned(pValue) then
    raise Exception.Create('Scale config not assigned');

  Self.FConnConfig := pValue;

  with Self.FScaleTranssProtocol do
  begin
    AssignValues(Self.FConnConfig.ScaleTranssProtocol);

    MessageToDevice := StringReplace(MessageToDevice, ' ', '', [rfReplaceAll]);
    FrameBeginning := StringReplace(FrameBeginning, ' ', '', [rfReplaceAll]);
    FrameEnding := StringReplace(FrameEnding, ' ', '', [rfReplaceAll]);
    StableSymbol := StringReplace(StableSymbol, ' ', '', [rfReplaceAll]);

    MessageToDevice := TransStrToHexStr(MessageToDevice);
    FrameBeginning := TransStrToHexStr(FrameBeginning);
    FrameEnding := TransStrToHexStr(FrameEnding);
    StableSymbol := TransStrToHexStr(StableSymbol);
  end;
end;

procedure TScaleTranss.SetMassFromDevice(const Value: Double);
begin
  if Value <> Self.FMassFromDevice then
  begin
    Self.FMassFromDevice := Value;
    Self.FNewMassDT := Now();
  end;
end;

procedure TScaleTranss.TimerSendExecute(Sender: TObject);
begin
//  32 30 30 35 30 30 32 36 3A 3B 0D 0A

  FTimerSend.Enabled := False;
  FTimerTimeOut.Enabled := False;

  if Self.FScaleTranssProtocol.MessageToDevice = '' then
    Exit;

  case Self.FConnConfig.ConnType of
    sctSerialPort: FComPort.WriteAnsiStr(Self.FScaleTranssProtocol.MessageToDevice);
    sctTcpIp: FDeviceClient.SendStr(Self.FScaleTranssProtocol.MessageToDevice);
  end;

  FTimerTimeOut.Enabled := True;
end;

procedure TScaleTranss.TimerTimeOutExecute(Sender: TObject);
begin
  FTimerTimeOut.Enabled := False;

  if not Self.ScaleConnected then
  begin
    Self.Connect;
    Exit;
  end;

  FReceiveData := '';
  if FTimeOutCounter > 2 then
  begin
    FConnectedWithDevice := False;
    Self.Disconnect;
    SendMessage(FormWeighing.Handle, WM_SET_SCALE_STATUS, WPARAM(0), LPARAM(PChar(False.ToInteger.ToString)));
  end else
  begin
    Inc(FTimeOutCounter);
    TimerSendExecute(nil);
  end;
end;

end.
