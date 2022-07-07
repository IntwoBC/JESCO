tableextension 50107 "SalesHeader_Ext" extends "Sales Header"
{
    fields
    {
        field(50000; "Valid Up to"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Caption = 'Valid Up to';
            trigger OnValidate()
            begin
                LeadTimeMgt.CheckLeadTimeIsNotNegative("Valid Up to");
                if Rec."Valid Up to" <> xRec."Valid Up to" then
                    UpdateSalesLinesByFieldNo(FieldNo("Valid Up to"), CurrFieldNo <> 0);
            end;
        }
        field(50001; "Delivery Times"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Caption = 'Delivery Times';
            trigger OnValidate()
            begin
                LeadTimeMgt.CheckLeadTimeIsNotNegative("Delivery Times");
                if Rec."Delivery Times" <> xRec."Delivery Times" then
                    UpdateSalesLinesByFieldNo(FieldNo("Delivery Times"), CurrFieldNo <> 0);
            end;
        }
        field(50002; "Your Reference 1"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Your Reference';
        }
        field(50003; "LC No"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'LC No';
        }
        field(50004; "Issueing Bank"; Code[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Issueing Bank';
        }
        field(50005; "Our Reference"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Our Reference';
        }
        field(50006; "LPO Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'LPO Date';
        }
    }

    var
        LeadTimeMgt: Codeunit "Lead-Time Management";

}