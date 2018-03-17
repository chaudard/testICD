unit ICDconst;

interface

const
  CST_INI_CRITERIA: string = 'choléra';
  CST_INI_SEARCH_NUMBER: integer = 10;
  CST_CONNEXION_STRING: string =
   'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=testICD;Data Source=DEV-DANY';
  CST_QUERY: string = 'SELECT TOP %d * FROM ICD_10 WHERE %s LIKE %s';
  CST_CODE_FIELD: string = 'ICD_10_CODE';
  CST_FR_DESC_FIELD: string = 'FR_DESCRIPTION';
  CST_NL_DESC_FIELD: string = 'NL_DESCRIPTION';
implementation

end.
