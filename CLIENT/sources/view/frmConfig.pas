unit frmConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxLayoutControlAdapters,
  System.Actions, Vcl.ActnList, cxClasses, dxBar, System.ImageList, Vcl.ImgList,
  cxImageList, dxLayoutContainer, Vcl.StdCtrls, cxButtons, dxLayoutControl,
  dxLayoutcxEditAdapters, cxContainer, cxEdit, cxLabel, uModDispatcher,
  dxCoreGraphics, cxButtonEdit, cxMaskEdit, cxSpinEdit, cxTextEdit, dxSkinsCore,
  dxSkinBasic, cxDropDownEdit, CPortCtl;

type
  TFormConfig = class(TFormBase)
    lgTop: TdxLayoutGroup;
    lgCenter: TdxLayoutGroup;
    imgTittle: TdxLayoutImageItem;
    liLblTitle: TdxLayoutLabeledItem;
    sprtrTop: TdxLayoutSeparatorItem;
    liApiUrl: TdxLayoutItem;
    lgApiConfig: TdxLayoutGroup;
    lgScaleConfig: TdxLayoutGroup;
    liScaleIp: TdxLayoutItem;
    liScalePort: TdxLayoutItem;
    edtApiUrl: TcxTextEdit;
    edtScaleIp: TcxTextEdit;
    seScalePort: TcxSpinEdit;
    liApiLogPath: TdxLayoutItem;
    edtbtnApiLogPath: TcxButtonEdit;
    liApiTest: TdxLayoutItem;
    btnApiTest: TcxButton;
    actApiTest: TAction;
    lgScaleConnection: TdxLayoutGroup;
    lgScaleConnIp: TdxLayoutGroup;
    lgScaleConnSerial: TdxLayoutGroup;
    liScaleSerialPort: TdxLayoutItem;
    liScaleSerialBaudrate: TdxLayoutItem;
    liScaleSerialParity: TdxLayoutItem;
    liScaleSerialData: TdxLayoutItem;
    liScaleSerialStopBits: TdxLayoutItem;
    liScaleSerialFlowControl: TdxLayoutItem;
    liChbScaleActive: TdxLayoutCheckBoxItem;
    liScaleProtocol: TdxLayoutItem;
    liScaleConnType: TdxLayoutItem;
    cmbScaleProtocols: TcxComboBox;
    cmbScaleConnType: TcxComboBox;
    cmbScaleComPorts: TComComboBox;
    cmbScaleBaudrate: TComComboBox;
    cmbScaleParity: TComComboBox;
    cmbScaleFlowControl: TComComboBox;
    cmbScaleDataBits: TComComboBox;
    cmbScaleStopBits: TComComboBox;
    lgsTranssprotocols: TdxLayoutGroup;
    liOpenProtoList: TdxLayoutItem;
    actOpenProtoList: TAction;
    btnOpenProtoList: TcxButton;
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure edtbtnApiLogPathPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure actApiTestExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbScaleConnTypePropertiesChange(Sender: TObject);
    procedure liChbScaleActiveClick(Sender: TObject);
    procedure actOpenProtoListExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure FillControls();
    function ValidateData() : Boolean;
  public
    class function CreateAndShowModal(AOwner : TComponent) : Integer;
  end;

var
  FormConfig: TFormConfig;

implementation

uses
  cManagerConfig, cHelpFunctions, cTypes, CPort, frmAppMessage,
  cItemTranssProtocol, frmProtocolsList, cManagerApiService, cConfig;

{$R *.dfm}

{ TFormConfig }

procedure TFormConfig.actApiTestExecute(Sender: TObject);
begin
  var restConfig : TRestClientConfig := TRestClientConfig.Create();
  restConfig.ApiUrl := Trim(edtApiUrl.Text);
  try
    if TManagerApiService.Instance.CheckApi(restConfig) then
      TFormAppMessage.ShowInfo('Nawi¹zano po³¹czenie')
    else
      TFormAppMessage.ShowWarning('B³êdne dane po³¹czenia');
  finally
    restConfig.Free;
  end;
end;

procedure TFormConfig.actCancelExecute(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TFormConfig.actOkExecute(Sender: TObject);
begin
  if MessageDlg('Czy na pewno chcesz zapisaæ ustawienia?', mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) <> mrYes then
    Exit;

  //valdiate data
  if not ValidateData() then
    Exit;

  //assign data
  with TManagerConfig.Instance.RestClientConfig do
  begin
    ApiUrl := Trim(edtApiUrl.Text);
    ApiLogPath := Trim(edtbtnApiLogPath.Text);
  end;

  with TManagerConfig.Instance.ScaleConfig do
  begin
    IsActive := liChbScaleActive.Checked;

    if cmbScaleProtocols.ItemIndex > -1 then
      ScaleTranssProtocol.AssignValues(TItemTranssProtocol(cmbScaleProtocols.ItemObject));

    ConnType := TScaleConnType.FromInteger(cmbScaleConnType.ItemIndex);

    TcpIpAddress := Trim(edtScaleIp.Text);
    TcpPort := seScalePort.Value;

    ComPort := THelpFunctions.GetStringFromComCombo(cmbScaleComPorts);
    BaudRate := StrToBaudRate(THelpFunctions.GetStringFromComCombo(cmbScaleBaudrate));
    DataBits := StrToDataBits(THelpFunctions.GetStringFromComCombo(cmbScaleDataBits));
    ParityBits := StrToParity(THelpFunctions.GetStringFromComCombo(cmbScaleParity));
    StopBits := StrToStopBits(THelpFunctions.GetStringFromComCombo(cmbScaleStopBits));
    FlowControl := StrToFlowControl(THelpFunctions.GetStringFromComCombo(cmbScaleFlowControl));
  end;

  TManagerConfig.Instance.SaveConfig;

  Self.ModalResult := mrOk;
end;

procedure TFormConfig.actOpenProtoListExecute(Sender: TObject);
begin
  var tmpProtocol : TItemTranssProtocol := TFormProtocolsList.CreateAndSelectOne(nil);

  if not Assigned(tmpProtocol) then
    Exit;

  try
    for var I : Integer := 0 to cmbScaleProtocols.Properties.Items.Count - 1 do
    begin
      if TItemTranssProtocol(cmbScaleProtocols.Properties.Items.Objects[I]).Id <> tmpProtocol.Id then
        Continue;

      cmbScaleProtocols.ItemIndex := I;
      Break;
    end;
  finally
    tmpProtocol.Free;
  end;

  THelpFunctions.FillScaleProtocolsCombo(Self.cmbScaleProtocols);
end;

procedure TFormConfig.cmbScaleConnTypePropertiesChange(Sender: TObject);
begin
  var tmpConnType : TScaleConnType := TScaleConnType.FromInteger(Self.cmbScaleConnType.ItemIndex);

  lgScaleConnIp.Visible := tmpConnType in [sctTcpIp];
  lgScaleConnSerial.Visible := not lgScaleConnIp.Visible;
end;

class function TFormConfig.CreateAndShowModal(AOwner: TComponent): Integer;
begin
  Result := mrNone;

  if Assigned(FormConfig) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormConfig := TFormConfig.Create(AOwner);
  try
    Result := FormConfig.ShowModal;
  finally
    FormConfig.Free;
  end;
end;

procedure TFormConfig.edtbtnApiLogPathPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  var fod : TFileOpenDialog := TFileOpenDialog.Create(nil);
  fod.Options := fod.Options + [fdoPickFolders];
  fod.DefaultFolder := THelpFunctions.GetCurrentDirectory;
  var tmpPath : String := Trim(Self.edtbtnApiLogPath.Text);
  if DirectoryExists(tmpPath) then
    fod.DefaultFolder := tmpPath;

  try
    if fod.Execute then
      Self.edtbtnApiLogPath.Text := fod.FileName;
  finally
    fod.Free;
  end;
end;

procedure TFormConfig.FillControls;
begin
  with TManagerConfig.Instance.RestClientConfig do
  begin
    edtApiUrl.Text := ApiUrl;
    edtbtnApiLogPath.Text := ApiLogPath;
  end;

  with TManagerConfig.Instance.ScaleConfig do
  begin
    liChbScaleActive.Checked := IsActive;
    liChbScaleActiveClick(nil);

    for var I : Integer := 0 to cmbScaleProtocols.Properties.Items.Count - 1 do
    begin
      if TItemTranssProtocol(cmbScaleProtocols.Properties.Items.Objects[I]).Id <> ScaleTranssProtocol.Id then
        Continue;

      cmbScaleProtocols.ItemIndex := I;
      Break;
    end;

    cmbScaleConnType.ItemIndex := ConnType.ToInteger;

    edtScaleIp.Text := TcpIpAddress;
    seScalePort.Value := TcpPort;

    THelpFunctions.SetComboItemIndex(cmbScaleComPorts, ComPort);

    var tmpStr : String := BaudRateToStr(BaudRate);
    THelpFunctions.SetComboItemIndex(cmbScaleBaudrate, tmpStr);

    tmpStr := ParityToStr(ParityBits);
    THelpFunctions.SetComboItemIndex(cmbScaleParity, tmpStr);

    tmpStr := FlowControlToStr(FlowControl);
    THelpFunctions.SetComboItemIndex(cmbScaleFlowControl, tmpStr);

    tmpStr := DataBitsToStr(DataBits);
    THelpFunctions.SetComboItemIndex(cmbScaleDataBits, tmpStr);

    tmpStr := StopBitsToStr(StopBits);
    THelpFunctions.SetComboItemIndex(cmbScaleStopBits, tmpStr);
  end;
end;

procedure TFormConfig.FormCreate(Sender: TObject);
begin
  THelpFunctions.FillScaleProtocolsCombo(Self.cmbScaleProtocols);
  THelpFunctions.FillScaleConnCombo(Self.cmbScaleConnType);

  Self.FillControls;
end;

procedure TFormConfig.FormDestroy(Sender: TObject);
begin
  FormConfig := nil;
end;

procedure TFormConfig.liChbScaleActiveClick(Sender: TObject);
begin
  self.cmbScaleProtocols.Enabled := liChbScaleActive.Checked;
  self.cmbScaleConnType.Enabled := self.cmbScaleProtocols.Enabled;
  self.edtScaleIp.Enabled := self.cmbScaleProtocols.Enabled;
  self.seScalePort.Enabled := self.cmbScaleProtocols.Enabled;
  self.cmbScaleComPorts.Enabled := self.cmbScaleProtocols.Enabled;
  self.cmbScaleBaudrate.Enabled := self.cmbScaleProtocols.Enabled;
  self.cmbScaleParity.Enabled := self.cmbScaleProtocols.Enabled;
  self.cmbScaleFlowControl.Enabled := self.cmbScaleProtocols.Enabled;
  self.cmbScaleDataBits.Enabled := self.cmbScaleProtocols.Enabled;
  self.cmbScaleStopBits.Enabled := self.cmbScaleProtocols.Enabled;
end;

function TFormConfig.ValidateData: Boolean;
begin
  Result := False;

  if liChbScaleActive.Checked then
  begin
    if (Self.cmbScaleProtocols.ItemIndex = -1) or (not assigned(Self.cmbScaleProtocols.ItemObject)) then
    begin
      TFormAppMessage.ShowWarning('Protokó³ komunikacyjny nie zosta³ wybrany!');
      Exit;
    end;
  end;

  Result := True;
end;

end.
