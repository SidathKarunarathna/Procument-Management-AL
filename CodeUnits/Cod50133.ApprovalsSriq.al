codeunit 50133 "Approvals Sriq"
{
    [IntegrationEvent(false, false)]
    procedure OnSendGeneralJournalLineForApproval(var ItemJournalLine: Record "Item Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnHasOpenApprovalEntriesOnAfterApprovalEntrySetFilters(var ApprovalEntry: Record "Approval Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnHasAnyOpenJournalLineApprovalEntriesOnAfterApprovalEntrySetFilters(var ApprovalEntry: Record "Approval Entry")
    begin
    end;
     [IntegrationEvent(false, false)]
    local procedure OnAfterCanCancelApprovalForRecord(RecID: RecordID; var Result: Boolean; var ApprovalEntry: Record "Approval Entry"; UserSetup: Record "User Setup")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelGeneralJournalLineApprovalRequest(var ItemJournalLine: Record "Item Journal Line")
    begin
    end;


    procedure TrySendJournalLineApprovalRequests(var ItemJournalLine: Record "Item Journal Line")
    var
        LinesSent: Integer;
    begin
        if ItemJournalLine.Count = 1 then
            CheckGeneralJournalLineApprovalsWorkflowEnabled(ItemJournalLine);

        repeat
            if WorkflowManagement.CanExecuteWorkflow(ItemJournalLine,
                 WorkflowEventHandling.RunWorkflowOnSendGeneralJournalLineForApprovalCode) and
               not HasOpenApprovalEntries(ItemJournalLine.RecordId)
            then begin
                OnSendGeneralJournalLineForApproval(ItemJournalLine);
                LinesSent += 1;
            end;
        until ItemJournalLine.Next() = 0;

        case LinesSent of
            0:
                Message(NoApprovalsSentMsg);
            ItemJournalLine.Count:
                Message(PendingApprovalForSelectedLinesMsg);
            else
                Message(PendingApprovalForSomeSelectedLinesMsg);
        end;
    end;

    procedure CheckGeneralJournalLineApprovalsWorkflowEnabled(var ItemJournalLine: Record "Item Journal Line"): Boolean
    begin
        if not
           WorkflowManagement.CanExecuteWorkflow(ItemJournalLine,
             WorkflowEventHandling.RunWorkflowOnSendGeneralJournalLineForApprovalCode)
        then
            Error(NoWorkflowEnabledErr);

        exit(true);
    end;

    procedure HasOpenApprovalEntries(RecordID: RecordID): Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetRange("Table ID", RecordID.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecordID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Related to Change", false);
        OnHasOpenApprovalEntriesOnAfterApprovalEntrySetFilters(ApprovalEntry);
        exit(not ApprovalEntry.IsEmpty);
    end;

    procedure HasAnyOpenJournalLineApprovalEntries(JournalTemplateName: Code[20]; JournalBatchName: Code[20]): Boolean
    var
        ItemJournalLine: Record "Item Journal Line";
        ApprovalEntry: Record "Approval Entry";
        GenJournalLineRecRef: RecordRef;
        GenJournalLineRecordID: RecordID;
    begin
        ApprovalEntry.SetRange("Table ID", DATABASE::"Item Journal Line");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Related to Change", false);
        OnHasAnyOpenJournalLineApprovalEntriesOnAfterApprovalEntrySetFilters(ApprovalEntry);
        if ApprovalEntry.IsEmpty() then
            exit(false);

        ItemJournalLine.SetRange("Journal Template Name", JournalTemplateName);
        ItemJournalLine.SetRange("Journal Batch Name", JournalBatchName);
        if ItemJournalLine.IsEmpty() then
            exit(false);

        if ItemJournalLine.Count < ApprovalEntry.Count then begin
            ItemJournalLine.FindSet();
            repeat
                if HasOpenApprovalEntries(ItemJournalLine.RecordId) then
                    exit(true);
            until ItemJournalLine.Next() = 0;
        end else begin
            ApprovalEntry.FindSet();
            repeat
                GenJournalLineRecordID := ApprovalEntry."Record ID to Approve";
                GenJournalLineRecRef := GenJournalLineRecordID.GetRecord;
                GenJournalLineRecRef.SetTable(ItemJournalLine);
                if (ItemJournalLine."Journal Template Name" = JournalTemplateName) and
                   (ItemJournalLine."Journal Batch Name" = JournalBatchName)
                then
                    exit(true);
            until ApprovalEntry.Next() = 0;
        end;

        exit(false)
    end;

    procedure HasOpenApprovalEntriesForCurrentUser(RecordID: RecordID): Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SetRange("Table ID", RecordID.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecordID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Approver ID", UserId);
        ApprovalEntry.SetRange("Related to Change", false);

        exit(not ApprovalEntry.IsEmpty());
    end;

    procedure CanCancelApprovalForRecord(RecID: RecordID) Result: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId) then
            exit(false);

        ApprovalEntry.SetRange("Table ID", RecID.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", RecID);
        ApprovalEntry.SetFilter(Status, '%1|%2', ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Related to Change", false);

        if not UserSetup."Approval Administrator" then
            ApprovalEntry.SetRange("Sender ID", UserId);
        Result := ApprovalEntry.FindFirst();
        OnAfterCanCancelApprovalForRecord(RecID, Result, ApprovalEntry, UserSetup);
    end;
    procedure TryCancelJournalLineApprovalRequests(var ItemJournalLine: Record "Item Journal Line")
    var
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        repeat
            if HasOpenApprovalEntries(ItemJournalLine.RecordId) then
                OnCancelGeneralJournalLineApprovalRequest(ItemJournalLine);
            WorkflowWebhookManagement.FindAndCancel(ItemJournalLine.RecordId);
        until ItemJournalLine.Next() = 0;
        Message(ApprovalReqCanceledForSelectedLinesMsg);
    end;

    

    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        NoApprovalsSentMsg: Label 'No approval requests have been sent, either because they are already sent or because related workflows do not support the journal line.';
        PendingApprovalForSelectedLinesMsg: Label 'Approval requests have been sent.';
        PendingApprovalForSomeSelectedLinesMsg: Label 'Approval requests have been sent.\\Requests for some journal lines were not sent, either because they are already sent or because related workflows do not support the journal line.';
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        ApprovalReqCanceledForSelectedLinesMsg: Label 'The approval request for the selected record has been canceled.';

}
