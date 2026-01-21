unit frmWeighingList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmBaseList, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, Vcl.Menus,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData,
  dxLayoutControlAdapters, dxLayoutContainer, cxTextEdit, System.Actions,
  Vcl.ActnList, dxBar, cxBarEditItem, cxClasses, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.StdCtrls, cxButtons, dxLayoutControl;

type
  TFormWeighingList = class(TFormBaseList)
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    class function CreateAndShowModal(AOwner : TComponent) : Integer;
  end;

var
  FormWeighingList: TFormWeighingList;

implementation

uses
  cHelpFunctions;

{$R *.dfm}

class function TFormWeighingList.CreateAndShowModal(
  AOwner: TComponent): Integer;
begin
  Result := mrNone;

  if Assigned(FormWeighingList) then
    Exit;

  if not Assigned(AOwner) then
    AOwner := THelpFunctions.GetActiveWindow;

  FormWeighingList := TFormWeighingList.Create(AOwner);
  try
    Result := FormWeighingList.ShowModal;
  finally
    FreeAndNil(FormWeighingList);
  end;
end;

procedure TFormWeighingList.FormDestroy(Sender: TObject);
begin
  FormWeighingList := nil;
end;

end.
