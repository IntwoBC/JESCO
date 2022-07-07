pageextension 50127 "Posted Puch Invoices Ext" extends "Posted Purchase Invoices"
{
    layout
    {
        addafter(Amount)
        {
            field("Amount (LCY)"; Rec."Amount (LCY)")
            {
                ApplicationArea = All;
            }
        }
    }
}