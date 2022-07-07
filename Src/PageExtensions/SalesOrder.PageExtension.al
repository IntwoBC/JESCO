pageextension 50101 SalesOrder_Ext extends "Sales Order"
{
    layout
    {
        addbefore("Work Description")
        {
            field("Valid Up to"; Rec."Valid Up to")
            {
                ApplicationArea = All;
            }
            field("Delivery Times"; Rec."Delivery Times")
            {
                ApplicationArea = All;
            }
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
        modify("Your Reference")
        {
            Visible = false;
        }
        addafter("External Document No.")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
            field("Last Posting No."; Rec."Last Posting No.")
            {
                ApplicationArea = All;
            }
            field("Shipping No."; Rec."Shipping No.")
            {
                ApplicationArea = All;
            }
            field("Prepayment No."; Rec."Prepayment No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            action(ProformaInv)
            {
                ApplicationArea = All;
                Caption = 'Jesco Proforma Invoice';
                Image = Print;

                trigger OnAction()
                var
                    SalesHeaderL: Record "Sales Header";
                begin
                    SalesHeaderL.SetRange("No.", Rec."No.");
                    SalesHeaderL.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    if SalesHeaderL.FindFirst() then
                        Report.Run(Report::"Jesco Sales-Proforma Invoice", true, true, SalesHeaderL);
                end;
            }
            action(UpdateLines)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category10;
                trigger OnAction()
                var
                    UpdateReport: Report "Sales Order Lines Update";
                begin
                    UpdateReport.Run();
                end;
            }
        }
    }
}
