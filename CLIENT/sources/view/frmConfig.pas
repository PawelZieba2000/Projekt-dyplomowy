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
  dxSkinBasic;

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
    procedure actOkExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure edtbtnApiLogPathPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure actApiTestExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure FillControls();
  public
    class function CreateAndShowModal(AOwner : TComponent) : Integer;
  end;

var
  FormConfig: TFormConfig;

implementation

uses
  cManagerConfig, cHelpFunctions;

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


  //assign data
  with TManagerConfig.Instance do
  begin
    ApiUrl := Trim(edtApiUrl.Text);
    ApiLogPath := Trim(edtbtnApiLogPath.Text);
    ScaleIP := Trim(edtScaleIp.Text);
    ScalePort := seScalePort.Value;
    SaveConfig;
  end;

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
  with TManagerConfig.Instance do
  begin
    edtApiUrl.Text := ApiUrl;
    edtbtnApiLogPath.Text := ApiLogPath;
    edtScaleIp.Text := ScaleIP;
    seScalePort.Value := ScalePort;
  end;
end;

procedure TFormConfig.FormCreate(Sender: TObject);
begin
  Self.FillControls;
end;

end.
