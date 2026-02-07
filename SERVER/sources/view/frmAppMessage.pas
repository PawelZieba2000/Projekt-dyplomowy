unit frmAppMessage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cTypes, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBasic, cxImage, dxGDIPlusClasses, Vcl.ExtCtrls, cxLabel, Vcl.Menus,
  Vcl.StdCtrls, cxButtons;

type
  TFormAppMessage = class(TForm)
    imgWarning: TcxImage;
    imgInfo: TcxImage;
    imgError: TcxImage;
    imgQuestion: TcxImage;
    pnlMessage: TPanel;
    lblMessage: TcxLabel;
    pnlBottom: TPanel;
    btnYes: TcxButton;
    btnNo: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNoClick(Sender: TObject);
    procedure btnYesClick(Sender: TObject);
  private
    FMsgType : TMessageType;
  public
    class function CreateAndShowModal(AOwner : TComponent; const AMessage : String; const AMsgType : TMessageType) : Integer;

    class procedure ShowInfo(const AMessage : String);
    class procedure ShowWarning(const AMessage : String);
    class procedure ShowError(const AMessage : String);
    class function ShowQusetion(const AMessage : String) : Boolean;

    constructor Create(AOwner: TComponent; const AMessage : String; const AMsgType : TMessageType); overload;
  end;

var
  FormAppMessage: TFormAppMessage;

implementation

uses
  cHelpFunctions, uConsts;

{$R *.dfm}

{ TFormAppMessage }

procedure TFormAppMessage.btnNoClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TFormAppMessage.btnYesClick(Sender: TObject);
begin
  if Self.FMsgType = mtQuestion then
    Self.ModalResult := mrYes
  else
    Self.ModalResult := mrOk;
end;

constructor TFormAppMessage.Create(AOwner: TComponent;
  const AMessage : String; const AMsgType: TMessageType);
begin
  inherited Create(AOwner);

  Self.FMsgType := AMsgType;

  var tmpCaption : String := APP_NAME + ' - ';
  case Self.FMsgType of
    mtInfo: begin
      imgInfo.Enabled := True;
      imgInfo.Visible := imgInfo.Enabled;

      tmpCaption := tmpCaption + 'info';
    end;
    mtWarning: begin
      imgWarning.Enabled := True;
      imgWarning.Visible := imgWarning.Enabled;

      tmpCaption := tmpCaption + 'ostrze¿enie';
    end;
    mtError: begin
      imgError.Enabled := True;
      imgError.Visible := imgError.Enabled;

      tmpCaption := tmpCaption + 'b³¹d';
    end;
    mtQuestion: begin
      imgQuestion.Enabled := True;
      imgQuestion.Visible := imgQuestion.Enabled;

      tmpCaption := tmpCaption + 'pytanie';

      btnNo.Enabled := True;
      btnNo.Visible := btnNo.Enabled;

      btnYes.Caption := 'Tak';
    end;
  end;

  Self.Caption := tmpCaption;
  Self.lblMessage.Caption := AMessage;
end;

class function TFormAppMessage.CreateAndShowModal(AOwner: TComponent;
  const AMessage : String; const AMsgType: TMessageType): Integer;
begin
  Result := mrNone;
  if Assigned(FormAppMessage) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormAppMessage := TFormAppMessage.Create(AOwner, AMessage, AMsgType);
  try
    Result := FormAppMessage.ShowModal;
  finally
    FreeAndNil(FormAppMessage);
  end;
end;

procedure TFormAppMessage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

class procedure TFormAppMessage.ShowError(const AMessage: String);
begin
  TFormAppMessage.CreateAndShowModal(nil, AMessage, mtError);
end;

class procedure TFormAppMessage.ShowInfo(const AMessage: String);
begin
  TFormAppMessage.CreateAndShowModal(nil, AMessage, mtInfo);
end;

class function TFormAppMessage.ShowQusetion(const AMessage: String): Boolean;
begin
  Result := TFormAppMessage.CreateAndShowModal(nil, AMessage, mtQuestion) = mrYes;
end;

class procedure TFormAppMessage.ShowWarning(const AMessage: String);
begin
  TFormAppMessage.CreateAndShowModal(nil, AMessage, mtWarning);
end;

end.
