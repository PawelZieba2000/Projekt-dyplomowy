unit frmTranssProtocolAddEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBaseAddEdit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, Vcl.Menus,
  dxLayoutControlAdapters, System.Actions, Vcl.ActnList, cxClasses, dxBar,
  dxLayoutContainer, Vcl.StdCtrls, cxButtons, dxLayoutControl,
  cItemTranssProtocol, cTypes, cxContainer, cxEdit, cxMaskEdit, cxSpinEdit,
  cxTextEdit, dxLayoutcxEditAdapters;

type
  TFormTranssProtocolAddEdit = class(TFormBaseAddEdit)
    lgTop: TdxLayoutGroup;
    liLblTitle: TdxLayoutLabeledItem;
    imgTitle: TdxLayoutImageItem;
    sprtr1: TdxLayoutSeparatorItem;
    lgCenter: TdxLayoutGroup;
    liName: TdxLayoutItem;
    liMsgToDevice: TdxLayoutItem;
    liFrameBeginning: TdxLayoutItem;
    liFrameEnding: TdxLayoutItem;
    liFrameLength: TdxLayoutItem;
    liMassPosStart: TdxLayoutItem;
    liMassPosEnd: TdxLayoutItem;
    liStablePos: TdxLayoutItem;
    liStableSymbol: TdxLayoutItem;
    edtName: TcxTextEdit;
    edtMsgToDevice: TcxTextEdit;
    edtFrameBeginning: TcxTextEdit;
    edtFrameEnd: TcxTextEdit;
    seFrameLength: TcxSpinEdit;
    seMassPosStart: TcxSpinEdit;
    seMassPosEnd: TcxSpinEdit;
    seStablePos: TcxSpinEdit;
    edtStableSymbol: TcxTextEdit;
    lgMass: TdxLayoutGroup;
    lgStable: TdxLayoutGroup;
    procedure actOkExecute(Sender: TObject);
    procedure seSpinEditExit(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
  private
    FEditMode : TFormEditType;
    FTranssProtocol : TItemTranssProtocol;
    FIsInEdit : Boolean;

    procedure FillComponents();
    procedure FillProtocolValues();
    function ValidateValues() : Boolean;

    procedure SetControlsReadOnly(pIsReadOnly: Boolean);
  public
    class function CreateAndShowModal(AOwner : TComponent;  AProtocol: TItemTranssProtocol; AEditMode: TFormEditType) : Integer;

    constructor Create(AOwner: TComponent; AProtocol: TItemTranssProtocol; AEditMode: TFormEditType); overload;
  end;

var
  FormTranssProtocolAddEdit: TFormTranssProtocolAddEdit;

implementation

uses
  uConsts, frmAppMessage, cHelpFunctions;

{$R *.dfm}

{ TFormTranssProtocolAddEdit }

procedure TFormTranssProtocolAddEdit.actCancelExecute(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TFormTranssProtocolAddEdit.actOkExecute(Sender: TObject);
begin
  if (Self.FEditMode = fetEdit) and (not Self.FISInEdit) then
  begin
    Self.FIsInEdit := True;
    Self.SetControlsReadOnly(not Self.FIsInEdit);

    Self.actOk.Caption := 'OK';
    Exit;
  end;

  if (Self.FISInEdit) then
  begin
    if not Self.ValidateValues then
      Exit;

    Self.FillProtocolValues();
    Self.ModalResult := mrOk;
  end;
end;

constructor TFormTranssProtocolAddEdit.Create(AOwner: TComponent;
  AProtocol: TItemTranssProtocol; AEditMode: TFormEditType);
begin
  inherited Create(AOwner);

  Self.FEditMode := AEditMode;
  Self.FTranssProtocol := AProtocol;

  case Self.FEditMode of
    fetAddNew: begin
      Self.Caption := 'Dodawanie nowego protoko³u komunikacyjnego';
      Self.actOk.Caption := 'Dodaj';
    end;

    fetEdit: begin
      Self.Caption := 'Edycja protoko³u: ' + Self.FTranssProtocol.Name;
      Self.actOk.Caption := 'Edytuj';
    end;
  end;

  liLblTitle.CaptionOptions.Text := Self.Caption;
  FIsInEdit := Self.FEditMode = fetAddNew;
  Self.FillComponents;
  Self.SetControlsReadOnly(not FIsInEdit);
end;

class function TFormTranssProtocolAddEdit.CreateAndShowModal(AOwner: TComponent;
  AProtocol: TItemTranssProtocol; AEditMode: TFormEditType): Integer;
begin
  Result := mrNone;
  if Assigned(FormTranssProtocolAddEdit) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormTranssProtocolAddEdit := TFormTranssProtocolAddEdit.Create(AOwner, AProtocol, AEditMode);
  try
    Result := FormTranssProtocolAddEdit.ShowModal;
  finally
    FreeAndNil(FormTranssProtocolAddEdit);
  end;
end;

procedure TFormTranssProtocolAddEdit.FillComponents;
begin
  Self.edtName.Text := Self.FTranssProtocol.Name;
  Self.edtMsgToDevice.Text := Self.FTranssProtocol.MessageToDevice;
  Self.edtFrameBeginning.Text := Self.FTranssProtocol.FrameBeginning;
  Self.edtFrameEnd.Text := Self.FTranssProtocol.FrameEnding;
  Self.seFrameLength.Value := Self.FTranssProtocol.FrameLength;
  Self.seMassPosStart.Value := Self.FTranssProtocol.MassPosStart;
  Self.seMassPosEnd.Value := Self.FTranssProtocol.MassPosEnd;
  Self.seStablePos.Value := Self.FTranssProtocol.StablePos;
  Self.edtStableSymbol.Text := Self.FTranssProtocol.StableSymbol;
end;

procedure TFormTranssProtocolAddEdit.FillProtocolValues;
begin
  Self.FTranssProtocol.Name := Self.edtName.Text;
  Self.FTranssProtocol.MessageToDevice := Self.edtMsgToDevice.Text;
  Self.FTranssProtocol.FrameBeginning := Self.edtFrameBeginning.Text;
  Self.FTranssProtocol.FrameEnding := Self.edtFrameEnd.Text;
  Self.FTranssProtocol.FrameLength := Self.seFrameLength.Value;
  Self.FTranssProtocol.MassPosStart := Self.seMassPosStart.Value;
  Self.FTranssProtocol.MassPosEnd := Self.seMassPosEnd.Value;
  Self.FTranssProtocol.StablePos := Self.seStablePos.Value;
  Self.FTranssProtocol.StableSymbol := Self.edtStableSymbol.Text;
end;

procedure TFormTranssProtocolAddEdit.seSpinEditExit(Sender: TObject);
begin
  if not (Sender is TcxSpinEdit) then
    Exit;

  if TcxSpinEdit(Sender).Value >= 0 then
    Exit;

  TFormAppMessage.ShowWarning('Wartoœæ pola nie mo¿e byæ ujemna');
  TcxSpinEdit(Sender).Value := 0;
end;

procedure TFormTranssProtocolAddEdit.SetControlsReadOnly(pIsReadOnly: Boolean);
begin
  Self.edtName.Properties.ReadOnly := pIsReadOnly;
  Self.edtMsgToDevice.Properties.ReadOnly := pIsReadOnly;
  Self.edtFrameBeginning.Properties.ReadOnly := pIsReadOnly;
  Self.edtFrameEnd.Properties.ReadOnly := pIsReadOnly;
  Self.seFrameLength.Properties.ReadOnly := pIsReadOnly;
  Self.seMassPosStart.Properties.ReadOnly := pIsReadOnly;
  Self.seMassPosEnd.Properties.ReadOnly := pIsReadOnly;
  Self.seStablePos.Properties.ReadOnly := pIsReadOnly;
  Self.edtStableSymbol.Properties.ReadOnly := pIsReadOnly;
end;

function TFormTranssProtocolAddEdit.ValidateValues : Boolean;
begin
  Result := False;
  try
    if Self.edtName.Text = EMPTY_STR then
      raise Exception.Create('Nazwa protoko³u nie mo¿e byæ pusta');

    if Self.seMassPosStart.Value > Self.seMassPosEnd.Value then
      raise Exception.Create('Pozycja pocz¹tku masy nie mo¿e byæ wiêksza od koñca');

    Result := True;
  except
    on E: Exception do
    begin
      TFormAppMessage.ShowWarning(E.Message);
    end;
  end;
end;

end.
