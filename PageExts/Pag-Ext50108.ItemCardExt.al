pageextension 50108 ItemCardExt extends "Item Card"
{

    layout
    {

        addafter(InventoryGrp)
        {
            group(Procument)
            {

                field("International Vendor Number"; Rec."Internatonal Vendor Number")
                {
                    Caption = 'International Vendor Number';
                    ApplicationArea = All;
                }
                field("ATA(Aircraft Chapter)"; Rec."ATA(Aircraft Chapter)")
                {
                    Caption = 'ATA(Aircraft Chapter)';
                    ApplicationArea = All;
                }
                field("IPC(Reference Number)"; Rec."IPC(Reference Number)")
                {
                    Caption = 'IPC(Reference Number)';
                    ApplicationArea = All;
                }
                field(CMM; Rec.CMM)
                {
                    Caption = 'CMM(Component Maintanace Manual';
                    ApplicationArea = All;
                }
                field("Alternative Part 1"; Rec."Alternative Part 1")
                {
                    Caption = 'Alternative Part 1';
                    ApplicationArea = All;
                }
                field("Alternative Part 2"; Rec."Alternative Part 2")
                {
                    Caption = 'Alternative Part 2';
                    ApplicationArea = All;
                }
                field("Alternative Part 3"; Rec."Alternative Part 3")
                {
                    Caption = 'Alternative Part 3';
                    ApplicationArea = All;
                }
                field("Alternative Part 4"; Rec."Alternative Part 4")
                {
                    Caption = 'Alternative Part 4';
                    ApplicationArea = All;
                }
                field("Type of Spare Part"; Rec."Type of Spare Part")
                {
                    Caption = 'Type of Spare Part';
                    ApplicationArea = All;
                }
                field("Manufacturer Name"; Rec."Manufacturer Name")
                {
                    Caption = 'Manufacturer Name';
                    ApplicationArea = All;
                }
                field("Aircraft Type"; Rec."Aircraft Type")
                {
                    Caption = 'Aircraft Type';
                    ApplicationArea = All;
                }
                field("FA Class Code"; Rec."FA Class Code")
                {
                    Caption = 'FA Class Code';
                    ApplicationArea = All;
                }
                field("FA Subclass"; Rec."FA Subclass")
                {
                    Caption = 'FA Subclass';
                    ApplicationArea = All;
                }
                field("FA Posting Group"; Rec."FA Posting Group")
                {
                    Caption = 'FA Posting Group';
                    ApplicationArea = All;
                }
                field("No. of Depreciation Years"; Rec."No. of Depreciation Years")
                {
                    Caption = 'No. of Depreciation Years';
                    ApplicationArea = All;
                }
                field("Inv. Adj Acc"; Rec."Inv. Adj Acc")
                {
                    Caption = 'Inv.Adj Acc';
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                    ApplicationArea = All;
                }

            }
        }
    }


}