codeunit 50134 "Workflow Management Sriq"
{
     procedure GetCanRequestAndCanCancelJournalBatch(ItemJournalBatch: Record "Item Journal Batch"; var CanRequestBatchApproval: Boolean; var CanCancelBatchApproval: Boolean; var CanRequestLineApprovals: Boolean)
    var
        GenJournalLine: Record "Gen. Journal Line";
        WorkflowWebhookEntry: Record "Workflow Webhook Entry";
    begin
        // Helper method to check the General Journal Batch and all its lines for ability to request/cancel approval.
        // Journal pages' ribbon buttons only let users request approval for the batch or its individual lines, but not both.

        GetCanRequestAndCanCancel(ItemJournalBatch.RecordId, CanRequestBatchApproval, CanCancelBatchApproval);

        GenJournalLine.SetRange("Journal Template Name", ItemJournalBatch."Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", ItemJournalBatch.Name);
        if GenJournalLine.IsEmpty() then begin
            CanRequestLineApprovals := true;
            exit;
        end;

        WorkflowWebhookEntry.SetRange(Response, WorkflowWebhookEntry.Response::Pending);
        if WorkflowWebhookEntry.FindSet() then
            repeat
                if GenJournalLine.Get(WorkflowWebhookEntry."Record ID") then
                    if (GenJournalLine."Journal Batch Name" = ItemJournalBatch.Name) and (GenJournalLine."Journal Template Name" = ItemJournalBatch."Journal Template Name") then begin
                        CanRequestLineApprovals := false;
                        exit;
                    end;
            until WorkflowWebhookEntry.Next() = 0;

        CanRequestLineApprovals := true;
    end;
    procedure GetCanRequestAndCanCancel(RecordId: RecordID; var CanRequestApprovalForFlow: Boolean; var CanCancelApprovalForFlow: Boolean)
    var
        WorkflowWebhookEntry: Record "Workflow Webhook Entry";
    begin
        if FindWorkflowWebhookEntryByRecordIdAndResponse(WorkflowWebhookEntry, RecordId, WorkflowWebhookEntry.Response::Pending) then begin
            CanCancelApprovalForFlow := CanCancel(WorkflowWebhookEntry);
            CanRequestApprovalForFlow := false;
        end else begin
            CanCancelApprovalForFlow := false;
            CanRequestApprovalForFlow := true;
        end;
    end;
    procedure FindWorkflowWebhookEntryByRecordIdAndResponse(var WorkflowWebhookEntry: Record "Workflow Webhook Entry"; RecordId: RecordID; ResponseStatus: Option): Boolean
    begin
        WorkflowWebhookEntry.SetRange("Record ID", RecordId);
        WorkflowWebhookEntry.SetRange(Response, ResponseStatus);

        exit(WorkflowWebhookEntry.FindFirst);
    end;
    procedure CanCancel(WorkflowWebhookEntry: Record "Workflow Webhook Entry"): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        if WorkflowWebhookEntry.Response <> WorkflowWebhookEntry.Response::Pending then
            exit(false);

        if UserSetup.Get(UserId) then
            if UserSetup."Approval Administrator" then
                exit(true);

        exit(WorkflowWebhookEntry."Initiated By User ID" = UserId);
    end;
    
}
