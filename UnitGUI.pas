unit UnitGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB
  , ICDsearcher
  , ICDtranslator, Grids
  ;

type
  TApplicationGUIForm = class(TForm)
    lbCriteria: TLabel;
    edCriteria: TEdit;
    btSearch: TButton;
    cbLng: TComboBox;
    lbResults: TLabel;
    lbNResults: TLabel;
    edNResults: TEdit;
    sgResults: TStringGrid;
    procedure btSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sgResultsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Déclarations privées }
    FSearcher: TICDSearcher;
    function getLngChoosen: TICDlng;
    procedure fillComboLng;
    procedure clearGrid;
    procedure fillGrid;
    procedure clearAndFillGrid;
  public
    { Déclarations publiques }
  end;

var
  ApplicationGUIForm: TApplicationGUIForm;

implementation

uses
  ICDrecord,
  ICDconst,
  TypInfo;

{$R *.dfm}

procedure TApplicationGUIForm.clearGrid;
begin
  sgResults.RowCount := 1;
  sgResults.Cells[0,0] := '';
  sgResults.Cells[1,0] := '';
end;

procedure TApplicationGUIForm.fillGrid;
var
  vLng: TICDlng;
  vRec: TICDRecord;
  i: integer;
begin
  sgResults.ColWidths[0] := 50;
  sgResults.ColWidths[1] := 500;
  i := -1;
  for vRec in FSearcher.results do
  begin
    inc(i);
    if i>0 then
      sgResults.RowCount := sgResults.RowCount + 1;
    sgResults.Cells[0,i] := vRec.codeICD10;
    vLng := getLngChoosen;
    if vLng = lng_fr then
      sgResults.Cells[1,i] := vRec.frDescription
    else
      sgResults.Cells[1,i] := vRec.nlDescription;
  end;
end;

procedure TApplicationGUIForm.clearAndFillGrid;
begin
  clearGrid;
  fillGrid;
end;

procedure TApplicationGUIForm.btSearchClick(Sender: TObject);
var
  vnRecords: integer;
  vCriteria: string;
  vCode: string;
  vLng: TICDlng;
  vRec: TICDRecord;
begin
  vLng := getLngChoosen;
  vnRecords := strtoint(edNResults.Text);
  vCriteria := edCriteria.Text;

  FSearcher.criteria := vCriteria;
  FSearcher.lng := vLng;
  FSearcher.top := vnRecords;

  FSearcher.ComputeResult;

  clearAndFillGrid;
end;

procedure TApplicationGUIForm.fillComboLng;
var
  iLng: integer;
begin
  cbLng.Items.Clear;
  for iLng := ord(Low(TICDlng)) to ord(high(TICDlng)) do
    cbLng.items.Add(TICDtranslator.GUItranslate(TICDlng(iLng)));
  cbLng.ItemIndex := 0;
end;

procedure TApplicationGUIForm.FormCreate(Sender: TObject);
begin
  edCriteria.Text := CST_INI_CRITERIA; // initialize to test
  fillComboLng;
  FSearcher := TICDSearcher.Create('', lng_fr, CST_INI_SEARCH_NUMBER);
end;

procedure TApplicationGUIForm.FormDestroy(Sender: TObject);
begin
  FSearcher.Free;
end;

function TApplicationGUIForm.getLngChoosen: TICDlng;
begin
  result := TICDlng(cbLng.ItemIndex);
end;

procedure TApplicationGUIForm.sgResultsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  //
end;

end.
