pageextension 50126 "Posted Sales Invoices Ext" extends "Posted Sales Invoices"
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