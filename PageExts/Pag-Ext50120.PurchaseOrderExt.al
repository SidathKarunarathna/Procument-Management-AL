pageextension 50120 PurchaseOrderExt extends "Purchase Order"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("Material Request No.";Rec."Material Request No.")
            {
                ApplicationArea=All;
            }
        }
    }
    
    
}