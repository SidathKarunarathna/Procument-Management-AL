table 50111 "Material Request Line"
{
    Caption = 'Material Request Line';
    DataClassification = ToBeClassified;
    

    fields
    {
        field(1; "Part Number"; Code[20])
        {
            Caption = 'Part Number';
            DataClassification = ToBeClassified;
            TableRelation = Item;
            trigger OnValidate()

            begin

                item.Reset();
                if item.get("Part Number") then begin
                    "Location Code" := item."Location Code";
                    "ALT Part Number" := item."Alternative Part 1";
                    "Aircraft Type" := item."Aircraft Type";
                    Description := item.Description;
                    "Aircraft Chapter" := item."ATA(Aircraft Chapter)";
                    "Reference Number" := item."IPC(Reference Number)";
                end
                else begin
                    "Location Code" := '';
                    "ALT Part Number" := '';
                    "Aircraft Type" := '';
                    Description := '';
                    "Aircraft Chapter" := '';
                    "Reference Number" := '';
                end;
            end;

        }
        field(2; "Reqest No."; Code[20])
        {
            Caption = 'Reqest No.';
            DataClassification = ToBeClassified;
        }
        field(3; "ALT Part Number"; Code[20])
        {
            Caption = 'ALT Part Number';
            DataClassification = ToBeClassified;
        }
        field(4; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(5; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(6; "Aircraft Chapter"; Text[100])
        {
            Caption = 'Aircraft Chapter';
            DataClassification = ToBeClassified;
        }
        field(7; "Reference Number"; Code[20])
        {
            Caption = 'Reference Number';
            DataClassification = ToBeClassified;
        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(9; "Aircraft Type"; Code[20])
        {
            Caption = 'Aircraft Type';
            DataClassification = ToBeClassified;
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Reqest No.", "Line No.")
        {
            Clustered = true;
        }

    }
    var
        item: Record Item;
}
