codeunit 50136 "Jurnal Errors Sriq "
{
    procedure GetErrorMessages(var NewTempErrorMessage: Record "Error Message" temporary)
    begin
        NewTempErrorMessage.Copy(TempErrorMessage, true);
    end;
     procedure SetFullBatchCheck(NewFullBatchCheck: Boolean)
    begin
        FullBatchCheck := NewFullBatchCheck;
    end;
    var
    TempErrorMessage: Record "Error Message" temporary;
    FullBatchCheck: Boolean;
}
