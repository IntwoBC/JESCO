pageextension 50121 "UserSetup" extends "User Setup"
{
    layout
    {
        addafter(Email)
        {
            field("Allow Chart Of Account_Jesco"; Rec."Allow Chart Of Account_Jesco")
            {
                ApplicationArea = All;
            }
        }
    }
}