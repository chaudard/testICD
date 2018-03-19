unit ICDsearcher;

interface

uses
  ADODB,
  generics.collections,
  ICDrecord,
  ICDtranslator;

type TICDSearcher = class
  private
    FCriteria: string;
    FLng: TICDlng;
    FTop: integer;
    FResults: TList<TICDRecord>;
    FErrorMessage: string;
    function getADOquery: TADOquery;
  published
    property criteria: string read FCriteria write FCriteria;
    property lng: TICDlng read FLng write FLng;
    property top: integer read FTop write FTop;
    property results: TList<TICDRecord> read FResults write FResults;
    property errorMessage: string read FErrorMessage write FErrorMessage;
  public
    constructor Create; overload;
    constructor Create(const aCriteria: string;
                       const aLng: TICDlng;
                       const aTop: integer); overload;
    destructor  Destroy; override;
    procedure   ClearResults;
    procedure   ComputeResult;
  public
end;

implementation

uses
  sysUtils,
  ICDconst;

{ TICDSearcher }

constructor TICDSearcher.Create;
begin
  criteria := '';
  lng := lng_fr;
  top := 1;
  results := TList<TICDRecord>.Create;
  errorMessage := '';
end;

function TICDSearcher.getADOquery: TADOquery;
begin
  result := TADOQuery.Create(nil);
  result.ConnectionString := CST_CONNEXION_STRING;
end;

constructor TICDSearcher.Create(
  const aCriteria: string;
  const aLng: TICDlng;
  const aTop: integer);
begin
  criteria := aCriteria;
  lng := aLng;
  top := aTop;
  results := TList<TICDRecord>.Create;
  errorMessage := '';
end;

destructor TICDSearcher.Destroy;
begin
  ClearResults;
  FResults.Free;
  inherited;
end;

procedure TICDSearcher.ClearResults;
var
  i: Integer;
begin
  for i := 0 to FResults.count - 1 do
    FResults.Items[i].Free;
  FResults.Clear;
end;

procedure TICDSearcher.ComputeResult;
var
  vCode: string;
  vFrDes: string;
  vNlDes: string;
  vICDRecord: TICDRecord;
  vADOQuery: TADOQuery;
  vFrDescriptionField: string;
  vNlDescriptionField: string;
  vlng: string;
begin
  vFrDescriptionField := TICDtranslator.ADOtranslate(lng_fr);
  vNlDescriptionField := TICDtranslator.ADOtranslate(lng_nl);
  vlng := TICDtranslator.ADOtranslate(lng);
  ClearResults;
  errorMessage := '';
  vADOQuery := getADOquery;
  try
    try
      vADOQuery.SQL.Text := format(CST_QUERY, [top, vlng, QuotedStr('%'+criteria+'%')]);
      vADOQuery.Open;
      vADOQuery.First;
      while not vADOQuery.Eof do
      begin
        vCode := vADOQuery.FieldByName(CST_CODE_FIELD).AsString;
        vFrDes := vADOQuery.FieldByName(vFrDescriptionField).AsString;
        vnLDes := vADOQuery.FieldByName(vNlDescriptionField).AsString;
        vICDRecord := TICDRecord.Create(vCode, vFrDes, vNlDes);
        results.Add(vICDRecord);
        vADOQuery.Next;
      end;
    except on E: Exception do
      errorMessage := 'db connexion : a problem has occured.'; //e.Message;
    end;
  finally
  vADOQuery.Close;
  vADOQuery.Free;
  end;
end;


end.
