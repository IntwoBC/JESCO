pageextension 50106 SalesOrderSubfrm_ext extends "Sales Order Subform"
{
    layout
    {
        addafter("Qty. Assigned")
        {
            field("Bill of Entry No."; Rec."Bill of Entry No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Invoice Disc. Pct.")
        {
            field("Total Open Line Amount"; TotalSalesLine."Open Line Amount")
            {
                ApplicationArea = All;
                Caption = 'Total Open Amount Excl. VAT';
                Editable = false;
            }
        }
    }
    var
        DocumentTotals: Codeunit "Document Totals";
}