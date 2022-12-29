page 50118 "ProcessingMaterialRequestCard"
{
    Caption = 'Processing Material Request Card';
    PageType = Card;
    SourceTable = "Material Request Header";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Request';
    //Editable=false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';

                }
                field("Created Date"; Rec."Created Date")
                {
                    Caption = 'Created Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Used for PO"; Rec."Used for PO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Used for PO field.';
                }



            }

            part("Material Request Line"; "Material Request Line")
            {
                Editable = isEditable;
                SubPageLink = "Reqest No." = field("No.");
                UpdatePropagation = Both;
                ApplicationArea = all;
            }

            group("Requested By Details")
            {
                field("Requested Name"; Rec."Requested Name")
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff No. field.';
                }
                field(Auth; Rec.Auth)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auth field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
            }
            group("Processed By Details")
            {
                field("Processed Name"; Rec."Processed Name")
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Sent for Processing Date"; Rec."Sent for Processing Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sent foe Processing Date field.';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Purchase Order")
            {
                ApplicationArea = All;
                Caption = 'Create Purchase Order';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::"Sent for Processing";

                trigger OnAction()
                var
                    VendorReport: Report "Vendor Selection Report";
                begin
                    VendorReport.GetReqestNo(Rec);
                    VendorReport.Run();
                end;
            }
            // action("Delete zeros")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Delete Zeros';
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedOnly = true;
            //     Image = Delete;
            //     Visible=IsVisible;

            //     trigger OnAction()
            //     var
            //         PurchaseHeader:Record "Purchase Header";
            //         PurchaseLine:Record "Purchase Line";
            //     begin
            //         PurchaseHeader.Reset();
            //         PurchaseLine.Reset();
            //         PurchaseHeader.SetRange("No.",'');
            //         PurchaseHeader.DeleteAll();
            //         PurchaseLine.SetRange("Document No.",'');
            //         PurchaseLine.DeleteAll();
            //         Message('Successfully Deleted');
            //     end;
            // }
        }
    }
    trigger OnOpenPage()

    begin
        if Rec.Status = Rec.Status::Processed then begin
            CurrPage.Caption('Processed Material Request Card');
            IsVisible := false;
        end
        else begin
            CurrPage.Caption('Processing Material Request Card');
            IsVisible := true;
        end;

    end;

    trigger OnAfterGetCurrRecord()
    begin
        IsEditable := CurrPage.Editable;
    end;

    var
        IsEditable: Boolean;
        IsVisible: Boolean;
}
