pageextension 50114 SalesInvoice_Ext extends "Sales Invoice"
{
    layout
    {
        modify("Your Reference")
        {
            Visible = false;
        }
        addafter(Status)
        {
            field("Your Reference 1"; Rec."Your Reference 1")
            {
                ApplicationArea = All;
            }
            field("LC No"; Rec."LC No")
            {
                ApplicationArea = All;
            }
            field("Issueing Bank"; Rec."Issueing Bank")
            {
                ApplicationArea = All;
            }
            field("Our Reference"; Rec."Our Reference")
            {
                ApplicationArea = All;
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
        addafter("LPO Date")
        {
            field("Prepayment No."; Rec."Prepayment No.")
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