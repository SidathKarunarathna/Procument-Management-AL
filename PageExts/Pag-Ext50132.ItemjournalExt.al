pageextension 50132 "Item journal Ext" extends "Item Journal"
{
    layout
    {
        addafter(Control1903326807)
        {

            part(WorkflowStatusBatch; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Caption = 'Batch Workflows';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatusOnBatch;
            }

        }
    }
    actions
    {
        addafter("P&osting")
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                group(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    action(SendApprovalRequestJournalLine)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Selected Journal Lines';
                        Enabled = NOT OpenApprovalEntriesOnBatchOrCurrJnlLineExist AND CanRequestFlowApprovalForBatchAndCurrentLine;
                        Image = SendApprovalRequest;
                        ToolTip = 'Send selected journal lines for approval.';

                        trigger OnAction()
                        var
                            [SecurityFiltering(SecurityFilter::Filtered)]
                            ItemJournalLine: Record "Item Journal Line";
                            ApprovalsMgmt: Codeunit "Approvals Sriq";
                        begin
                            GetCurrentlySelectedLines(ItemJournalLine);
                            ApprovalsMgmt.TrySendJournalLineApprovalRequests(ItemJournalLine);
                            SetControlAppearanceFromBatch;
                        end;
                    }

                }
                group(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    action(CancelApprovalRequestJournalLine)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Selected Journal Lines';
                        Enabled = CanCancelApprovalForJnlLine OR CanCancelFlowApprovalForLine;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Cancel sending selected journal lines for approval.';

                        trigger OnAction()
                        var
                            [SecurityFiltering(SecurityFilter::Filtered)]
                            ItemJournalLine: Record "Item Journal Line";
                            ApprovalsMgmt: Codeunit "Approvals Sriq";
                        begin
                            GetCurrentlySelectedLines(ItemJournalLine);
                            ApprovalsMgmt.TryCancelJournalLineApprovalRequests(ItemJournalLine);
                        end;
                    }
                }
            }



        }
    }
    local procedure GetCurrentlySelectedLines(var ItemJournalLine: Record "Item Journal Line"): Boolean
    begin
        CurrPage.SetSelectionFilter(ItemJournalLine);
        exit(ItemJournalLine.FindSet());
    end;

    local procedure GetPostingDate(): Date
    begin
        if IsSimplePage then
            exit(CurrentPostingDate);
        exit(Workdate());
    end;

    local procedure SetControlAppearanceFromBatch()
    var
        ItemJournalBatch: Record "Item Journal Batch";
        ApprovalsMgmt: Codeunit "Approvals Sriq";
        WorkflowWebhookManagement: Codeunit "Workflow Management Sriq";
        CanRequestFlowApprovalForAllLines: Boolean;
    begin

        if not ItemJournalBatch.Get(Rec.GetRangeMax("Journal Template Name"), CurrentJnlBatchName) then
            exit;

        ShowWorkflowStatusOnBatch := CurrPage.WorkflowStatusBatch.PAGE.SetFilterOnWorkflowRecord(ItemJournalBatch.RecordId);
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(ItemJournalBatch.RecordId);
        OpenApprovalEntriesOnJnlBatchExist := ApprovalsMgmt.HasOpenApprovalEntries(ItemJournalBatch.RecordId);

        OpenApprovalEntriesOnBatchOrAnyJnlLineExist :=
          OpenApprovalEntriesOnJnlBatchExist or
          ApprovalsMgmt.HasAnyOpenJournalLineApprovalEntries(Rec."Journal Template Name", Rec."Journal Batch Name");

        CanCancelApprovalForJnlBatch := ApprovalsMgmt.CanCancelApprovalForRecord(ItemJournalBatch.RecordId);

        WorkflowWebhookManagement.GetCanRequestAndCanCancelJournalBatch(
          ItemJournalBatch, CanRequestFlowApprovalForBatch, CanCancelFlowApprovalForBatch, CanRequestFlowApprovalForAllLines);
        CanRequestFlowApprovalForBatchAndAllLines := CanRequestFlowApprovalForBatch and CanRequestFlowApprovalForAllLines;

        BackgroundErrorCheck := ItemJournalBatch."Background Error Check";
        ShowAllLinesEnabled := true;
        Rec.SwitchLinesWithErrorsFilter(ShowAllLinesEnabled);
        JournalErrorsMgt.SetFullBatchCheck(true);
    end;




    var
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;
        CanRequestFlowApprovalForBatchAndCurrentLine: Boolean;
        CurrentPostingDate: Date;
        CurrentJnlBatchName: Code[10];
        ShowWorkflowStatusOnBatch: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist: Boolean;
        CanCancelApprovalForJnlBatch: Boolean;
        CanRequestFlowApprovalForBatch: Boolean;
        CanCancelFlowApprovalForBatch: Boolean;
        CanRequestFlowApprovalForBatchAndAllLines: Boolean;
        BackgroundErrorCheck: Boolean;
        ShowAllLinesEnabled: Boolean;
        JournalErrorsMgt: Codeunit "Jurnal Errors Sriq ";
        CanCancelApprovalForJnlLine: Boolean;
        CanCancelFlowApprovalForLine: Boolean;
        

    protected var
        IsSimplePage: Boolean;


}


