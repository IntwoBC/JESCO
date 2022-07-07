pageextension 50120 ResourceCard_Ext extends "Resource Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("Duplicate Item"; Rec."Duplicate Item")
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