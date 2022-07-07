pageextension 50125 "Customer List Ext" extends "Customer List"
{
    layout
    {
        addafter("Location Code")
        {
            field("EORI Number"; Rec."EORI Number")
            {
                ApplicationArea = All;
                Caption = 'Customs Import Code';
            }
        }
    }
}