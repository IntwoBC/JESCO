pageextension 50104 PostedSalesInv_Ext extends "Posted Sales Invoice"
{
    layout
    {
        modify("Your Reference")
        {
            Visible = false;
        }
        addafter(Corrective)
        {
            field("Your Reference 1"; Rec."Your Reference 1")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("LC No"; Rec."LC No")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Issueing Bank"; Rec."Issueing Bank")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Our Reference"; Rec."Our Reference")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("LPO Date"; Rec."LPO Date")
            {
                ApplicationArea = All;
            }
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}