pageextension 50123 GLAccountCard extends "G/L Account Card"
{
    trigger OnOpenPage()
    var
        usersetupL: Record "User Setup";
    begin
        Clear(usersetupL);
        usersetupL.SetRange("User ID", UserId);
        if usersetupL.FindFirst() then begin
            if not usersetupL."Allow Chart Of Account_Jesco" then
                Error('You do not have permissions for accessing Chart of Account');
        end;
    end;
}