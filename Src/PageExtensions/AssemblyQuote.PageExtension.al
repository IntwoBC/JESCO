pageextension 50118 "Assemble Quote_Ext" extends "Assembly Quote"
{
    layout
    {
        addafter("Cost Amount")
        {
            field("Total Line Amount"; Rec."Total Line Amount")
            {
                ApplicationArea = All;
            }
        }
    }
}