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
    edtApiUrl: TcxTextEdit;
    liApiLogPath: TdxLayoutItem;
    edtbtnApiLogPath: TcxButtonEdit;
    liApiTest: TdxLayoutItem;
    btnApiTest: TcxButton;
    actApiTest: TAction;
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure edtbtnApiLogPathPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure actApiTestExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  cManagerConfig, cHelpFunctions, cTypes, CPort, frmAppMessage;

{$R *.dfm}

{ TFormConfig }

procedure TFormConfig.actApiTestExecute(Sender: TObject);
begin
//
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

  with TManagerConfig.Instance.DatabaseConfig do
  begin
//    IsActive := liChbScaleActive.Checked;
//
//    ScaleProtocolType := TScaleProtocolType.FromInteger(cmbScaleProtocols.ItemIndex);
//    ConnType := TScaleConnType.FromInteger(cmbScaleConnType.ItemIndex);
//
//    TcpIpAddress := Trim(edtScaleIp.Text);
//    TcpPort := seScalePort.Value;
//
//    ComPort := THelpFunctions.GetStringFromComCombo(cmbScaleComPorts);
//    BaudRate := StrToBaudRate(THelpFunctions.GetStringFromComCombo(cmbScaleBaudrate));
//    DataBits := StrToDataBits(THelpFunctions.GetStringFromComCombo(cmbScaleDataBits));
//    ParityBits := StrToParity(THelpFunctions.GetStringFromComCombo(cmbScaleParity));
//    StopBits := StrToStopBits(THelpFunctions.GetStringFromComCombo(cmbScaleStopBits));
//    FlowControl := StrToFlowControl(THelpFunctions.GetStringFromComCombo(cmbScaleFlowControl));
  end;

  TManagerConfig.Instance.SaveConfig;

  Self.ModalResult := mrOk;
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

//  with TManagerConfig.Instance.ScaleConfig do
//  begin
//    liChbScaleActive.Checked := IsActive;
//    liChbScaleActiveClick(nil);
//
//    cmbScaleProtocols.ItemIndex := ScaleProtocolType.ToInteger;
//    cmbScaleConnType.ItemIndex := ConnType.ToInteger;
//
//    edtScaleIp.Text := TcpIpAddress;
//    seScalePort.Value := TcpPort;
//
//    THelpFunctions.SetComboItemIndex(cmbScaleComPorts, ComPort);
//
//    var tmpStr : String := BaudRateToStr(BaudRate);
//    THelpFunctions.SetComboItemIndex(cmbScaleBaudrate, tmpStr);
//
//    tmpStr := ParityToStr(ParityBits);
//    THelpFunctions.SetComboItemIndex(cmbScaleParity, tmpStr);
//
//    tmpStr := FlowControlToStr(FlowControl);
//    THelpFunctions.SetComboItemIndex(cmbScaleFlowControl, tmpStr);
//
//    tmpStr := DataBitsToStr(DataBits);
//    THelpFunctions.SetComboItemIndex(cmbScaleDataBits, tmpStr);
//
//    tmpStr := StopBitsToStr(StopBits);
//    THelpFunctions.SetComboItemIndex(cmbScaleStopBits, tmpStr);
//  end;
end;

procedure TFormConfig.FormCreate(Sender: TObject);
begin

  Self.FillControls;
end;

function TFormConfig.ValidateData: Boolean;
begin
  Result := False;

//  if liChbScaleActive.Checked then
//  begin
//    if (Self.cmbScaleProtocols.ItemIndex = -1) or (Self.cmbScaleProtocols.ItemIndex = sptNone.ToInteger) then
//    begin
//      TFormAppMessage.ShowWarning('Protokó³ komunikacyjny nie zosta³ wybrany!');
//      Exit;
//    end;
//  end;

  Result := True;
end;

end.
